import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_template/ui/provider/theme_provider.dart';
import 'package:flutter_base_template/ui/routes/app_router.dart';
import 'package:flutter_base_template/ui/theme/app_theme.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final appRouter = useMemoized(() => AppRouter());

    Intl.defaultLocale = 'ja';

    return MaterialApp.router(
      // デバッグモードを表す帯を出すか
      debugShowCheckedModeBanner: !kReleaseMode,
      // 通常モード時のテーマ
      theme: AppTheme.light().data,
      // ダークモード時のテーマ
      darkTheme: AppTheme.dark().data,
      // テーマモード（ThemeMode.system or ThemeMode.light or ThemeMode.dark）
      themeMode: themeMode,
      localizationsDelegates: const [
        // Flutterのウィジェットに関連するローカライズ
        GlobalWidgetsLocalizations.delegate,
        // Materialデザインのウィジェットに関連するローカライズ
        GlobalMaterialLocalizations.delegate,
        // Cupertinoデザインのウィジェットに関連するローカライズ
        GlobalCupertinoLocalizations.delegate
      ],
      // アプリケーションがサポートするロケール（言語と地域）
      supportedLocales: const [Locale('ja', 'JP')],
      // URLをパースしてアプリケーションの状態に変換
      routeInformationParser: appRouter.defaultRouteParser(),
      // アプリケーションのナビゲーション状態を管理
      routerDelegate: appRouter.delegate(),
    );
  }
}
