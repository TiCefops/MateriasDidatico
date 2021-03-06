
import 'package:cefops2/app/data/repository/data_itens_repository.dart';
import 'package:cefops2/app/data/repository/user_data_info_repository.dart';
import 'package:cefops2/app/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class ModuleController extends GetxController{
  DataItensRepository repository = DataItensRepository();
  final UserDataInfoRepository _userApp=UserDataInfoRepository();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Future<void> onInit() async {
    if (user == null) {

        Get.offAndToNamed(Routes.INITIAL);


    }
    _userApp.getUserInfo(user?.uid??"");
    super.onInit();
  }


  Future<QuerySnapshot> getModules(String id)async{

    return repository.getModules(id);

  }

}