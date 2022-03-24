

import 'package:cefops2/app/data/repository/app_monitor_repository.dart';
import 'package:cefops2/app/erroHandler/auth_handdler.dart';
import 'package:cefops2/app/routes/app_routes.dart';
import 'package:cefops2/app/security/encrypt_service.dart';
import 'package:cefops2/shared/auth/firebase_auth.dart';
import 'package:cefops2/shared/themes/app_colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginController extends GetxController {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final AppMonitorRepository _monitorRepository = AppMonitorRepository();
  final User? user = FirebaseAuth.instance.currentUser;

  final String appVersionLocal = "1.1.2";

  RxBool loadingPage = false.obs;
  RxBool stayConnected = false.obs;
  RxBool showPassord = false.obs;
  RxString errorMessagerForSnack = "".obs;
  RxString appVerionSever = "1.1.2".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await dotenv.load();
    versionCheck();
    final prefs = await SharedPreferences.getInstance();
    String? localData = prefs.getString("data001");
    if(localData!=null){
      EncyptService().readLocalDatabaseDecryptAndLogin();
    }

  }

  ///seta a menssagem que sera mostrada no snackbar
  setErrorMessagerForSnack(String error) {
    errorMessagerForSnack.value = AuthHanddler().errorFilter(error);
  }

  ///envia o evento de login para o analytics
  Future<void> sendLoginEvent() async {
    await _analytics.logLogin(
      loginMethod: "EmailAndPassword",
    );
  }

  ///mostra popup para atualizar a versão do app
  Future<void> versionCheck() async {
    _monitorRepository.getaApInfo().then(
      (value) {
        appVerionSever.value = value.get("versao");

        if (appVersionLocal != appVerionSever.value) {
          Get.defaultDialog(
              title: "Atualização Encontrada",
              buttonColor: AppColors.blue,
              cancelTextColor: Colors.black,
              confirmTextColor: Colors.white,
              content: const SizedBox(),
              onCancel: () {},
              onConfirm: () {
                if (GetPlatform.isWeb) {

                } else {}
              },
              textConfirm: "Atualizar",
              textCancel: "Cancelar");
        }
      },
    );
  }

  Future<void> login(String email, String passowrd) async {

    await AuthenticationHelper()
        .signIn(email: email, password: passowrd)
        .then((result) async {
      if (result == null) {
        sendLoginEvent();
        loadingPage.value = false;
        EncyptService().
        encryptAndSave(user: email, password: passowrd);
        Get.offAndToNamed(Routes.HOME);
      } else {
        loadingPage.value = false;

        setErrorMessagerForSnack(result);
        Get.snackbar("Falha na Autenticação", errorMessagerForSnack.value);
      }
    });
  }




}
