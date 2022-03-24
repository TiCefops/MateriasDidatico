
import 'dart:convert';
import 'package:cefops2/app/controller/login_controller.dart';
import 'package:cefops2/app/data/model/local_data_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as crypto;

class EncyptService{


  void encryptAndSave({required String user, required String password}) async {
    final prefs = await SharedPreferences.getInstance();
    final key = crypto.Key.fromUtf8(
        dotenv.get('CRYPTO_DATA_KEY', fallback: 'API_URL not found'));
    final keyForHead = crypto.Key.fromUtf8(
        dotenv.get('CRYPTO_HEAD_KEY', fallback: 'API_URL not found'));
    final iv = crypto.IV.fromLength(16);
    final encrypterData = crypto.Encrypter(crypto.AES(key));

    final encrypterHead = crypto.Encrypter(crypto.AES(keyForHead));

    final userEncrypted = encrypterData.encrypt(user, iv: iv);
    final passwordEncrypted = encrypterData.encrypt(password, iv: iv);
    final dateEncrypted =
    encrypterData.encrypt(DateTime.now().toIso8601String(), iv: iv);

    Map<String, dynamic> dataModel = {
      'datat': dateEncrypted.base64,
      'datau': userEncrypted.base64,
      'datap': passwordEncrypted.base64
    };

    String data = json.encode(dataModel);
    final dataEncrypted = encrypterHead.encrypt(data, iv: iv);
    prefs.setString("data001", dataEncrypted.base64);

  }
  Future<void> readLocalDatabaseDecryptAndLogin() async {
    final LoginController controller= Get.find();
    final key = crypto.Key.fromUtf8(
        dotenv.get('CRYPTO_DATA_KEY', fallback: 'API_URL not found'));
    final keyForHead = crypto.Key.fromUtf8(
        dotenv.get('CRYPTO_HEAD_KEY', fallback: 'API_URL not found'));
    final iv = crypto.IV.fromLength(16);
    final decryptLocalData = crypto.Encrypter(crypto.AES(key));
    final decryptHead = crypto.Encrypter(crypto.AES(keyForHead));

    final prefs = await SharedPreferences.getInstance();
    String? localData = prefs.getString("data001");

    Map<String, dynamic> jsonData =
    json.decode(decryptHead.decrypt64(localData!, iv: iv));

    LocalDataModel data = LocalDataModel.fromJson(jsonData);
    String? user = data.datau;
    String? password = data.datap;
    String? time = data.datat;

    final userDecrypted = decryptLocalData.decrypt64(user, iv: iv);
    final passwordDecrypted = decryptLocalData.decrypt64(password, iv: iv);

    DateTime timeDecrypted =
    DateTime.parse(decryptLocalData.decrypt64(time, iv: iv));
    DateTime validateHorous = timeDecrypted.add(const Duration(hours: 4));
    if (DateTime.now().isAfter(validateHorous)) {
      prefs.remove("data001");
    } else {
      controller.login(userDecrypted, passwordDecrypted)
          .onError((error, stackTrace) => prefs.remove("data001"));
    }
  }
}