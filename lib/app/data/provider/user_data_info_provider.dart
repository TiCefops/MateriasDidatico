
import 'package:cefops2/app/controller/home_controller.dart';
import 'package:cefops2/app/data/interface/user_data_info_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserDataInfoProvider implements IUserDataInfo{
  @override
  Future<DocumentSnapshot> getUserInfo(String uid) async{
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    return snapshot;
  }
}