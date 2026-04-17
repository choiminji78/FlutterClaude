import 'package:flutter_claude/core/network/exception/network_exception.dart';
import 'package:flutter_claude/core/network/http/dto/api_response.dart';
import 'package:flutter_claude/data/common/mapper/exception_mapper.dart';
import 'package:flutter_claude/data/post/datasource/remote/post_remote_data_source.dart';
import 'package:flutter_claude/data/post/dto/request/post_request_dto.dart';
import 'package:flutter_claude/data/post/dto/response/post_response_dto.dart';
import 'package:flutter_claude/data/post/mapper/post_mapper.dart';
import 'package:flutter_claude/data/post/repository/post_repository_impl.dart';
import 'package:flutter_claude/domain/common/entity/app_result.dart';
import 'package:flutter_claude/domain/post/entity/post_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'post_repository_impl_test.mocks.dart';

@GenerateMocks([PostRemoteDataSource])
void main() {
  late PostRepositoryImpl repository;
  late MockPostRemoteDataSource mockDataSource;

  setUp(() {
    provideDummy<ApiResponse<PostResponseDto>>(
      const ApiResponse.success(
        PostResponseDto(id: 0, userId: 0, title: '', body: ''),
      ),
    );
    mockDataSource = MockPostRemoteDataSource();
    repository = PostRepositoryImpl(
      remoteDataSource: mockDataSource,
      mapper: const PostMapper(),
      exceptionMapper: const ExceptionMapper(),
    );
  });

  group('PostRepositoryImpl', () {
    const userId = 1;
    const title = '테스트 제목';
    const body = '테스트 내용';

    group('createPost', () {
      test('성공 시 PostEntity를 AppSuccess로 반환한다', () async {
        const responseDto = PostResponseDto(
          id: 101,
          userId: userId,
          title: title,
          body: body,
        );
        when(
          mockDataSource.createPost(
            request: PostRequestDto(userId: userId, title: title, body: body),
          ),
        ).thenAnswer((_) async => const ApiResponse.success(responseDto));

        final result = await repository.createPost(
          userId: userId,
          title: title,
          body: body,
        );

        result.when(
          success: (post) {
            expect(post.id, 101);
            expect(post.userId, userId);
            expect(post.title, title);
            expect(post.body, body);
          },
          failure: (_) => fail('success 기대'),
        );
      });

      test('네트워크 오류 시 AppFailure(network)를 반환한다', () async {
        when(
          mockDataSource.createPost(
            request: PostRequestDto(userId: userId, title: title, body: body),
          ),
        ).thenAnswer(
          (_) async => const ApiResponse.failure(
            NetworkException.network('연결 실패'),
          ),
        );

        final result = await repository.createPost(
          userId: userId,
          title: title,
          body: body,
        );

        result.when(
          success: (_) => fail('failure 기대'),
          failure: (e) => e.when(
            network: (msg) => expect(msg, '연결 실패'),
            server: (_, __) => fail('network 기대'),
            unauthorized: (_) => fail('network 기대'),
            forbidden: (_) => fail('network 기대'),
            notFound: (_) => fail('network 기대'),
            timeout: (_) => fail('network 기대'),
            unknown: (_) => fail('network 기대'),
          ),
        );
      });

      test('서버 오류(500) 시 AppFailure(server)를 반환한다', () async {
        when(
          mockDataSource.createPost(
            request: PostRequestDto(userId: userId, title: title, body: body),
          ),
        ).thenAnswer(
          (_) async => const ApiResponse.failure(
            NetworkException.server(500, '내부 서버 오류'),
          ),
        );

        final result = await repository.createPost(
          userId: userId,
          title: title,
          body: body,
        );

        expect(result, isA<AppFailure<PostEntity>>());
      });

      test('타임아웃 시 AppFailure(timeout)를 반환한다', () async {
        when(
          mockDataSource.createPost(
            request: PostRequestDto(userId: userId, title: title, body: body),
          ),
        ).thenAnswer(
          (_) async => const ApiResponse.failure(
            NetworkException.timeout('요청 시간 초과'),
          ),
        );

        final result = await repository.createPost(
          userId: userId,
          title: title,
          body: body,
        );

        expect(result, isA<AppFailure<PostEntity>>());
      });
    });
  });
}
