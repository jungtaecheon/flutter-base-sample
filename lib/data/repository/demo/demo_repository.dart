import 'package:flutter_base_template/data/model/demo_response.dart';
import 'package:flutter_base_template/data/model/result.dart';

abstract class DemoRepository {
  Future<Result<DemoResponse>> fetch(count);
}
