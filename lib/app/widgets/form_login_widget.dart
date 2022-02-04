
import 'package:cefops2/app/controller/singup_controller.dart';
import 'package:cefops2/shared/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class FormLoginWidget extends GetWidget{
    const FormLoginWidget( this.label, this.iconData, this.controllerT, this.isvisible,{Key? key}) : super(key: key);
final String label;
final IconData iconData;
final TextEditingController controllerT;
final bool isvisible;



@override
  Widget build(BuildContext context) {

return Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    decoration: BoxDecoration(
      color: AppColors.orange,

      borderRadius: BorderRadius.circular(10),
    ),
    child: TextFormField(
      obscureText: isvisible,
      controller: controllerT,


      decoration:  InputDecoration(
        fillColor: Colors.white,
        labelText: label,

        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: AppColors.orange),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon:  Icon(iconData, color: Colors.white),

      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "O campo não pode ser vazio";
        }if(label=="Repita sua Senha"){
          // if(){
          //   return "As senha não Conferem";
          //
          //
          // }
        }

        return null;
      },
      maxLines: 1,

    ),
  ),
);
  }
}

