import 'package:assignment_task/core/util/routes.dart';
import 'package:assignment_task/core/util/routes_path.dart';
import 'package:assignment_task/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await serviceLocator();

  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.grey,
    statusBarIconBrightness: Brightness.dark,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assigment Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: RouterGet.route,
      initialRoute: RoutesPath.Initial,
    );
  }
}
