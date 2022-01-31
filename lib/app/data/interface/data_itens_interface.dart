
import 'dart:io';

import 'package:cefops2/app/data/model/itens_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IDataItens{

  Future<QuerySnapshot> getCourses ();
  Future<String> getModules ();
  Future<String> getPdf (String id);
  Future<String> putPdf (File file);
  Future<String> putCourses (ItensModel data);
  Future<String> putModules (ItensModel data);





}