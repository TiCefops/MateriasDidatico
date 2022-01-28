import 'package:cefops2/app/controller/home_controller.dart';
import 'package:cefops2/app/routes/app_pages.dart';
import 'package:cefops2/app/routes/app_routes.dart';
import 'package:cefops2/generated/assets.dart';
import 'package:cefops2/shared/themes/app_textstayle.dart';
import 'package:cefops2/shared/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/image/brasao.png"),
              opacity: 0.04,
              alignment: Alignment.bottomCenter,
              scale: 0.7),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: constraints.maxHeight*0.09,
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.7,
                  child: Image.asset(
                    "assets/image/logo.png",
                    width: constraints.maxWidth,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.04,
                ),
                Expanded(
                  child: SizedBox(
                    height: constraints.maxHeight,
                    child:  Text(
                      "MATERIAL \n DIDÁTICO",
                      style: TextStyle(
                        fontFamily: 'pro',
                        color: Colors.white,
                        fontSize: constraints.maxWidth*0.1
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: constraints.minHeight ,
                    child: Text(
                      "Selecione Seu Curso",
                      style: TextStyles.titleWithe,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: constraints.minHeight * 0.09,
                  width: constraints.minHeight * 0.5,
                  decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.white, width: 2)),
                  child: GestureDetector(
                    child: Center(
                      child: Text(
                        "Auxiliar de Enfermagem",
                        style: TextStyles.titleRegular,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: constraints.minHeight * 0.03,
                ),
                Container(
                  height: constraints.minHeight * 0.09,
                  width: constraints.minHeight * 0.5,
                  decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.white, width: 2)),
                  child: GestureDetector(
                    onTap:()=> Get.toNamed(Routes.MODULE),
                    child: Center(
                      child: Text(
                        "Técnico de Enfermagem",
                        style: TextStyles.titleRegular,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight*0.2,
                  child: Image.asset(
                    "assets/icons/amorEnfer.png",
                    height: constraints.maxHeight,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
