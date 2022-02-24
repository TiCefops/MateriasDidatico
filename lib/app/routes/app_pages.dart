import 'package:cefops2/app/bindings/home_binding.dart';
import 'package:cefops2/app/bindings/login_binging.dart';
import 'package:cefops2/app/bindings/module_binding.dart';
import 'package:cefops2/app/bindings/passord_reset_binding.dart';
import 'package:cefops2/app/bindings/pdf_viewer_binding.dart';
import 'package:cefops2/app/bindings/singup_bindings.dart';
import 'package:cefops2/app/bindings/subject_binding.dart';
import 'package:cefops2/app/pages/home_page.dart';
import 'package:cefops2/app/pages/password_reset_page.dart';
import 'package:cefops2/app/pages/singup_page.dart';
import 'package:cefops2/app/pages/sjubject_page.dart';
import 'package:cefops2/app/pages/login_page.dart';
import 'package:cefops2/app/pages/module_page.dart';
import 'package:cefops2/app/pages/pdf_view_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'app_routes.dart';

User? user = FirebaseAuth.instance.currentUser;

class AppPages {
  static final routes = [
    GetPage(
        name: Routes.INITIAL,
        page: () => _homeInitialChange(),
        binding: _homeInitialChangeBinding()),
    GetPage(
        name: Routes.LOGIN, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(
        name: Routes.SINGUP,
        page: () => SingupPage(),
        binding: SingupBindings()),
    GetPage(name: Routes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(
        name: Routes.PDFVIEW,
        page: () => PdfViewPage(),
        binding: PdfViewerBinding()),
    GetPage(
        name: Routes.MODULE,
        page: () => ModulePage(),
        binding: ModuleBinding()),
    GetPage(
        name: Routes.SUBJECT,
        page: () => SubjectPage(),
        binding: SubjectBinding()),
    GetPage(
        name: Routes.MODULE,
        page: () => ModulePage(),
        binding: ModuleBinding()),
    GetPage(
        name: Routes.PASSWORDRESET,
        page: () => PasswordReset(),
        binding: PasswordResetBinding()),
  ];
}

_homeInitialChange() {
  if (user != null) {
    return HomePage();
  } else {
    return LoginPage();
  }
}

_homeInitialChangeBinding() {
  if (user != null) {
    return HomeBinding();
  } else {
    return LoginBinding();
  }
}
