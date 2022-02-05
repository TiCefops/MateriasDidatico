import 'package:cefops2/app/controller/user_info_controller.dart';
import 'package:cefops2/app/data/model/user_info_model.dart';
import 'package:cefops2/app/data/repository/data_itens_repository.dart';
import 'package:cefops2/app/data/repository/user_data_info_repository.dart';
import 'package:cefops2/app/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final DataItensRepository _repository = DataItensRepository();
  final UserDataInfoRepository _dataUserInfo=UserDataInfoRepository();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    if (user == null) {
      Get.toNamed(Routes.INITIAL);
    }
    getCourseID();
    super.onInit();
  }

  RxList userCourseId=[].obs;

  Future<String> getCourseID()async{
    String uid=user?.uid??"";

    DocumentSnapshot data=await _dataUserInfo.getUserInfo(uid);
    List<dynamic>  courseList=data.get("cursos");
    courseList.forEach((element) {
      userCourseId.add(element);

    });

    return "ok";

  }

  Future<QuerySnapshot> getCourses() async {
    return _repository.getCourses();
  }
}
