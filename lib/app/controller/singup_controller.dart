import 'dart:math';

import 'package:cefops2/app/data/repository/singup_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SingupController extends GetxController {
  SingUpRepository repository = SingUpRepository();
  RxBool loadingPage = false.obs;
  RxBool showPassord = false.obs;

  RxString password = "".obs;
  RxString name = "".obs;
  RxString cpf = "".obs;
  RxString email = "".obs;

  Future<void> singup() async {
    User? user = FirebaseAuth.instance.currentUser;
  String uid=user!.uid;
      await repository.singUp(name.value, cpf.value, email.value, uid);



  }
}
