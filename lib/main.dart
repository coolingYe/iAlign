import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:ialign/routes/app_pages.dart';
import 'package:window_size/window_size.dart';

import 'bindings/initial_binding.dart';

void main() {
  runApp(const MyApp());
  setWindowSize();
}

void setWindowSize() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    setWindowMinSize(const Size(1440, 720));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              initialRoute: AppPages.initial,
              initialBinding: InitialBinding(),
              getPages: AppPages.routes,
              defaultTransition: Transition.noTransition,
            );
  }
}
