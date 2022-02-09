
import 'package:cefops2/app/erroHandler/auth_handdler.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  RxBool loadingPage = false.obs;
  RxBool showPassord = false.obs;
  RxString errorMessagerForSnack="".obs;



  setErrorMessagerForSnack( String error){
    errorMessagerForSnack.value=AuthHanddler().errorFilter(error);
  }

}
