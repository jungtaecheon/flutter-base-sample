import 'package:flutter_base_template/data/repository/demo/demo_repository.dart';
import 'package:flutter_base_template/data/repository/demo/demo_repository_impl.dart';
import 'package:flutter_base_template/data/repository/demo/demo_simple_repository.dart';
import 'package:flutter_base_template/data/repository/demo/demo_simple_repository_impl.dart';
import 'package:flutter_base_template/foundation/logger.dart';
import 'package:flutter_base_template/ui/pages/demo/demo_repository_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'demo_detail_view_model.g.dart';

@riverpod
class DemoDetailViewModel extends _$DemoDetailViewModel {
  late final DemoRepository _repository;
  late final DemoSimpleRepository _simpleRepository;

  @override
  RepositoryState build() {
    _repository = ref.read(demoRepositoryProvider);
    _simpleRepository = ref.read(demoSimpleRepositoryProvider);
    return const RepositoryState(
        dataFromDemoRepo: "-", dataFromDemoSimpleRepo: 0); // 初期データ
  }

  // データを変更する関数
  Future<void> updateState() async {
    int count = 1;
    try {
      // Repositoryのデータを取得
      final result = await _repository.fetch(count);

      // 取得したデータを利用して状態を更新
      state = state.copyWith(
          dataFromDemoRepo: result.dataOrThrow.data.first.author);
    } catch (error) {
      // エラーハンドリング
      logger.e(error);
      state = state.copyWith(dataFromDemoRepo: "エラー"); // エラー時のデフォルト値
    }
  }

  // データを変更する関数
  Future<void> updateSimpleState() async {
    try {
      // Repositoryのデータを取得
      final result = await _simpleRepository.fetch();
      // 取得したデータを利用して状態を更新
      state = state.copyWith(dataFromDemoSimpleRepo: result.dataOrThrow);
    } catch (error) {
      // エラーハンドリング
      logger.e(error);
      state = state.copyWith(dataFromDemoSimpleRepo: -1); // エラー時のデフォルト値
    }
  }
}
