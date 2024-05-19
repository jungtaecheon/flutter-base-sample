import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_template/ui/hooks/use_router.dart';
import 'package:flutter_base_template/ui/provider/theme_provider.dart';
import 'package:flutter_base_template/ui/routes/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

@RoutePage()
class DemoPage extends HookConsumerWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = useRouter();
    final theme = ref.watch(appThemeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('デモ'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => context.navigateTo(const HomeRoute()),
                  child: const Text('ホーム'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => router.push(const DemoDetailRoute()),
                  child: const Text('デモ詳細'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const TextField(),
            Text(
              DateFormat.yMEd().format(DateTime.now()),
              style: theme.textTheme.h50.copyWith(color: Colors.greenAccent),
            ),
            Text(
              theme.mode.toString(),
              style: theme.textTheme.h30,
            ),
          ],
        ),
      ),
    );
  }
}

@RoutePage()
class DemoRouterPage extends AutoRouter {
  const DemoRouterPage({super.key});
}
