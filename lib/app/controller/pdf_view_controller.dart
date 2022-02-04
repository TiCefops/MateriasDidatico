import 'package:cefops2/app/data/model/user_info_model.dart';
import 'package:cefops2/app/data/repository/user_data_info_repository.dart';
import 'package:cefops2/app/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PdfViewerControllerUi extends GetxController{
  final UserDataInfoRepository _repository = UserDataInfoRepository();

  User? user=FirebaseAuth.instance.currentUser;

  @override
  void onInit() {

    if (user == null) {
      Get.toNamed(Routes.INITIAL);
    }
    getUserInfo();
    super.onInit();
  }


  RxString userCpf="".obs;
  RxString userName = "".obs;
  RxString password="O2!iGi%IL6H6Ob0yByjK".obs;

  Future<DocumentSnapshot> getUserInfo() async {
    String uid = user?.uid ?? "";
    DocumentSnapshot snapshot =
    await _repository.getUserInfo(uid);
    var data = snapshot.data();

    UserInfoModel userInfoModel = UserInfoModel.fromJson(data);
    userName.value = userInfoModel.nome!;
    userCpf.value = userInfoModel.cpf!;
    return snapshot;
  }

  void setCpf(){


  }

}