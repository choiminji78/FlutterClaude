---
name: code-commit
description: This skill should be used when the user asks to "커밋", "커밋해줘", "commit", "변경사항 저장", "git commit", "커밋 메시지 작성", "스테이징하고 커밋", or requests to commit staged or unstaged changes to git.
---

# Code Commit

변경 사항을 분석하고 프로젝트 규칙에 맞는 커밋 메시지를 작성하여 안전하게 커밋한다.

---

## 핵심 원칙

1. **명확한 메시지** — "무엇을"이 아닌 "왜"를 중심으로 작성한다.
2. **원자적 커밋** — 하나의 커밋은 하나의 논리적 변경만 포함한다. 관련 없는 변경이 섞여 있으면 사용자에게 알린다.
3. **추측 금지** — 변경 의도가 불분명하면 커밋 전 사용자에게 확인한다.

---

## 커밋 메시지 포맷

```
<type>(<scope>): <subject>

<body> (선택)
```

- **subject**: 한국어, 명령형("추가", "수정", "제거"), 50자 이내, 마침표 없음
- **body**: 변경 이유가 불분명하거나 아키텍처 결정 설명이 필요할 때만 작성. 72자 줄바꿈
- **Breaking Change**: 공개 인터페이스 변경 시 body에 `BREAKING CHANGE:` 명시

```
❌ 홈 화면에 피드 조회 기능을 추가했습니다.
✅ 홈 화면 피드 조회 기능 추가
```

### Type 정의

| type | 사용 조건 |
|---|---|
| `feat` | 새로운 기능 추가 |
| `fix` | 버그 수정 |
| `refactor` | 동작 변경 없는 코드 구조 개선 |
| `test` | 테스트 코드 추가 또는 수정 |
| `docs` | 문서, 주석 변경 (코드 변경 없음) |
| `chore` | 빌드 설정, 패키지, CI 등 기타 변경 |
| `style` | 포맷, 들여쓰기 등 코드 스타일만 변경 |
| `perf` | 성능 개선 |
| `build` | 빌드 시스템, 의존성 변경 |
| `ci` | CI/CD 파이프라인 변경 |
| `revert` | 이전 커밋 되돌리기 |

### Scope 기준

| 변경 대상 | scope | 커밋 예시 |
|---|---|---|
| `feature/[feature]` | `feature/home` | `feat(feature/home): 홈 피드 무한 스크롤 기능 추가` |
| `domain/[domain]` | `domain/user` | `feat(domain/user): GetCurrentUserUseCase 추가` |
| `data/[domain]` | `data/user` | `feat(data/user): UserRemoteDataSource API 연동 추가` |
| `core/*` | `core/network` 등 | `fix(core/storage): HiveDatabaseService 초기화 순서 오류 수정` |
| `app/*` | `app/di` 등 | `refactor(app/di): DI 등록 순서 재정렬` |
| 여러 레이어 동시 | 최상위 레이어 또는 생략 | `feat: 사용자 프로필 조회 기능 추가` |
| 프로젝트 설정 | `config` | `build: android minSdk 26 설정` |
| 테스트만 | `test/[대상]` | `test(domain/user): GetCurrentUserUseCase 단위 테스트 추가` |

---

## 실행 프로세스

### 1단계: 상태 파악

```
git status        → 스테이징 여부 및 변경 파일 목록 확인
git diff --cached → 스테이징된 변경사항 확인
git diff          → 미스테이징 변경사항 확인
git log -5        → 최근 커밋 메시지 스타일 파악
```

### 2단계: 변경 분석

- 변경된 레이어 파악 (feature / domain / data / core / app)
- 변경 유형 분류 (신규 기능 / 버그 수정 / 리팩토링 / 테스트 / 설정 등)
- 민감 파일 포함 여부 확인
- 생성 파일(`.g.dart`, `.freezed.dart`) 처리:
  - 소스 파일 변경에 대응하는 생성 파일이 없으면 → `build_runner` 실행 필요 여부 확인
  - 생성 파일은 소스 파일과 같은 커밋에 포함
  - 생성 파일만 단독 변경 → 의도 확인
- 논리적 분리 필요 여부:

  **1) 변경 성격 파악**
  - 기존 심볼 변경(rename, 파일 이동, 시그니처 수정) → 참조 파일 전체가 동시 수정 필요 → **하나의 원자적 커밋**
  - 신규 추가(additive)만 → 2)로

  **2) import 관계 확인**
  - 독립적 → 분리 커밋 가능
  - A가 B에 의존 → B 먼저 커밋 → A 커밋
  - 강결합 → 하나의 원자적 커밋

  분리 시: 사용자 확인 → 첫 번째 논리 단위 스테이징 → 커밋 → 반복

### 3단계: 스테이징 및 커밋

- `git add <file>` (개별 파일 스테이징)
- HEREDOC 형식으로 커밋

```bash
git commit -m "$(cat <<'EOF'
<type>(<scope>): <subject>

<body>
EOF
)"
```

### 4단계: 결과 확인

```
git status
git log -1 --oneline
```
