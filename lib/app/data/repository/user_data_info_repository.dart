import 'package:cefops2/app/data/interface/user_data_info_interface.dart';
import 'package:cefops2/app/data/provider/user_data_info_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataInfoRepository implements IUserDataInfo{
  UserDataInfoProvider provider=UserDataInfoProvider();
  @override
  Future<DocumentSnapshot> getUserInfo(String uid) {
   return provider.getUserInfo(uid);
  }
}