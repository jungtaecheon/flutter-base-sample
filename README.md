# flutter_base_template

## ■ 初回環境設定

### 1. flutter バージョン

#### 前提

[fvm](https://fvm.app/) コマンドを用意する

#### コマンドライン実行

プロジェクトで利用する Flutter をセットアップ

```sh
$ fvm install --setup
```

自動生成ファイル作成

```sh
$ fvm flutter pub run build_runner build --delete-conflicting-outputs
```

### 2. パッケージ

（必要な場合のみ）キャッシュをクリア

```
$ fvm flutter clean
```

`pubspec.yaml`に定義されているパッケージをインストール

```
$ fvm flutter pub get
```

## ■ flutter バージョン管理

プロジェクトで利用する flutter のバージョンを変更する場合のみ実施

```sh
# リリースバージョン確認
$ fvm releases
# バージョン変更
$ fvm use {バージョン}
```
