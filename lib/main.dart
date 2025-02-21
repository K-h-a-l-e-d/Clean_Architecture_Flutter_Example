import 'package:clean_arch_project/app/material_app.dart';
import 'package:flutter/material.dart';
import 'core/dependency_injection/service_locator.dart';

void main() {
  init(); //Initializing Dependency Injection container
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyCustomMaterialApp();
  }
}
