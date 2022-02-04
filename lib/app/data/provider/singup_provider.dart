
import 'package:cloud_firestore/cloud_firestore.dart';

class SingupProvider{

  Future<void>singUp(String nome,String cpf,String email,String uid)async {
    await FirebaseFirestore.instance.collection("users").doc(uid).set(
      {
        'nome':nome,
        'cpf':cpf,
        'email':email,
        'uid':uid,
        "cursos": [{"ativo": true, "cursoId": "JKvhYXcuDsUhKrgbvYP7"}],
        "modulos": [{"modulo": "40MS5oEwxYLQDBUtVZwj", "ativo": true}],
      }
    );

  }

}