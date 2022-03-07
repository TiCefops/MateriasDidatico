
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
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: SizedBox(
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
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: Get.height * 0.08,
                  ),
                  Center(
                    child: SizedBox(
                      width: Get.width * 0.3,
                      height: Get.height * 0.15,
                      child: Image.asset(
                        "assets/image/brasao.png",
                      ),
                    ),
                  ),
                  Expanded(

                    child: SizedBox(
                      width: widethForPC,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            FormLoginWidget("Nome Completo", Icons.person,
                                nomeController, false,Colors.white),
                            FormLoginWidget(
                                "CPF", Icons.person, cpfController, false,Colors.white),
                            FormLoginWidget(
                                "E-mail", Icons.person, emailController, false,Colors.white),
                            FormLoginWidget(
                                "Senha", Icons.lock, passowrdController, true,Colors.white),

                          ],
                        ),
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
                        onPressed: () async {
                          String email = emailController.text;
                          String passowrd = passowrdController.text;
                          controller.name.value=nomeController.text;
                          controller.cpf.value=cpfController.text;
                          controller.email.value=emailController.text;



                          if (_formKey.currentState!.validate()) {
                            controller.loadingPage.value = true;

                            await AuthenticationHelper()
                                .signUp(email: email, password: passowrd)
                                .then((result) async {
                              if (result == null) {
                                await AuthenticationHelper().
                                signIn(email: email, password: passowrd).
                                then((value) async => await controller.singup(
                                ),);

                                controller.loadingPage.value = false;

                                Get.offAndToNamed(Routes.HOME);
                              } else {
                                controller.loadingPage.value = false;
                                controller.setErrorMessagerForSnack(result);
                                Get.snackbar("Falha no Cadastro", controller.errorMessagerForSnack.value);
                              }
                            });
                            controller.loadingPage.value = false;
                          }
                        },
                        child: const Text(
                          "Cadastrar",
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
                    },
                  ),
                ],
              );
            }),
      ),
    );
  }
}
