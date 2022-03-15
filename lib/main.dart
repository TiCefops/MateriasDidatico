import 'package:cefops2/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:cefops2/app/routes/app_routes.dart';
import 'package:cefops2/app/routes/app_pages.dart';
import 'package:seo_renderer/seo_renderer.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    return GetMaterialApp(
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
        seoRouteObserver
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
