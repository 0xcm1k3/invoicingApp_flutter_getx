import 'package:fatura_app/env/routing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(scaffoldBackgroundColor: Colors.white),
    // home: TestScreen(),
    initialRoute: "/",
    getPages: AppRouting.ROUTES,
  ));
}
