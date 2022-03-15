
import 'package:cefops2/app/erroHandler/auth_handdler.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  RxBool loadingPage = false.obs;
  RxBool showPassord = false.obs;
  RxString errorMessagerForSnack="".obs;



  setErrorMessagerForSnack( String error){
    errorMessagerForSnack.value=AuthHanddler().errorFilter(error);
  }

  Future<void> sendLoginEvent()async{
    await _analytics.logLogin(loginMethod:"EmailAndPassword",  );

  }

}
