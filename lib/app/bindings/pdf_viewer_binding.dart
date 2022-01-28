
import 'package:cefops2/app/controller/pdf_view_controller.dart';
import 'package:get/get.dart';

class PdfViewerBinding implements Bindings{
  @override
  void dependencies() {
Get.lazyPut<PdfViewerController>((){

  return PdfViewerController();
});
  }

}