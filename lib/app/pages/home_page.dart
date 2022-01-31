import 'package:cefops2/app/controller/home_controller.dart';
import 'package:cefops2/app/routes/app_routes.dart';
import 'package:cefops2/shared/themes/app_textstayle.dart';
import 'package:cefops2/shared/themes/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                  height: constraints.maxHeight * 0.09,
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
                    height: constraints.maxHeight * 0.02,
                    child: Text(
                      "MATERIAL \n DIDÁTICO",
                      style: TextStyle(
                          fontFamily: 'pro',
                          color: Colors.white,
                          fontSize: constraints.maxWidth * 0.1),
                    ),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight*0.08 ,
                  child: Text(
                    "Selecione Seu Curso",
                    style: TextStyles.titleWithe,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: constraints.maxWidth * 0.9,
                    height: constraints.maxHeight,
                    child: FutureBuilder<QuerySnapshot>(
                        future: controller.getCourses(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                backgroundColor: AppColors.orange,
                              ),
                            );
                          }
                          return ListView.separated(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return course(snapshot.data?.docs[index]["nome"],
                                  snapshot.data?.docs[index]["id"]);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: constraints.maxHeight * 0.01,
                              );
                            },
                          );
                        }),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(0.0),
                    height: constraints.maxHeight * 0.1,
                    child: Image.asset(
                      "assets/icons/amorEnfer.png",
                      height: constraints.maxHeight,
                    ),
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

Widget course(String title, String id) {
  return Container(
    height: Get.height * 0.08,
    decoration: BoxDecoration(
        color: AppColors.orange,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.white, width: 2)),
    child: GestureDetector(
      onTap: () => Get.toNamed(Routes.MODULE, arguments: id),
      child: Center(
        child: Text(
          title,
          style: TextStyles.titleRegular,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
