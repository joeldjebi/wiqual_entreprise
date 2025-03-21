// ignore_for_file: camel_case_types, use_key_in_widget_constructors, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_const_constructors, unused_field, prefer_final_fields

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/button.dart';
import '../../../components/champ_input.dart';
import '../../../core/constantes/assets_color.dart';
import '../../../main.dart';
import '../../controller/userController.dart';
import '../auth_controller.dart';

class EditProfil extends StatefulWidget {
  // final String phoneNumber;
  // final String? verificationCode;

  // EditProfil({required this.phoneNumber, this.verificationCode});

  @override
  _EditProfilState createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  UserController userController = Get.put(UserController());
  CUser cUser = Get.put(CUser());
  final registerForm = GlobalKey<FormState>();
  bool load = false;

  var name = "".obs;
  var pays = "".obs;
  var ville = "".obs;

  var _isLoading = false;
  var _errorMessage = "";
  var _connectivityResult = ConnectivityResult.none;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _paysController = TextEditingController();
  final TextEditingController _villeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((connectivityResult) {
      setState(() {
        _connectivityResult = connectivityResult;
      });
    });

    userController.fetchUser().then((value) {
      setState(() {
        userController.jsonDataProfil = value;
        _nameController.text = userController.jsonDataProfil["name"];
        _paysController.text = userController.jsonDataProfil["pays"] == null
            ? ''
            : userController.jsonDataProfil["pays"].toString();
        _villeController.text = userController.jsonDataProfil["ville"] == null
            ? ''
            : userController.jsonDataProfil["ville"].toString();
      });
    });

    // _nameController.text = cUser.user.name.toString();

    // _paysController.text =  cUser.user.pays.toString() == 'null' ? '' : cUser.user.pays.toString();

    // _villeController.text = cUser.user.ville.toString() == 'null' ? '' : cUser.user.ville.toString();
  }

  @override
  Widget build(BuildContext context) {
    print('***** cUser ******');
    // print(cUser.user.name);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Modifier mon profil',
            style: myTextStyle.copyWith(
              fontSize: 16,
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChampInput.TextFieldInput(
                      'Nom et prénoms',
                      '',
                      _nameController,
                      TextInputType.text,
                    ),
                    ChampInput.TextFieldInput(
                      'Pays',
                      '',
                      _paysController,
                      TextInputType.text,
                    ),
                    ChampInput.TextFieldInput(
                      'Ville',
                      '',
                      _villeController,
                      TextInputType.text,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Bouton.primaryBtn(
                  "Modifier",
                  () async {
                    try {
                      String name = _nameController.text;
                      String pays = _paysController.text;
                      String ville = _villeController.text;

                      if (name != '' && pays != '' && ville != '') {
                        await userController.updateUser(name, pays, ville);
                      } else {
                        Get.snackbar(
                            'Succès', 'Tout les champs sont obligatoire.');
                      }
                    } catch (e) {
                      Get.snackbar('Attention', e.toString());
                    }
                  },
                  // () => EditProfil(),
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
