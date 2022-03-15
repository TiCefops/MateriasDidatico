import 'dart:convert';

import 'package:cefops2/app/data/model/home_pop_show_widget_model.dart';
import 'package:cefops2/app/data/repository/data_itens_repository.dart';
import 'package:cefops2/app/data/repository/user_data_info_repository.dart';
import 'package:cefops2/app/routes/app_routes.dart';
import 'package:cefops2/app/widgets/home_pop_show.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final DataItensRepository _repository = DataItensRepository();
  final UserDataInfoRepository _dataUserInfo = UserDataInfoRepository();
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final FirebaseRemoteConfig firebaseRmConfig = FirebaseRemoteConfig.instance;

  @override
  void onInit() {
    if (user == null) {
      Get.toNamed(Routes.INITIAL);
    }
    getCourseID();
    _analytics.setUserId(id: user?.uid);
    super.onInit();
  }

  @override
  void onReady() {
    if (user != null) {
      _fetchSettingsRemote();
    }
    super.onReady();
  }

  RxList userCourseId = [].obs;
  RxBool showAdds = false.obs;

  Future<String> getCourseID() async {
    String uid = user?.uid ?? "";

    DocumentSnapshot data = await _dataUserInfo.getUserInfo(uid);
    List<dynamic> courseList = data.get("cursos");
    courseList.forEach((element) {
      userCourseId.add(element);
    });

    return "ok";
  }

  Future<QuerySnapshot> getCourses() async {
    return _repository.getCourses();
  }

  Future<void> _fetchSettingsRemote() async {
    try {
      await firebaseRmConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await firebaseRmConfig.fetchAndActivate();

      HomePopShowWidgetModel dataAds = HomePopShowWidgetModel.fromJson(
        jsonDecode(
          firebaseRmConfig.getString("Anuncio_Tela_Inicial"),
        ),
      );
      if(dataAds.mostrar==true){
        HomePopShowWidget().showDialog(data: dataAds);
        
      }
    } catch (exception) {
      throw ("Falha ao buscar configuração remota");
    }
  }
}
