import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/sharpref.dart';
import 'features/auth/auth_controller.dart';
import 'features/auth/login_view.dart';
import 'features/home/home_view.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(MyApp());
}

TextStyle myTextStyle = GoogleFonts.montserrat();

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    userController.iniGetUserData();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wiqual',
      theme: ThemeData(
        fontFamily: "Montserrat",
        // primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: EventPref.getUser(),
        builder: (context, snapshot) {
          if (snapshot.data == null) return PageLogin();
          return Dashboard();
        },
      ),
    );
  }
}
