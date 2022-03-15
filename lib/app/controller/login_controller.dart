import 'package:cefops2/app/data/repository/app_monitor_repository.dart';
import 'package:cefops2/app/erroHandler/auth_handdler.dart';
import 'package:cefops2/shared/themes/app_colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
class LoginController extends GetxController {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final AppMonitorRepository _monitorRepository=AppMonitorRepository();
  final String appVersionLocal="1.1.2";

  RxBool loadingPage = false.obs;
  RxBool showPassord = false.obs;
  RxString errorMessagerForSnack="".obs;
  RxString appVerionSever="1.1.2".obs;

  @override
  void onInit() {
    super.onInit();
    _monitorRepository.getaApInfo().then((value) {
      appVerionSever.value= value.get("versao");

      if(appVersionLocal != appVerionSever.value){
      Get.defaultDialog(title:"Atualização Encontrada",
     buttonColor: AppColors.blue,
      cancelTextColor: Colors.black,
      confirmTextColor: Colors.white,
      content: const SizedBox(),
      onCancel: (){

      },
      onConfirm: (){
        html.window.location.reload();
      },
        textConfirm: "Atualizar",
        textCancel: "Cancelar"
      );


      }

    });

  }


  setErrorMessagerForSnack( String error){
    errorMessagerForSnack.value=AuthHanddler().errorFilter(error);
  }

  Future<void> sendLoginEvent()async{
    await _analytics.logLogin(loginMethod:"EmailAndPassword",  );

  }

}
