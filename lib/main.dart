import 'package:flutter/material.dart';
import 'package:flutter_calculator_app/bindings/my_bindings.dart';
import 'package:flutter_calculator_app/screen/main_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: MyBindings(),
      title: "Flutter Calculator",
      home: const MainScreen(),
    );
  }
}
