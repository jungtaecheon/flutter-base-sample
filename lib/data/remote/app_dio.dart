import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_base_template/foundation/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:convert';
import 'package:http_mock_adapter/http_mock_adapter.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  dio.options = BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  );

  // UA-CH headersの設定
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers.addAll({
          'User-Agent': 'Your User Agent',
          'Sec-CH-UA': 'Your CH-UA',
          // 他の必要なUA-CHヘッダをここに追加
        });
        return handler.next(options);
      },
    ),
  );

  // FIXME: （暫定対応）defaultValueで、Mockを使うか設定する
  const useMockData =
      String.fromEnvironment('USE_MOCK_DATA', defaultValue: 'false');
  // FIXME: dioは１つなので、APIごとに設定できるように修正する
  if (useMockData == 'true') {
    logger.d("====== Using Mock Data ======");
    final dioAdapter = DioAdapter(dio: dio);
    dioAdapter.onGet('/', (server) async {
      final mockData = await rootBundle
          .loadString('assets/remote_mock_data/demo/mock_data.json');
      final jsonData = json.decode(mockData);
      server.reply(200, jsonData);
    });
    dio.httpClientAdapter = dioAdapter;
  }

  return dio;
});
