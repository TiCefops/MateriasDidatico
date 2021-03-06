

import 'package:cefops2/app/controller/subject_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class SubjectBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SubjectController>(() {
      return SubjectController();
    });
  }
}
