import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studentmngmnt_getx/controllers/controller.dart';
import 'package:studentmngmnt_getx/controllers/services.dart';
import 'package:studentmngmnt_getx/model/db_model.dart';
import 'package:studentmngmnt_getx/view/home_page.dart';

import 'package:get/get.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  await Hive.openBox<Student>('students');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePageScreen(),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<ImagePickerService>(() => ImagePickerService());
        Get.lazyPut<ActionController>(() => ActionController());
      }),
    );
  }
}
