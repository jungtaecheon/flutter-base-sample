import 'package:dio/dio.dart';
import 'package:flutter_base_template/data/model/demo_response.dart';
import 'package:retrofit/retrofit.dart';

part 'demo_api_client.g.dart';

@RestApi(baseUrl: "https://fakerapi.it/api/v1/texts")
abstract class DemoApiClient {
  factory DemoApiClient(Dio dio, {String baseUrl}) = _DemoApiClient;

  @GET("/")
  Future<DemoResponse> fetchData(
    @Query("_quantity") int count,
  );
}
