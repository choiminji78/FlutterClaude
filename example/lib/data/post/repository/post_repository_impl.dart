import 'package:flutter_claude/data/common/mapper/exception_mapper.dart';
import 'package:flutter_claude/data/post/datasource/remote/post_remote_data_source.dart';
import 'package:flutter_claude/data/post/dto/request/post_request_dto.dart';
import 'package:flutter_claude/data/post/mapper/post_mapper.dart';
import 'package:flutter_claude/domain/common/entity/app_result.dart';
import 'package:flutter_claude/domain/post/entity/post_entity.dart';
import 'package:flutter_claude/domain/post/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  const PostRepositoryImpl({
    required this.remoteDataSource,
    required this.mapper,
    required this.exceptionMapper,
  });

  final PostRemoteDataSource remoteDataSource;
  final PostMapper mapper;
  final ExceptionMapper exceptionMapper;

  @override
  Future<AppResult<PostEntity>> createPost({
    required int userId,
    required String title,
    required String body,
  }) async {
    final request = PostRequestDto(userId: userId, title: title, body: body);
    final response = await remoteDataSource.createPost(request: request);
    return response.when(
      success: (dto) => AppResult.success(mapper.toDomain(dto)),
      failure: (e) => AppResult.failure(exceptionMapper.map(e)),
    );
  }
}
