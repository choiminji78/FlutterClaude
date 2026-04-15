---
name: pr-description
description: This skill should be used when the user asks to "PR 만들어줘", "PR 작성", "PR 설명 써줘", "pull request 생성", "pr-description", or requests to create or draft a GitHub pull request body from recent commits.
argument-hint: "[base-branch=main]"
---

# PR Description

현재 브랜치의 커밋을 분석하여 팀 템플릿에 맞는 GitHub PR body 초안을 작성하고, 사용자 확인 후 PR을 생성한다.

## 핵심 원칙

- **커밋 기반·추측 금지** — 실제 커밋 메시지와 변경 내용만 사용. 의도 불분명 시 질문.
- **팀 템플릿 준수** — `references/pr-template.md` 섹션 구조 그대로 사용.
- **사전 승인** — 초안 출력 후 명시적 승인 전까지 `gh pr create` 실행 금지.

## base branch

`$ARGUMENTS` 브랜치명 제공 시 사용, 없으면 `main`.

## 실행 프로세스

### 1단계: 브랜치 및 커밋 파악

```bash
git branch --show-current
gh pr list --head <current-branch> --state open   # 기존 PR 있으면 URL 안내 후 중단
git log <base>..HEAD --oneline --no-merges
git log <base>..HEAD --format="%H%n%s%n%b%n---" --no-merges
git diff <base>...HEAD --stat | grep -Ev '\.g\.dart|\.freezed\.dart'
```

| 상태 | 처리 |
|---|---|
| 커밋 없음 | 알리고 중단 |
| 커밋 1~10개 | 정상 진행 |
| 커밋 11개+ | 범위 크다고 알리고 계속 여부 확인 |
| 소스 파일 20개+ | PR 분리 먼저 제안, 계속 여부 확인 |

### 2단계: 커밋 파싱

포맷: `<type>(<scope>): <subject>` / body: 빈 줄 이후 (선택)

| 요소 | 추출 방법 | 사용처 |
|---|---|---|
| `type` | `:` 이전 `(` 앞 | PR 제목, 분리 판단 |
| `scope` | `()` 안 값 | What changed bullet 키 |
| `subject` | `:` 이후 텍스트 | What changed 내용 |
| `body` | 빈 줄 이후 텍스트 | Why 섹션 |

**scope → bullet 키:**

| scope | bullet 키 |
|---|---|
| `feature/[name]` | `` `feature/[name]` `` |
| `domain/[name]` | `` `domain/[name]` `` |
| `data/[name]` | `` `data/[name]` `` |
| `core/[module]` | `` `core/[module]` `` |
| `app/[module]` | `` `app/[module]` `` |
| `test/[path]` | `` `test/[path]` `` |
| `config` | `설정` |
| scope 없음 | `git diff --stat` 파일 경로로 레이어 결정 |

같은 scope 커밋 여러 개 → subject를 `, `로 이어 하나의 bullet으로 합침.
Breaking change → 커밋 body의 `BREAKING CHANGE:` 포함 여부 확인.

### 3단계: PR 분리 판단

다음 중 하나라도 해당하면 분리 제안 (권장 구성·순서 포함):

- 독립적인 두 기능 이상 동시 포함
- `refactor` + `feat` 혼재
- 서로 무관한 type 3종류+
- 레이어 4개+ 이면서 각각의 목적이 다른 경우 (단일 기능의 전 레이어 구현은 해당 안 됨)

### 4단계: PR body 초안 작성

`references/pr-template.md` 기준으로 섹션을 채운다.

- **What changed**: scope 기준 bullet. 순서: `domain → data → core → app → feature → test → 설정`. 기술적 사실만, 3~7개 권장.
- **Why**: 커밋 body 우선. Breaking change 있으면 섹션 끝에 `> ⚠️ BREAKING CHANGE:` 명시.
- **How to test**: `- [ ]` 체크리스트. 순서: 실행 방법 → 확인 포인트 → 엣지 케이스 → 자동화 커맨드.

### 5단계: PR 제목

```
[type]([scope]): <subject>   # 단일 type, 단일 scope
[type]: <subject>            # 단일 type, 다수 scope
<subject>                    # 혼재 type
```

50자 이내, 한국어, 명령형.

### 6단계: 초안 출력 및 확인

```
**PR 제목:** <제목>

---
<body 전체>
```

수정 요청 시 해당 부분만 수정 후 전체 body 재출력. PR 생성은 명시적 승인 후에만.

### 7단계: PR 생성

```bash
git push -u origin <current-branch>   # 원격 브랜치 없는 경우
gh pr create \
  --title "<제목>" \
  --base <base-branch> \
  --body "$(cat <<'EOF'
<body>
EOF
)"
```

완료 후 PR URL 출력.
