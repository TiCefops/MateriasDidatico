import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ModulePage extends GetView<ModulePage> {
  final String curso = Get.arguments;

   ModulePage( {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(curso);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Módulos"),
      ),
      body: LayoutBuilder(builder:(BuildContext context,BoxConstraints constraints){
        print(constraints.maxWidth);
        if(constraints.maxWidth>600){

          return pagePc(curso);
        }
        else{
          return pageMobile(curso);
        }

      }),
    );

  }
  Widget pagePc(String curso){

    return Center(
      child: Container(
        width: 60,
        height: 90,
        color: Colors.red,
        child:  Text("Pc $curso"),
      ),
    );
  }
  Widget pageMobile(String curso){
    return Center(
      child: Container(
        color: Colors.blue,
        child:  ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context,int index){
              return  ListTile(
                leading: const Icon(Icons.book),
                title: Text("Módulo $index"),
              );
            }),
      ),
    );
  }
}


