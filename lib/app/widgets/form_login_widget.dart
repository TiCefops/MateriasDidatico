

import 'package:cefops2/shared/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class FormLoginWidget extends GetWidget{
    const FormLoginWidget( this.label, this.iconData, this.controllerT, this.isvisible, this.colors,{Key? key}) : super(key: key);
final String label;
final IconData iconData;
final TextEditingController controllerT;
final bool isvisible;
final Color colors;



@override
  Widget build(BuildContext context) {

return Padding(
  padding: const EdgeInsets.all(20.0),
  child: TextFormField(
    style:  TextStyle(color: colors),

    obscureText: isvisible,
    controller: controllerT,

    decoration:  InputDecoration(
      fillColor: Colors.amber,
      labelText: label,
      labelStyle:  TextStyle(
        color: colors
      ),
      hintStyle:  TextStyle(
        color: colors
      ),
      errorStyle: const TextStyle(
        color: AppColors.orange,

      ),

      enabledBorder: OutlineInputBorder(
        borderSide:  BorderSide(width: 2, color: colors),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 2, color: AppColors.orange),
        borderRadius: BorderRadius.circular(10),
      ),
      prefixIcon:  Icon(iconData, color: colors),

    ),

    validator: (String? value) {
      if (value == null || value.isEmpty) {
        return "O campo não pode ser vazio";
      }
      if(label=="Repita sua Senha"){
        // if(){
        //   return "As senha não Conferem";
        //
        //
        // }
      }
          if(label=="E-mail"){
            if(!controllerT.text.isEmail){
              return "E-mail inválido";
            }
            return null;
          }
      return null;
    },
    maxLines: 1,

  ),
);
  }
}

