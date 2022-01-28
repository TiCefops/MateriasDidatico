
import 'package:cefops2/app/controller/login_controller.dart';
import 'package:cefops2/app/widgets/form_login_widget.dart';
import 'package:cefops2/shared/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
          SizedBox(
          height: Get.height*0.08,),
              Center(
                child: SizedBox(
                  width: Get.width*0.4,
                  height: Get.height*0.3,
                  child: Image.asset("assets/image/brasao.png",),
                ),
              ),

              const FormLoginWidget("Login",Icons.person),
              const FormLoginWidget("Senha",Icons.lock),
              ElevatedButton(onPressed: () {  },
              child: const Text("Entrar",style: TextStyle(
                  color: AppColors.blue
              ),),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(EdgeInsets.all(Get.height*0.02)),
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: Get.height*0.02,))),),
              Expanded(child:SizedBox(height:Get.height,) )

            ],
          ),
        ),

      ),
    );
  }
}
