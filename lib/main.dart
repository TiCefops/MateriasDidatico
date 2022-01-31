import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:cefops2/app/routes/app_routes.dart';
import 'package:cefops2/app/routes/app_pages.dart';


void main()async {
  runApp(const MyApp());
   await Firebase.initializeApp(
  );

}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.HOME,
      getPages:AppPages.routes,
    );
  }
}