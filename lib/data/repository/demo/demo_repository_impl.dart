import 'package:dio/dio.dart';
import 'package:flutter_base_template/data/model/demo_response.dart';
import 'package:flutter_base_template/data/model/result.dart';
import 'package:flutter_base_template/data/remote/app_dio.dart';
import 'package:flutter_base_template/data/remote/demo/demo_api_client.dart';
import 'package:flutter_base_template/data/repository/demo/demo_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final demoRepositoryProvider = Provider<DemoRepository>((ref) {
  final dio = ref.read(dioProvider);
  return DemoRepositoryImpl(dio);
});

class DemoRepositoryImpl implements DemoRepository {
  final Dio _dio;

  DemoRepositoryImpl(this._dio);

  @override
  Future<Result<DemoResponse>> fetch(count) async {
    final apiClient = DemoApiClient(_dio);

    return Result.guardFuture(() async {
      final response = await apiClient.fetchData(count);
      return response;
    });
  }
}
