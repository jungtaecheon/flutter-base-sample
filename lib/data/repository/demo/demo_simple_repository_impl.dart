import 'dart:math';
import 'package:flutter_base_template/data/model/result.dart';
import 'package:flutter_base_template/data/repository/demo/demo_simple_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ラインダムな数字を返すのみの処理

final demoSimpleRepositoryProvider =
    Provider<DemoSimpleRepository>((ref) => DemoSimpleRepositoryImpl());

class DemoSimpleRepositoryImpl implements DemoSimpleRepository {
  DemoSimpleRepositoryImpl();

  @override
  Future<Result<int>> fetch() async {
    return Result.guardFuture(() async {
      await Future.delayed(const Duration(seconds: 1)); // 1秒待機
      final rand = Random();
      return rand.nextInt(100); // 0~100の乱数
    });
  }
}
