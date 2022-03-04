import 'package:cefops2/app/controller/home_pop_show_widget_controller.dart';
import 'package:cefops2/app/data/model/home_pop_show_widget_model.dart';
import 'package:cefops2/shared/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:html' as html;



class HomePopShowWidget {
  HomePopShowWidgetController controller =
      Get.put(HomePopShowWidgetController());

  showDialog({required HomePopShowWidgetModel data}) {
    return Get.defaultDialog(
      title: "Cursos Livres",
      content: Column(
        children: [
           Image(
            image: NetworkImage(
                "${data.imgUrl}",
                scale: 3),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: ElevatedButton(
                  onPressed: () async{
                   await controller.courSelect(
                        courseName: "${data.curso}",
                        status: "open");
                    html.window.open("${data.paginaMatricula}","_blank");
                    controller.dispose();
                    Get.back();

                  },
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Icon(
                          Icons.ads_click,
                          color: AppColors.orange,
                        ),
                        Text("Mais Informações")
                      ],
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.blue),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(10)),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 15))),
                ),
                width:
                    GetPlatform.isMobile ? Get.width * 0.5 : Get.width * 0.175,
              ),
              IconButton(
                onPressed: () async {
                 await controller.courSelect(
                      courseName: "${data.curso}",
                      status: "closed");
                  controller.dispose();
                  Get.back();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
