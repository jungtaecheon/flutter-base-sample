import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_template/ui/pages/demo/demo_detail_view_model.dart';
import 'package:flutter_base_template/ui/pages/demo/demo_repository_state.dart';
import 'package:flutter_base_template/ui/provider/theme_provider.dart';
import 'package:flutter_base_template/ui/theme/app_text_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class DemoDetailPage extends HookConsumerWidget {
  const DemoDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RepositoryState demoState = ref.watch(demoDetailViewModelProvider);
    final viewModel = ref.read(demoDetailViewModelProvider.notifier);
    final theme = ref.watch(appThemeProvider);
    final isLoading = useState<bool>(false); // useStateでローディング状態を管理
    final updatedApiValue = useState<String?>(null);
    final updatedLocalValue = useState<int?>(null);

    useEffect(() {
      updatedApiValue.value = demoState.dataFromDemoRepo;
      // クリーンアップが不要な場合、明示的にnullをreturn
      return null;
    }, [demoState.dataFromDemoRepo]);

    useEffect(() {
      updatedLocalValue.value = demoState.dataFromDemoSimpleRepo;
      // クリーンアップが不要な場合、明示的にnullをreturn
      return null;
    }, [demoState.dataFromDemoSimpleRepo]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('デモ詳細'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('API: ${demoState.dataFromDemoRepo}',
                style: theme.textTheme.h50.bold()),
            Text('ローカル: ${demoState.dataFromDemoSimpleRepo}',
                style: theme.textTheme.h50.bold()),
            const SizedBox(height: 20),
            if (isLoading.value)
              // ローディングインジケータを表示
              const CircularProgressIndicator()
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // ローディング状態に設定
                      isLoading.value = true;
                      // 状態を更新
                      await viewModel.updateState();
                      // ローディング状態を解除
                      isLoading.value = false;
                    },
                    child: const Text('API'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () async {
                      // ローディング状態に設定
                      isLoading.value = true;
                      // 状態を更新
                      await viewModel.updateSimpleState();
                      // ローディング状態を解除
                      isLoading.value = false;
                    },
                    child: const Text('ローカル'),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            if (updatedApiValue.value != null)
              Text('API: ${updatedApiValue.value}を検知',
                  style: theme.textTheme.h40.comfort()),
            if (updatedLocalValue.value != null)
              Text('ローカル: ${updatedLocalValue.value}を検知',
                  style: theme.textTheme.h40.comfort()),
          ],
        ),
      ),
    );
  }
}
