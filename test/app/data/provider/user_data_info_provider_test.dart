
import 'package:cefops2/app/data/interface/user_data_info_interface.dart';
import 'package:cefops2/app/data/provider/user_data_info_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

TestWidgetsFlutterBinding.ensureInitialized();
Firebase.initializeApp();

IUserDataInfo provider =UserDataInfoProvider();

expect("", provider.getUserInfo("IiwU1TVzCOMM4LzLLmL"));



}