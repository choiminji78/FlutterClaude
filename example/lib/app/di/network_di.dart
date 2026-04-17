import 'package:flutter_claude/core/network/http/client/jsonplaceholder_api_client.dart';
import 'package:flutter_claude/core/network/http/service/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_di.g.dart';

@Riverpod(keepAlive: true)
ApiService jsonplaceholderApiService(JsonplaceholderApiServiceRef ref) {
  return ApiService(client: JsonplaceholderApiClient());
}
