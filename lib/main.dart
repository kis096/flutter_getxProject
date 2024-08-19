import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_todo/App/Data/services/storage/services.dart';
import 'package:getx_todo/App/module/Home/binding.dart';
import 'package:getx_todo/App/module/Home/view.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures proper initialization
  await GetStorage.init();
  await Get.putAsync(() => StorageServices().init());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
      home:  const HomePage(),
      initialBinding: HomeBinding() ,
      builder: EasyLoading.init(),
    );
  }
}


