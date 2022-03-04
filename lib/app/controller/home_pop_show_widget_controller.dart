import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

class HomePopShowWidgetController extends GetxController {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;




  Future<void> courSelect(
      {required String courseName, required String status}) async {
    await _analytics.logEvent(
        name:"Cliques em cursos livres",
      parameters: {
        "content_type": "button",
        "item_name":courseName,
        "item_staus":status
      }
    );

  }
}
