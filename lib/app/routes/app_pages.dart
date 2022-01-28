
import 'package:cefops2/app/bindings/home_binding.dart';
import 'package:cefops2/app/bindings/login_binging.dart';
import 'package:cefops2/app/bindings/pdf_viewer_binding.dart';
import 'package:cefops2/app/pages/home_page.dart';
import 'package:cefops2/app/pages/login_page.dart';
import 'package:cefops2/app/pages/module_page.dart';
import 'package:cefops2/app/pages/pdf_view_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.INITIAL,
      page: () => const LoginPage(),
      binding: LoginBinding()
    ),
    GetPage(
        name: Routes.HOME,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: Routes.PDFVIEW,
        page: () => const PdfViewPage(),
        binding: PdfViewerBinding()),  GetPage(
        name: Routes.MODULE,
        page: () => const ModulePage(),
        parameters: {},
        binding: PdfViewerBinding()),

  ];
}
