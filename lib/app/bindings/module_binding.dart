import 'package:cefops2/app/controller/module_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class ModuleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModuleController>(() {
      return ModuleController();
    });
  }
}