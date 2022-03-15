import 'package:cefops2/app/data/repository/course_repository.dart';
import 'package:cefops2/app/data/repository/singup_repository.dart';
import 'package:cefops2/app/erroHandler/auth_handdler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SingupController extends GetxController {
  final SingUpRepository repository = SingUpRepository();
  final CourseRepository _courseRepository = CourseRepository();
  final courseId = Get.parameters;

  @override
  void onReady() {
    super.onReady();

    getAndSetCourseInfoById(courseId["courseId"].toString());
  }

  RxBool loadingPage = false.obs;
  RxBool showPassord = false.obs;
  RxString password = "".obs;
  RxString name = "".obs;
  RxString cpf = "".obs;
  RxString email = "".obs;
  RxString errorMessagerForSnack = "".obs;
  RxString courseName = "Caregando...".obs;
  RxString courseIdforSingup = "".obs;
  RxString moduleIdforSingup = "".obs;
  RxBool buttonEnabled = true.obs;

  Future<void> getAndSetCourseInfoById(String id) async {
    DocumentSnapshot snapshot = await _courseRepository.getCourseInfoById(id);
    if (snapshot.data() != null) {
      courseName.value = snapshot.get("nome");
      courseIdforSingup.value = snapshot.get("id");
      moduleIdforSingup.value = snapshot.get("firstModule");

    } else {
      courseName.value = "Curso não Encontrado";
      buttonEnabled.value = false;
    }
  }

  setErrorMessagerForSnack(String error) {
    errorMessagerForSnack.value = AuthHanddler().errorFilter(error);
  }

  Future<void> singup() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user?.emailVerified == false) {
      user?.sendEmailVerification();
    }
    String uid = user!.uid;
    await repository.singUp(name.value, cpf.value, email.value, uid,
        courseIdforSingup.value, moduleIdforSingup.value);
  }
}
