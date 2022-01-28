
import 'dart:io';

import 'package:cefops2/app/data/model/itens_model.dart';

abstract class IDataItens{

  Future<String> getCourses ();
  Future<String> getModules ();
  Future<String> getPdf (String id);
  Future<String> putPdf (File file);
  Future<String> putCourses (ItensModel data);
  Future<String> putModules (ItensModel data);





}