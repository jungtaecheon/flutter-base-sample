import 'package:auto_route/auto_route.dart';
import 'package:flutter_base_template/ui/pages/demo/demo_detail_page.dart';
import 'package:flutter_base_template/ui/pages/demo/demo_page.dart';
import 'package:flutter_base_template/ui/pages/home/home_page.dart';
import 'package:flutter_base_template/ui/pages/root/root_page.dart';

part 'app_router.gr.dart';

// replaceInRouteName で画面とルートの変換規則を定義
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: RootRoute.page,
          children: [
            AutoRoute(
              page: HomeRoute.page,
            ),
            AutoRoute(initial: true, page: DemoRouterRoute.page, children: [
              AutoRoute(
                initial: true,
                page: DemoRoute.page,
              ),
              AutoRoute(
                page: DemoDetailRoute.page,
              ),
            ]),
          ],
        ),
      ];
}
