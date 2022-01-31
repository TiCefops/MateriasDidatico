
import 'dart:io';

import 'package:cefops2/app/data/interface/data_itens_interface.dart';
import 'package:cefops2/app/data/model/itens_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataItensProvider implements IDataItens{


  @override
  Future<QuerySnapshot> getCourses() async{
    QuerySnapshot snapshot=  await FirebaseFirestore.instance.
    collection("cursos").get();

    return snapshot;
  }

  @override
  Future<String> getModules() {
    // TODO: implement getModules
    throw UnimplementedError();
  }

  @override
  Future<String> getPdf(String id) {
    // TODO: implement getPdf
    throw UnimplementedError();
  }

  @override
  Future<String> putCourses(ItensModel data) {
    // TODO: implement putCourses
    throw UnimplementedError();
  }

  @override
  Future<String> putModules(ItensModel data) {
    // TODO: implement putModules
    throw UnimplementedError();
  }

  @override
  Future<String> putPdf(File file) {
    // TODO: implement putPdf
    throw UnimplementedError();
  }
  
}