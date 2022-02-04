import 'package:cefops2/app/controller/login_controller.dart';
import 'package:cefops2/app/controller/user_info_controller.dart';
import 'package:cefops2/app/routes/app_routes.dart';
import 'package:cefops2/app/widgets/form_login_widget.dart';
import 'package:cefops2/shared/auth/firebase_auth.dart';
import 'package:cefops2/shared/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passowrdController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            double widethForPC = constraints.maxWidth;
            if (constraints.maxWidth >= 600) {
              widethForPC = constraints.maxWidth * 0.5;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: Get.height * 0.08,
                ),
                Center(
                  child: SizedBox(
                    width: Get.width * 0.4,
                    height: Get.height * 0.3,
                    child: Image.asset(
                      "assets/image/brasao.png",
                    ),
                  ),
                ),
                SizedBox(
                  width: widethForPC,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormLoginWidget(
                            "E-mail", Icons.person, emailController, false),
                        FormLoginWidget(
                            "Senha", Icons.lock, passowrdController, true),
                        Row(
                          children: [
                            Expanded(child: SizedBox(width: constraints.maxWidth,)),
                            TextButton(
                              onPressed: () {Get.toNamed(Routes.SINGUP);},
                              child: const Text("Cadastrar",style: TextStyle(
                                color: Colors.white
                              ),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(() {
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
                                  .signIn(
                                      email: emailController.text,
                                      password: passowrdController.text)
                                  .then((result) {
                                if (result == null) {
                                  controller.loadingPage.value = false;
                                  Get.offAndToNamed(Routes.HOME);
                                } else {
                                  controller.loadingPage.value = false;
                                  Get.snackbar("Falha na Autenticação", result);
                                }
                              });
                              controller.loadingPage.value = false;
                            }
                          },
                          child: const Text(
                            "Entrar",
                            style: TextStyle(color: AppColors.blue),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.all(Get.height * 0.02)),
                              textStyle: MaterialStateProperty.all(TextStyle(
                                fontSize: Get.height * 0.02,
                              ))),
                        );
                }),
                Expanded(
                    child: SizedBox(
                  height: Get.height,
                ))
              ],
            );
          }),
        ),
      ),
    );
  }
}
