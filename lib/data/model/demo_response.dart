import 'package:freezed_annotation/freezed_annotation.dart';

part 'demo_response.freezed.dart';
part 'demo_response.g.dart';

@freezed
class DemoResponse with _$DemoResponse {
  const factory DemoResponse({
    required String status,
    required int code,
    required int total,
    required List<Demo> data,
  }) = _DemoResponse;

  factory DemoResponse.fromJson(Map<String, dynamic> json) =>
      _$DemoResponseFromJson(json);
}

@freezed
class Demo with _$Demo {
  const factory Demo({
    required String title,
    required String author,
    required String genre,
    required String content,
  }) = _Demo;

  factory Demo.fromJson(Map<String, dynamic> json) => _$DemoFromJson(json);
}
