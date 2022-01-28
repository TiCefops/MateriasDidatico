import 'package:cefops2/shared/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


///Estilização do app
class TextStyles {
  static final TextStyle titleHome = GoogleFonts.lexendDeca(
    fontSize: 40,
    fontWeight: FontWeight.w600,
    color: Colors.white,

  );
  static final TextStyle titleWithe = GoogleFonts.openSans(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    decoration: TextDecoration.underline,


  );
  static final TextStyle titleRegular = GoogleFonts.openSans(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: AppColors.blue,

  );
}
