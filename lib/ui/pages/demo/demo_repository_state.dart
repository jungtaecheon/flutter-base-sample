import 'package:freezed_annotation/freezed_annotation.dart';

part 'demo_repository_state.freezed.dart';
part 'demo_repository_state.g.dart';

@freezed
class RepositoryState with _$RepositoryState {
  const factory RepositoryState({
    required String dataFromDemoRepo,
    required int dataFromDemoSimpleRepo,
  }) = _RepositoryState;

  factory RepositoryState.fromJson(Map<String, dynamic> json) =>
      _$RepositoryStateFromJson(json);
}
