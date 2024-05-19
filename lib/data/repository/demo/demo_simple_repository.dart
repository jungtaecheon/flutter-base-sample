import 'package:flutter_base_template/data/model/result.dart';

abstract class DemoSimpleRepository {
  Future<Result<int>> fetch();
}
