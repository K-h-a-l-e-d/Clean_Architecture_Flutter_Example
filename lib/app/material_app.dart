import 'package:clean_arch_project/core/dependency_injection/service_locator.dart';
import 'package:clean_arch_project/features/user/presentation/bloc/user_bloc.dart';
import 'package:clean_arch_project/features/user/presentation/pages/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCustomMaterialApp extends StatelessWidget {
  const MyCustomMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: BlocProvider(
        //using a DI singleton in order to get a UserBloc instance
        //also adhering SOLID principles where,
        //MyApp (high-level module) shouldn't depend on Bloc(low-level) module
        create: (context) => sl<UserBloc>(),
        child: const UserScreen(),
      ),
    );
  }
}
