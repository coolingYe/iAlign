
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:ialign/ui/main_view.dart';

import '../ui/bindings/main_binding.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.mainPage;

  static final routes = [
    GetPage(
      name: _Paths.mainPage,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
  ];
}

abstract class Routes {
  Routes._();
  static const mainPage = _Paths.mainPage;
}

abstract class _Paths {
  static const mainPage = '/main';
}