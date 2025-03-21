// ignore_for_file: prefer_const_constructors, unused_import, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings, avoid_print, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../components/list_view_icon_text.dart';
import '../../../components/sharpref.dart';
import '../../../core/constantes/assets_color.dart';
import '../../../main.dart';
import '../../../models/User.dart';
import '../../controller/userController.dart';
import '../auth_controller.dart';
import '../login_view.dart';
import 'edit_password.dart';
import 'edit_profil.dart';
import 'package:http/http.dart' as http;

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  UserController userController = Get.put(UserController());
  CUser cUser = Get.put(CUser());
  final box = GetStorage();
  late Map _userData = {};
  late bool _isLoading;
  @override
  void initState() {
    super.initState();

    fetchUser();
    userController.fetchUser().then((value) {
      setState(() {
        userController.jsonDataProfil = value ?? "";
      });
    });
  }

  fetchUser() async {
    try {
      final response = await http.get(
        Uri.parse('https://mobile-app.wiqual.org/api/v1/user-profile'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('access_token')}'
        },
      );
      print('response.statusCode');
      print(response.statusCode);
      print('response');
      print(response.body);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          _userData = jsonData;
          _isLoading = false;
        });
        setState(() {});
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      print(error.toString());
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('--- cUser ---');
    print(cUser.user.name);
    return Scaffold(
      backgroundColor: AppColors.secondBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryBackground,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Mon compte',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        cUser.user.name.toString(),
                        style: myTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.red
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    onPressed: () => Get.to(EditProfil()),
                    child: Text(
                      'Modifié mon profil',
                      style: myTextStyle.copyWith(
                        fontSize: 16,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Divider(),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    onPressed: () => Get.to(EditPassword(
                      phoneNumber: '',
                    )),
                    child: Text(
                      'Modifié mon mot de passe',
                      style: myTextStyle.copyWith(
                        fontSize: 16,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Divider(),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconsAndTitle(
                  icon1: Icons.logout,
                  title: 'Se déconnecter',
                  onTap: () async {
                    showCupertinoDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return CupertinoAlertDialog(
                            title: const Text('Veuillez confirmer'),
                            content: const Text(
                                'Voulez-vous vraiment vous déconnecter ?'),
                            actions: [
                              // The "Yes" button
                              CupertinoDialogAction(
                                onPressed: () {
                                  EventPref.deleteUser().then((value) {
                                    Get.offAll(PageLogin());
                                  });
                                },
                                child: const Text('Oui'),
                                isDefaultAction: true,
                                isDestructiveAction: true,
                              ),
                              // The "No" button
                              CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Non',
                                  style: TextStyle(color: Colors.black),
                                ),
                                isDefaultAction: false,
                                isDestructiveAction: false,
                              )
                            ],
                          );
                        });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
