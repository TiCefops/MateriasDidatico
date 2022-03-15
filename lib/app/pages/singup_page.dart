import 'package:cefops2/app/controller/singup_controller.dart';
import 'package:cefops2/app/routes/app_routes.dart';
import 'package:cefops2/app/widgets/form_login_widget.dart';
import 'package:cefops2/shared/auth/firebase_auth.dart';
import 'package:cefops2/shared/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class SingupPage extends GetView<SingupController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passowrdController = TextEditingController();
  final TextEditingController passowrd2Controller = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SingupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widethForPC = Get.width;
    if (Get.width >= 600) {
      widethForPC = Get.width * 0.5;
    }
    return Scaffold(
        backgroundColor: AppColors.blue,
        body: SizedBox(
            height: Get.height,
            child: Center(
              child: Container(
                width: widethForPC,
                height: Get.height * 0.85,
                decoration: BoxDecoration(
                    color: GetPlatform.isMobile ? AppColors.blue : Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Center(
                          child: SizedBox(
                            width: Get.width * 0.3,
                            height: Get.height * 0.15,
                            child: Image.asset(
                              GetPlatform.isMobile
                                  ? "assets/image/logo.png"
                                  : "assets/image/logov2.png",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Obx(() {
                          return Text("Curso: ${controller.courseName.value}",
                              style: GoogleFonts.openSans(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color:GetPlatform.isMobile? Colors.white: AppColors.blue,

                              ));
                        }),
                        SizedBox(
                          width: widethForPC,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                FormLoginWidget(
                                    "Nome Completo",
                                    Icons.person,
                                    nomeController,
                                    false,
                                    GetPlatform.isMobile
                                        ? Colors.white
                                        : Colors.black),
                                FormLoginWidget("CPF", Icons.person,
                                    cpfController, false, GetPlatform.isMobile
                                        ? Colors.white
                                        : Colors.black),
                                FormLoginWidget("E-mail", Icons.person,
                                    emailController, false, GetPlatform.isMobile
                                        ? Colors.white
                                        : Colors.black),
                                FormLoginWidget("Senha", Icons.lock,
                                    passowrdController, true, GetPlatform.isMobile
                                        ? Colors.white
                                        : Colors.black),
                              ],
                            ),
                          ),
                        ),
                        Obx(
                          () {
                            return controller.loadingPage.value
                                ? const CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                    color: AppColors.orange,
                                  )
                                : ElevatedButton(
                                    onPressed: controller.buttonEnabled.value
                                        ? () async {
                                            String email = emailController.text;
                                            String passowrd =
                                                passowrdController.text;
                                            controller.name.value =
                                                nomeController.text;
                                            controller.cpf.value =
                                                cpfController.text;
                                            controller.email.value =
                                                emailController.text;

                                            if (_formKey.currentState!
                                                .validate()) {
                                              controller.loadingPage.value =
                                                  true;

                                              await AuthenticationHelper()
                                                  .signUp(
                                                      email: email,
                                                      password: passowrd)
                                                  .then((result) async {
                                                if (result == null) {
                                                  await AuthenticationHelper()
                                                      .signIn(
                                                          email: email,
                                                          password: passowrd)
                                                      .then(
                                                        (value) async =>
                                                            await controller
                                                                .singup(),
                                                      );

                                                  controller.loadingPage.value =
                                                      false;

                                                  Get.offAndToNamed(
                                                      Routes.HOME);
                                                } else {
                                                  controller.loadingPage.value =
                                                      false;
                                                  controller
                                                      .setErrorMessagerForSnack(
                                                          result);
                                                  Get.snackbar(
                                                      "Falha no Cadastro",
                                                      controller
                                                          .errorMessagerForSnack
                                                          .value);
                                                }
                                              });
                                              controller.loadingPage.value =
                                                  false;
                                            }
                                          }
                                        : null,
                                    child: const Text(
                                      "Cadastrar",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                controller.buttonEnabled.value
                                                    ? AppColors.blue
                                                    : Colors.grey),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.all(Get.height * 0.02)),
                                        textStyle:
                                            MaterialStateProperty.all(TextStyle(
                                          fontSize: Get.height * 0.02,
                                        ))),
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
