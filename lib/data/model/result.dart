import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
abstract class Result<T> with _$Result<T> {
  const Result._();

  const factory Result.success({required T data}) = Success<T>;

  const factory Result.failure({required Exception error}) = Failure<T>;

  /// 例外処理を行い、Resultを返す静的メソッド
  static Result<T> guard<T>(T Function() body) {
    try {
      return Result.success(data: body());
    } on Exception catch (e) {
      return Result.failure(error: e);
    }
  }

  /// 非同期の例外処理を行い、Resultを返す静的メソッド
  static Future<Result<T>> guardFuture<T>(Future<T> Function() future) async {
    try {
      return Result.success(data: await future());
    } on Exception catch (e) {
      return Result.failure(error: e);
    }
  }

  /// 成功かどうかを確認するプロパティ
  bool get isSuccess => when(success: (data) => true, failure: (e) => false);

  /// 失敗かどうかを確認するプロパティ
  bool get isFailure => !isSuccess;

  /// 成功時のデータを取得し、失敗時には例外を投げるプロパティ
  T get dataOrThrow {
    return when(
      success: (data) => data,
      failure: (e) => throw e,
    );
  }
}

/// 任意の型のオブジェクトに対して、Result型に変換するためのユーティリティ
extension ResultObjectExt<T> on T {
  /// 呼び出し元のオブジェクト (this) を成功状態のResultオブジェクトに変換 <br>
  ///
  /// 利用例）
  ///
  /// int data = 42;
  ///
  /// Result<int> successResult = data.asSuccess;
  ///
  /// print(successResult); => Output: Result.success(data: 42)
  Result<T> get asSuccess => Result.success(data: this);

  /// 呼び出し元のオブジェクト (this) を失敗状態のResultオブジェクトに変換。失敗の理由として例外 (Exception) を指定。
  ///
  /// 利用例）
  ///
  /// int data = 42;
  ///
  ///Exception error = Exception("An error occurred");
  ///
  ///Result<int> failureResult = data.asFailure(error);
  ///
  ///print(failureResult); => Output: Result.failure(error: Exception: An error occurred)
  Result<T> asFailure(Exception e) => Result.failure(error: e);
}
