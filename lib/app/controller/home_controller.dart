import 'package:cefops2/app/data/repository/data_itens_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  DataItensRepository repository = DataItensRepository();

  Future<QuerySnapshot> getCourses() async {
    return repository.getCourses();
  }
}
