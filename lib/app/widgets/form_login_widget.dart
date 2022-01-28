
import 'package:cefops2/shared/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class FormLoginWidget extends GetWidget{
    const FormLoginWidget( this.label, this.iconData,{Key? key}) : super(key: key);
final String label;
final IconData iconData;



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

      decoration:  InputDecoration(
        fillColor: Colors.white,
        labelText: label,
        hintText: "*********",

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

    ),
  ),
);
  }
}
