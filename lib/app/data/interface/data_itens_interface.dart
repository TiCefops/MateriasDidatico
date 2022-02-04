
import 'dart:io';

import 'package:cefops2/app/data/model/itens_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IDataItens{

  Future<QuerySnapshot> getCourses ();
  Future<QuerySnapshot>getModules (String course);
  Future<QuerySnapshot>getSubjects(String course,String moduleId);
  Future<String> getPdf (String id);
  Future<String> putPdf (File file);
  Future<String> putCourses (ItensModel data);
  Future<String> putModules (ItensModel data);





}