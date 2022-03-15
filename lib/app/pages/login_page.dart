import 'package:cefops2/app/controller/login_controller.dart';
import 'package:cefops2/app/routes/app_routes.dart';
import 'package:cefops2/app/widgets/form_login_widget.dart';
import 'package:cefops2/shared/auth/firebase_auth.dart';
import 'package:cefops2/shared/themes/app_text_stayle.dart';
import 'package:cefops2/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_style.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';

class LoginPage extends GetView<LoginController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passowrdController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GetPlatform.isMobile ? Colors.white : AppColors.blue,
      body: SingleChildScrollView(
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
          height: Get.height,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Center(
                  child: SizedBox(
                    width: Get.width * 0.4,
                    height: Get.height * 0.08,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      constraints.maxWidth >= 600 ? forPC() : forMobile()
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: Get.height,
                  ),
                ),
                Obx(
                 () {
                    return Text(
                      "Versão  Local: ${controller.appVersionLocal} | "
                      "Versão do Servidor: ${controller.appVerionSever}",
                      style: TextStyle(
                          color:
                              GetPlatform.isMobile ? Colors.black : Colors.white),
                    );
                  }
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget forMobile() {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 700,
        minHeight: 400,
      ),
      width: Get.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.01,
          ),
          SizedBox(
            width: Get.width * 0.55,
            height: Get.height * 0.22,
            child: Image.asset(
              "assets/image/logov2.png",
            ),
          ),
          Center(
              child: TextRenderer(
            style: TextRendererStyle.header1,
            child: Text(
              "EAS-Material Didático",
              style: AppTextStyle.titleRegularBold,
            ),
          )),
          FormLoginWidget(
              "E-mail", Icons.person, emailController, false, AppColors.blue),
          FormLoginWidget(
              "Senha", Icons.lock, passowrdController, true, AppColors.blue),
          Padding(
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                Expanded(
                    child: SizedBox(
                  width: Get.width,
                )),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.PASSWORDRESET);
                  },
                  child: const Text(
                    "Esqueci a senha",
                    style: TextStyle(color: AppColors.blue),
                  ),
                ),
              ],
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
                        if (_formKey.currentState!.validate()) {
                          controller.loadingPage.value = true;
                          await AuthenticationHelper()
                              .signIn(
                                  email: emailController.text,
                                  password: passowrdController.text)
                              .then((result) async {
                            if (result == null) {
                              controller.sendLoginEvent();
                              controller.loadingPage.value = false;
                              Get.offAndToNamed(Routes.HOME);
                            } else {
                              controller.loadingPage.value = false;
                              controller.setErrorMessagerForSnack(result);
                              Get.snackbar("Falha na Autenticação",
                                  controller.errorMessagerForSnack.value);
                            }
                          });

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
          ),
        ],
      ),
    );
  }

  Widget forPC() {
    return Container(
      width: Get.width * 0.45,
      height: Get.height * 0.75,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.01,
          ),
          SizedBox(
            width: Get.width * 0.4,
            height: Get.height * 0.22,
            child: Image.asset(
              "assets/image/logov2.png",
            ),
          ),
          Center(
              child: TextRenderer(
            text: "EAS Material Didático",
            style: TextRendererStyle.header1,
            child: Text(
              "EAS Material Didático ",
              style: AppTextStyle.titleRegularBold,
            ),
          )),
          FormLoginWidget(
              "E-mail", Icons.person, emailController, false, AppColors.blue),
          FormLoginWidget(
              "Senha", Icons.lock, passowrdController, true, AppColors.blue),
          Row(
            children: [
              Expanded(
                  child: SizedBox(
                width: Get.width,
              )),
              TextButton(
                onPressed: () {
                  Get.toNamed(Routes.PASSWORDRESET);
                },
                child: const Text(
                  "Esqueci a senha",
                  style: TextStyle(color: AppColors.blue),
                ),
              ),
            ],
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
                              .signIn(
                                  email: emailController.text,
                                  password: passowrdController.text)
                              .then((result) async {
                            if (result == null) {
                              controller.loadingPage.value = false;
                              Get.offAndToNamed(Routes.HOME);
                            } else {
                              controller.loadingPage.value = false;
                              controller.setErrorMessagerForSnack(result);
                              Get.snackbar("Falha na Autenticação",
                                  controller.errorMessagerForSnack.value);
                            }
                          });

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
          ),
        ],
      ),
    );
  }
}
