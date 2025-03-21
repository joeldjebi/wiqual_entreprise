// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiqual_entreprise/features/auth/profil/edit_password_forget.dart';

import '../../components/button.dart';
import 'auth_controller.dart';
import 'pad.dart';
import 'profil/edit_password.dart';

class VerifyPhoneForgetPassword extends StatefulWidget {
  final String phoneNumber;
  final String? verificationCode;

  VerifyPhoneForgetPassword({required this.phoneNumber, this.verificationCode});

  @override
  _VerifyPhoneForgetPasswordState createState() =>
      _VerifyPhoneForgetPasswordState();
}

class _VerifyPhoneForgetPasswordState extends State<VerifyPhoneForgetPassword> {
  var controller = Get.put(UserController());
  String code = "";

  int _counter = 29;
  late Timer _timer;

  bool load = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter--;
        if (_counter == 0) {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          "Code de vérification envoyé au\n ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF000000),
                          ),
                        ),

                        //widget.phoneNumbe
                        Text(
                          widget.phoneNumber,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.bold,
                            height: .1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buildCodeNumberBox(
                            code.length > 0 ? code.substring(0, 1) : ""),
                        buildCodeNumberBox(
                            code.length > 1 ? code.substring(1, 2) : ""),
                        buildCodeNumberBox(
                            code.length > 2 ? code.substring(2, 3) : ""),
                        buildCodeNumberBox(
                            code.length > 3 ? code.substring(3, 4) : ""),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Vous n'avez pas reçu de code ? ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF000000),
                          ),
                        ),
                        _counter == 0
                            ? GestureDetector(
                                onTap: () => passwordForget(),
                                // onTap: () {
                                //   var phone = widget.phoneNumber;
                                //   var verificationCode =
                                //       Random().nextInt(10000).toString();
                                //   Get.to(() => VerifyPhoneForgetPassword(
                                //         phoneNumber: phone,
                                //         verificationCode: verificationCode,
                                //       ));

                                //   controller.sendSms(
                                //     phone,
                                //     'votre de verification ${verificationCode}',
                                //   );
                                // },
                                child: Text(
                                  "Renvoyer le code",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : Text("Réeseyez dans $_counter secondes."),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.13,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Bouton.primaryBtn(
                      "Vérifier le code",
                      () => resetCode(),
                      // () {
                      //   var phone = widget.phoneNumber;
                      //   var verificationCode = widget.verificationCode;
                      //   if (verificationCode == code) {
                      //     Get.to(
                      //       () => EditPassword(
                      //           // phoneNumber: phone,
                      //           ),
                      //     );
                      //     Get.snackbar(
                      //       "Attention",
                      //       "Veillez renseigner les champs ci-dessus vous terminer votre inscription.",
                      //       backgroundColor: Colors.green,
                      //       colorText: Colors.white,
                      //       snackPosition: SnackPosition.BOTTOM,
                      //     );
                      //   } else {
                      //     Get.snackbar(
                      //       "Attention",
                      //       "Vous avez renseigner un mauvais code",
                      //       backgroundColor: Colors.redAccent,
                      //       colorText: Colors.white,
                      //       snackPosition: SnackPosition.BOTTOM,
                      //     );
                      //   }
                      // },
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          NumericPad(
            onNumberSelected: (value) {
              print(value);
              setState(() {
                if (value != -1) {
                  if (code.length < 4) {
                    code = code + value.toString();
                  }
                } else {
                  code = code.substring(0, code.length - 1);
                }
                print(code);
              });
            },
          ),
        ],
      )),
    );
  }

  Widget buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF6F5FA),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 25.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 0.75))
            ],
          ),
          child: Center(
            child: Text(
              codeNumber,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ),
    );
  }

  resetCode() async {
    try {
      if (widget.phoneNumber != '' && code != '') {
        var phone = widget.phoneNumber;
        setState(() {
          load = true;
        });
        controller
            .changePasswordResetCode(phone, code.toString())
            .whenComplete(() async {
          print('----- controller.status@ ------');
          print(controller.status);
          if (controller.status == 200) {
            setState(() {
              load = false;
            });
            await Get.to(
              EditPasswordForget(
                phoneNumber: phone,
                code: code,
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

  passwordForget() async {
    try {
      if (widget.phoneNumber != '') {
        var phone = widget.phoneNumber;
        setState(() {
          load = true;
        });
        controller.changePasswordForget(phone.trim()).whenComplete(() {
          print('----- controller.status ------');
          print(controller.status);
          if (controller.status == 200) {
            setState(() {
              load = false;
            });
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => VerifyPhoneForgetPassword(
            //       phoneNumber: phone,
            //     ),
            //   ),
            // );
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
