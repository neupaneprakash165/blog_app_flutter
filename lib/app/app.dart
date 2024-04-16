
import 'package:blog_app/pages/home_page/binding/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/route.dart';
import '../routes/route_names.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Blog App',
      initialBinding: HomeBinding(),
      getPages: Routes.routes,
      initialRoute: RoutesName.home,
      debugShowCheckedModeBanner: false,
    );
  }
}
