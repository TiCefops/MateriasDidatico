import 'package:cefops2/app/data/provider/app_monitor_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppMonitorRepository{
  final AppMonitorProvider _provider =AppMonitorProvider();

  Future<DocumentSnapshot> getaApInfo() async {

    return _provider.getAppInfo();
  }


}