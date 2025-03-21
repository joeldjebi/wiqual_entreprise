// ignore_for_file: camel_case_types, use_key_in_widget_constructors, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_const_constructors, unused_field, prefer_final_fields, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiqual_entreprise/features/auth/login_view.dart';

import '../../../components/button.dart';
import '../../../components/champ_input.dart';
import '../../home/home_view.dart';
import '../auth_controller.dart';
import 'index.dart';

class EditPasswordForget extends StatefulWidget {
  final String? phoneNumber;
  final String? code;

  EditPasswordForget({this.phoneNumber, this.code});
  @override
  _EditPasswordForgetState createState() => _EditPasswordForgetState();
}

class _EditPasswordForgetState extends State<EditPasswordForget> {
  UserController userController = Get.put(UserController());
  final registerForm = GlobalKey<FormState>();
  bool load = false;

  var _isLoading = false;
  var _errorMessage = "";
  var _connectivityResult = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((connectivityResult) {
      setState(() {
        _connectivityResult = connectivityResult;
      });
    });
  }

  final TextEditingController _oldpasswordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    _oldpasswordController.dispose();
    _newpasswordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('---phoneNumber---');
    print(widget.phoneNumber);
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
            "Modifier mon mot de passe",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          //
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
                    // ChampInput.TextFieldInputPassord(
                    //   'Mot de passe actuel',
                    //   '',
                    //   _oldpasswordController,
                    //   TextInputType.visiblePassword,
                    // ),
                    ChampInput.TextFieldInputPassord(
                      'Nouveau mot de passe',
                      '',
                      _newpasswordController,
                      TextInputType.visiblePassword,
                    ),
                    ChampInput.TextFieldInputPassord(
                      'Confirmer le mot de passe',
                      '',
                      _confirmpasswordController,
                      TextInputType.visiblePassword,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                ),
                Bouton.primaryBtn(
                  "Modifier",

                  () async {
                    // String oldPassword = _oldpasswordController.text;
                    String newPassword = _newpasswordController.text;
                    String confirmPassword = _confirmpasswordController.text;
                    print('---------PASSWORD---------');
                    // print(oldPassword);
                    print(newPassword);
                    print(confirmPassword);
                    if (newPassword != '' &&
                        widget.phoneNumber != '' &&
                        widget.code != '' &&
                        confirmPassword != '') {
                      if (newPassword == confirmPassword) {
                        await userController.changePasswordResetPassword(
                          '+' + widget.phoneNumber.toString(),
                          widget.code.toString(),
                          newPassword,
                          confirmPassword,
                        );
                        if (userController.status == 200) {
                          // Affichage de message de réussite
                          Get.to(PageLogin());
                        } else {
                          // Affichage d'un message d'erreur
                          Get.snackbar('Échèc', 'Une erreur est surbenue');
                        }
                      } else {
                        Get.snackbar('Échèc',
                            'Les deux mot de passes ne concordent pas');
                      }
                    } else {
                      Get.snackbar('Échèc', 'Tout les champs sont obligatoire');
                    }
                  },
                  // () => EditPasswordForget(),
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
