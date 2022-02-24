


import 'package:cefops2/app/controller/pdf_view_controller.dart';
import 'package:cefops2/shared/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewPage extends GetView<PdfViewerControllerUi> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final PdfViewerController _pdfViewerController = PdfViewerController();



  final data = Get.parameters;

  PdfViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    if(!GetPlatform.isWeb){
      disableCapture();
    }
    String pdf = data["linkPdf"] ??
        "https://firebasestorage.googleapis.com/v0/b/cefops.appspot.com/o/Logo%20Azul%20PDF.pdf?alt=media&token=92d52776-2235-4b7e-a2fa-6fe9e33b0bb1";
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blue,
          title: Text("${data["nome"]}"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.bookmark,
                color: Colors.white,
                semanticLabel: 'Marcador',
              ),
              onPressed: () {
                _pdfViewerKey.currentState?.openBookmarkView();
              },
            ),

            GetPlatform.isWeb? IconButton(
              icon: const Icon(
                Icons.zoom_in,
                color: Colors.white,
                semanticLabel: '+ zoom',
              ),
              onPressed: () {
                _pdfViewerController.zoomLevel=3.0;
                _pdfViewerController.nextPage();

              },
            ):Container(),
          ],
        ),
        body: SafeArea(
          child:GetPlatform.isWeb? Stack(
            children: [
              SfPdfViewer.network(
                pdf,
                key: _pdfViewerKey,
                password: controller.password.value,
              ),
              Center(
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(19 / 360),
                  child: Obx(
                          () {
                        return Text(
                          controller.userCpf.value,
                          style: TextStyle(
                            fontSize: Get.width*0.10,
                            color: Colors.black.withOpacity(0.2),
                          ),
                        );
                      }
                  ),
                ),
              ),
            ],
          ):SfPdfViewer.network(
            pdf,
            key: _pdfViewerKey,
            password: controller.password.value,
          ),));
  }
}

Future<void> disableCapture() async {
  //disable screenshots and record screen in current screen
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
}
