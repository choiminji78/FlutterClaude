import 'package:flutter_claude/app/di/network_di.dart';
import 'package:flutter_claude/data/common/mapper/exception_mapper.dart';
import 'package:flutter_claude/data/post/datasource/remote/post_remote_data_source.dart';
import 'package:flutter_claude/data/post/mapper/post_mapper.dart';
import 'package:flutter_claude/data/post/repository/post_repository_impl.dart';
import 'package:flutter_claude/domain/post/repository/post_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_di.g.dart';

@Riverpod(keepAlive: true)
PostRemoteDataSource postRemoteDataSource(PostRemoteDataSourceRef ref) {
  return PostRemoteDataSourceImpl(
    apiService: ref.read(jsonplaceholderApiServiceProvider),
  );
}

@Riverpod(keepAlive: true)
PostRepository postRepository(PostRepositoryRef ref) {
  return PostRepositoryImpl(
    remoteDataSource: ref.read(postRemoteDataSourceProvider),
    mapper: const PostMapper(),
    exceptionMapper: const ExceptionMapper(),
  );
}
