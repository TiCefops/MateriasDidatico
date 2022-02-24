

import 'package:cefops2/app/controller/password_reset_controller.dart';
import 'package:get/get.dart';

class PasswordResetBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PasswordResetController>((){

      return PasswordResetController();
    });
  }

}