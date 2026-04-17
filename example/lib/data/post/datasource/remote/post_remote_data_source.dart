import 'package:flutter_claude/core/network/http/dto/api_response.dart';
import 'package:flutter_claude/core/network/http/service/api_service.dart';
import 'package:flutter_claude/data/post/dto/request/post_request_dto.dart';
import 'package:flutter_claude/data/post/dto/response/post_response_dto.dart';

abstract class PostRemoteDataSource {
  Future<ApiResponse<PostResponseDto>> createPost({
    required PostRequestDto request,
  });
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  const PostRemoteDataSourceImpl({required this.apiService});
  final ApiService apiService;

  @override
  Future<ApiResponse<PostResponseDto>> createPost({
    required PostRequestDto request,
  }) =>
      apiService.post(
        '/posts',
        PostResponseDto.fromJson,
        body: request.toJson(),
      );
}
