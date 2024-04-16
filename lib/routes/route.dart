import 'package:blog_app/routes/route_names.dart';
import 'package:get/route_manager.dart';
import '../pages/home_page/binding/home_binding.dart';
import '../pages/home_page/view/home.dart';

class Routes {
  static final routes = [
    GetPage(
      name: RoutesName.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
