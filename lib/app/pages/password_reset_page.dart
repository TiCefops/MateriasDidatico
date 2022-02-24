import 'package:cefops2/app/controller/password_reset_controller.dart';
import 'package:cefops2/app/routes/app_routes.dart';
import 'package:cefops2/app/widgets/form_login_widget.dart';
import 'package:cefops2/shared/auth/firebase_auth.dart';
import 'package:cefops2/shared/themes/app_textstayle.dart';
import 'package:cefops2/shared/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordReset extends GetView<PasswordResetController> {
  PasswordReset({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.blue,
      child: Container(
        decoration: GetPlatform.isMobile
            ? const BoxDecoration()
            : const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/image/brasao.png"),
              opacity: 0.09,
              scale: 1,
              alignment: Alignment.centerRight),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            constraints: BoxConstraints(
                minWidth: Get.width * 0.2,
                maxWidth: GetPlatform.isMobile? Get.width * 0.9:Get.width * 0.5,
                maxHeight: Get.height * 0.7,
                minHeight: Get.height * 0.2),
            child: Column(children: [
              SizedBox(
                height: Get.height * 0.01,
              ),
              SizedBox(
                width: Get.width * 0.55,
                height: Get.height * 0.22,
                child: Image.asset(
                  "assets/image/logov2.png",
                  scale: 1,
                  filterQuality: FilterQuality.high,
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Center(
                child: Text(
                  "Resetar minha Senha",
                  style: TextStyles.titleRegularBold,
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Form(
                key: _formKey,
                child: FormLoginWidget("E-mail", Icons.email, emailController,
                    false, AppColors.blue),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Obx(
                () {
                  return controller.loadingPage.value
                      ? const CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          color: AppColors.orange,
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              controller.loadingPage.value = true;
                              await AuthenticationHelper()
                                  .resetPassword(email: emailController.text)
                                  .then(
                                (result) {
                                  Get.defaultDialog(
                                    title: "Enviamos um E-mail para você",
                                    titleStyle:
                                        const TextStyle(color: AppColors.blue),
                                    middleTextStyle:
                                        const TextStyle(color: Colors.white),
                                    barrierDismissible: false,
                                    content: Column(
                                      children: [
                                        const Text("Se seu e-mail estiver"),
                                        const Text("cadastrado em nossa base"),
                                        const Text("você irá receber um e-mail "),
                                        const Text(
                                            "para redefinir sua senha em ate 5 minutos"),
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(AppColors.blue)),
                                            onPressed: () {
                                              Get.offAndToNamed(Routes.LOGIN);
                                            },
                                            child: const Text(
                                              "Ok",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ))
                                      ],
                                    ),
                                  );
                                },
                              );

                              controller.loadingPage.value = false;
                            }
                          },
                          child: const Text(
                            "Enviar",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.blue),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.all(Get.height * 0.02)),
                            textStyle: MaterialStateProperty.all(
                              TextStyle(
                                fontSize: Get.height * 0.02,
                              ),
                            ),
                          ),
                        );
                },
              )
            ]),
          ),
        ),
      ),
    );
  }
  Widget forMobile(){
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      constraints: BoxConstraints(
          minWidth: Get.width * 0.2,
          maxWidth: Get.width * 0.5,
          maxHeight: Get.height * 0.7,
          minHeight: Get.height * 0.2),
      child: Column(children: [
        SizedBox(
          height: Get.height * 0.01,
        ),
        SizedBox(
          width: Get.width * 0.4,
          height: Get.height * 0.22,
          child: Image.asset(
            "assets/image/logov2.png",
            scale: 1,
            filterQuality: FilterQuality.high,
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Center(
          child: Text(
            "Resetar minha Senha",
            style: TextStyles.titleRegularBold,
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Form(
          key: _formKey,
          child: FormLoginWidget("E-mail", Icons.email, emailController,
              false, AppColors.blue),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Obx(
              () {
            return controller.loadingPage.value
                ? const CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: AppColors.orange,
            )
                : ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  controller.loadingPage.value = true;
                  await AuthenticationHelper()
                      .resetPassword(email: emailController.text)
                      .then(
                        (result) {
                      Get.defaultDialog(
                        title: "Enviamos um E-mail para você",
                        titleStyle:
                        const TextStyle(color: AppColors.blue),
                        middleTextStyle:
                        const TextStyle(color: Colors.white),
                        barrierDismissible: false,
                        content: Column(
                          children: [
                            const Text("Se seu e-mail estiver"),
                            const Text("cadastrado em nossa base"),
                            const Text("você irá receber um e-mail "),
                            const Text(
                                "para redefinir sua senha em ate 5 minutos"),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(AppColors.blue)),
                                onPressed: () {
                                  Get.offAndToNamed(Routes.LOGIN);
                                },
                                child: const Text(
                                  "Ok",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20),
                                ))
                          ],
                        ),
                      );
                    },
                  );

                  controller.loadingPage.value = false;
                }
              },
              child: const Text(
                "Entrar",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(AppColors.blue),
                padding: MaterialStateProperty.all(
                    EdgeInsets.all(Get.height * 0.02)),
                textStyle: MaterialStateProperty.all(
                  TextStyle(
                    fontSize: Get.height * 0.02,
                  ),
                ),
              ),
            );
          },
        )
      ]),
    );
  }
}
