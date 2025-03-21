// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, unnecessary_import, unused_import, sized_box_for_whitespace, unused_field, prefer_final_fields, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/button.dart';
import '../../components/champ_input.dart';
import '../../core/constantes/assets_color.dart';
import 'auth_controller.dart';
import 'otp_forget_password.dart';

class MotDePasseOubliePage extends StatefulWidget {
  const MotDePasseOubliePage({Key? key}) : super(key: key);

  @override
  MotDePasseOubliePageState createState() => MotDePasseOubliePageState();
}

class MotDePasseOubliePageState extends State<MotDePasseOubliePage> {
  var controller = Get.put(UserController());
  bool load = false;
  bool _showEye = false;
  bool _passwordIsEncrypted = true;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final phoneNumber = '225';

  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // fermer le clavier lorsque le champ de saisie perd le focus
        FocusScope.of(context).unfocus();
      }
    });
  }

  List<Map<String, dynamic>> _myJson = [
    {
      'id': '1',
      'image': 'assets/images/ci.png',
      'name': 'Côte d\'ivoire',
      'code': '225',
    },
    {
      'id': '2',
      'image': 'assets/images/ghana.png',
      'name': 'Ghana',
      'code': '233',
    },
  ];
  String _selectedCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Vérification de numéro",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          // fermer le clavier lorsque l'utilisateur tape en dehors du champ de saisie
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Saisissez votre numéro de téléphone ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Nous vous enverons un\ncode de vérification a 4 chiffre",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Container(
                        height: 100,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.bgColorGris,
                                border: Border.all(
                                    width: 1, color: Color(0xffF6F6F6)),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.zero,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButton(
                                          hint: Text('Select a country'),
                                          value: _selectedCode.isNotEmpty
                                              ? _selectedCode
                                              : '225',
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedCode = value.toString();
                                            });
                                          },
                                          items: _myJson.map((country) {
                                            return DropdownMenuItem(
                                              value: country['code'],
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    country['image'],
                                                    width: 25,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(country['name']),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              left: 0.0,
                              top: 45.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 62,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Color(0xffe7e4e4)),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.zero,
                                        topRight: Radius.zero,
                                        bottomLeft: Radius.circular(8.0),
                                        bottomRight: Radius.zero,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(_selectedCode.isNotEmpty
                                            ? _selectedCode
                                            : '225'),
                                      ],
                                    ),
                                  ),
                                  ChampInput.TextFieldInputNumber(
                                    _phoneController,
                                    TextInputType.phone,
                                    MediaQuery.of(context).size.width * 0.75,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Bouton.primaryBtn(
                    "Continuez",
                    () => passwordForget(),
                    // () {
                    //   var phone = _selectedCode.isNotEmpty
                    //       ? _selectedCode
                    //       : '225' + _phoneController.text;
                    //   var verificationCode = Random().nextInt(10000).toString();
                    //   print(phone);
                    //   if (_phoneController.text != '') {

                    //     controller.sendSms(
                    //       phone,
                    //       'votre de verification ${verificationCode}',
                    //     );
                    //   } else {
                    //     Get.snackbar(
                    //       "Attention",
                    //       "Veuillez renseigner un numéro valide",
                    //       backgroundColor: Colors.red,
                    //       colorText: Colors.white,
                    //       snackPosition: SnackPosition.BOTTOM,
                    //     );
                    //   }
                    // },
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  passwordForget() async {
    try {
      if (_phoneController.text.trim() != '') {
        var phone = _selectedCode.isNotEmpty
            ? _selectedCode
            : '225' + _phoneController.text;
        setState(() {
          load = true;
        });
        controller.changePasswordForget(phone.trim()).whenComplete(() {
          print('----- controller.status @@@------');
          print(controller.status);
          if (controller.status == 200) {
            setState(() {
              load = false;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerifyPhoneForgetPassword(
                  phoneNumber: phone,
                ),
              ),
            );
          } else {
            setState(() {
              load = false;
            });
          }
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      Get.snackbar(
        "Attention",
        "Veuillez vérifier votre connexion internet",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
