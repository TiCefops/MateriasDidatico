import 'package:cefops2/app/controller/module_controller.dart';
import 'package:cefops2/app/routes/app_routes.dart';
import 'package:cefops2/shared/themes/app_textstayle.dart';
import 'package:cefops2/shared/themes/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModulePage extends GetView<ModuleController> {
  final curso = Get.parameters;

  ModulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Container(
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
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: constraints.maxHeight * 0.02,
                        child: Center(
                          child: Text(
                            "MATERIAL \n DIDÁTICO",
                            style: TextStyle(
                                fontFamily: 'pro',
                                color: Colors.white,
                                fontSize: constraints.maxWidth <600?
                                constraints.maxWidth* 0.1
                                    :constraints.maxWidth*0.06),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.07,
                      width: constraints.maxWidth * 0.9,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.orange,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.white, width: 2)),
                        child: Center(
                          child: Text(
                            "${curso["nome"]}",
                            style: TextStyles.titleRegular,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                          width: constraints.maxWidth * 0.9,
                          height: constraints.maxHeight,
                          child: pageMobile("${curso["id"]}")),
                    ),
                  ],
                );

            }),
      )
    );
  }

  Widget pagePc(String curso) {
    return Center(
      child: Container(
        width: 60,
        height: 90,
        color: Colors.red,
        child: Text("Pc $curso"),
      ),
    );
  }

  Widget pageMobile(String curso) {
    return Center(
      child: FutureBuilder(
          future: controller.getModules(curso),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {

              return ListView.separated(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String,String> data={
                    "nome":snapshot.data?.docs[index]["nome"],
                    "id": snapshot.data?.docs[index]["id"],
                    "cursoId": curso,
                  };
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5)),
                    child: ListTile(
                      leading: const Icon(
                        Icons.attach_file,
                        color: Colors.white,
                      ),
                      title: Text(
                        snapshot.data?.docs[index]["nome"],
                        style: TextStyles.titleRegularWhite,
                      ),
                      onTap:()=> Get.toNamed(Routes.SUBJECT,parameters: data),

                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: Get.height * 0.02,
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return Container();
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
