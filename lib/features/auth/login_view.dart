// ignore_for_file: camel_case_types, use_key_in_widget_constructors, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_const_constructors, unused_field, prefer_typing_uninitialized_variables, prefer_final_fields, avoid_print, sized_box_for_whitespace

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wiqual_entreprise/features/auth/password_forget.dart';
import '../../components/button.dart';
import '../../components/champ_input.dart';
import '../../core/constantes/assets_color.dart';
import '../home/home_view.dart';
import 'auth_controller.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  PageLoginState createState() => PageLoginState();
}

class PageLoginState extends State<PageLogin> {
  var controller = Get.put(UserController());
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
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // fermer le clavier lorsque le champ de saisie perd le focus
        FocusScope.of(context).unfocus();
      }
    });
  }

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final phoneNumber = '225';
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColors.secondBackground,
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              // fermer le clavier lorsque l'utilisateur tape en dehors du champ de saisie
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Connectez vous ",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                                  _selectedCode =
                                                      value.toString();
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
                                        width: 61,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Color(0xffe7e4e4)),
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
                                            Text(
                                              _selectedCode.isNotEmpty
                                                  ? _selectedCode
                                                  : '225',
                                            ),
                                          ],
                                        ),
                                      ),
                                      ChampInput.TextFieldInputNumber(
                                        _phoneController,
                                        TextInputType.phone,
                                        MediaQuery.of(context).size.width *
                                            0.73,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ChampInput.TextFieldInputPassord(
                            'Mot de passe',
                            '',
                            _passwordController,
                            TextInputType.visiblePassword,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Bouton.textBtn(
                        "Mot de passe oublié",
                        () => Get.to(() => MotDePasseOubliePage()),
                        // width: 100,
                        textColor: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 6,
                    ),
                    load == false
                        ? Bouton.primaryBtn(
                            "Se connecter",
                            () => loginUser(),
                            textColor: Colors.white,
                          )
                        : Container(
                            height: 50,
                            child: Center(
                              child: LoadingAnimationWidget.discreteCircle(
                                color: Colors.white,
                                size: 20,
                                secondRingColor: AppColors.primaryBackground,
                                thirdRingColor: AppColors.secondBackground,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  loginUser() async {
    try {
      if (_phoneController.text.trim() != '' ||
          _passwordController.text.trim() != '') {
        var phone = _selectedCode.isNotEmpty
            ? _selectedCode
            : '225' + _phoneController.text;
        setState(() {
          load = true;
        });
        controller
            .loginUser(
          phone.trim(),
          _passwordController.text.trim(),
        )
            .whenComplete(() {
          print(controller.status);
          if (controller.status == 200) {
            setState(() {
              load = false;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
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
