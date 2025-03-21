// ignore_for_file: prefer_const_constructors, unused_field

import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../components/button.dart';
import '../../core/constantes/assets_color.dart';
import '../home/home_view.dart';
import 'point_de_vente_controller.dart';
import 'package:http/http.dart' as http;

class StorePointDeVentePage extends StatefulWidget {
  @override
  State<StorePointDeVentePage> createState() => _StorePointDeVentePageState();
}

class _StorePointDeVentePageState extends State<StorePointDeVentePage> {
  var selectedValueCategory;
  var selectedValueCity;
  final box = GetStorage();

  final TextEditingController textEditingPaysController =
      TextEditingController();
  final TextEditingController textEditingCommuneController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phone_numberController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  TextEditingController _textEditingController = TextEditingController();

  PointDeVenteController pointDeVenteController =
      Get.put(PointDeVenteController());
  bool load = false;
  List<dynamic> dataListCity = [];
  List<dynamic> dataListCategory = [];
  late File? _imageFile = null;
  bool imageSelected = false;

  Position? currentPosition;

  getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Le service de localisation n\'est pas activé.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        print('L\'utilisateur n\'a pas autorisé l\'accès à la localisation.');
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (position != null) {
      print(
          'Position récupérée avec succès : Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    } else {
      print('Impossible de récupérer la position de l\'utilisateur.');
    }

    setState(() {
      currentPosition = position;
    });
  }

  @override
  void dispose() {
    textEditingPaysController.dispose();
    textEditingCommuneController.dispose();
    getCurrentLocation();
    pointDeVenteController.fetchDataPointDeVente();
    super.dispose();
  }

  @override
  void initState() {
    fetchDataCity();
    fetchDataCategory();
    getCurrentLocation();
    super.initState();
  }

  Future<void> fetchDataCity() async {
    dynamic myUrl =
        Uri.parse("https://mobile-app.wiqual.org/api/v1/settings/cities/all");

    try {
      http.Response response = await http.get(myUrl, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('access_token')}'
      });

      var data = json.decode(response.body);

      if (response.statusCode == 401) {
        setState(() {
          dataListCity = data['data'];
        });
      } else {
        throw Exception('Impossible de récupérer les données');
      }
    } catch (e) {
      print('Erreur lors de la récupération des données : $e');
      throw Exception('Veuillez vérifier votre connexion internet !');
    }
  }

  Future<void> fetchDataCategory() async {
    dynamic myUrl = Uri.parse(
        "https://mobile-app.wiqual.org/api/v1/settings/categories/all");

    try {
      http.Response response = await http.get(myUrl, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('access_token')}'
      });

      var data = json.decode(response.body);

      if (response.statusCode == 401) {
        setState(() {
          dataListCategory = data['data'];
        });
      } else {
        throw Exception('Impossible de récupérer les données');
      }
    } catch (e) {
      print('Erreur lors de la récupération des données : $e');
      throw Exception('Veuillez vérifier votre connexion internet !');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Point de ventes',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      "Enregistrement de point de vente",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      "Le système va récupérer la location automatiquement",
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade800),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Nom du point de vente",
                        labelStyle: TextStyle(
                            fontSize: 14, color: Colors.grey.shade800),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.primaryBackground,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextField(
                      controller: _phone_numberController,
                      decoration: InputDecoration(
                        labelText: "Numéro de téléphhone",
                        labelStyle: TextStyle(
                            fontSize: 14, color: Colors.grey.shade800),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.primaryBackground,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.bgColorShimmer,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'Catégorie',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          items: dataListCategory
                              .map((item) => DropdownMenuItem<String>(
                                    value: item['id'].toString(),
                                    child: Text(
                                      item['name'].toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: selectedValueCategory,
                          onChanged: (value) {
                            setState(() {
                              selectedValueCategory = value;
                            });
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 60,
                            width: 700,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                          dropdownSearchData: DropdownSearchData(
                            searchController: textEditingPaysController,
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              height: 50,
                              width: 700,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                controller: textEditingPaysController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'Rechercher une catégorie...',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              return item.value
                                  .toString()
                                  .contains(searchValue);
                            },
                          ),
                          //This to clear the search value when you close the menu
                          onMenuStateChange: (isOpen) {
                            if (!isOpen) {
                              textEditingPaysController.clear();
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.bgColorShimmer,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'Commune',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          items: dataListCity
                              .map((item) => DropdownMenuItem<String>(
                                    value: item['id'].toString(),
                                    child: Text(
                                      item['name'].toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: selectedValueCity,
                          onChanged: (value) {
                            setState(() {
                              selectedValueCity = value;
                            });
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 60,
                            width: 700,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                          dropdownSearchData: DropdownSearchData(
                            searchController: textEditingCommuneController,
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              width: 700,
                              height: 50,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                controller: textEditingCommuneController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'Rechercher une commune...',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              return item.value
                                  .toString()
                                  .contains(searchValue);
                            },
                          ),
                          //This to clear the search value when you close the menu
                          onMenuStateChange: (isOpen) {
                            if (!isOpen) {
                              textEditingCommuneController.clear();
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextField(
                      controller: _townController,
                      decoration: InputDecoration(
                        labelText: "Quartier",
                        labelStyle: TextStyle(
                            fontSize: 14, color: Colors.grey.shade800),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.primaryBackground,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: "Description de l'adresse",
                        labelStyle: TextStyle(
                            fontSize: 14, color: Colors.grey.shade800),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.primaryBackground,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Coordonnées GPS',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextField(
                                controller: _textEditingController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: "--",
                                  labelStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade800),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: AppColors.primaryBackground,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _textEditingController.text =
                                      '${currentPosition!.latitude}, ${currentPosition!.longitude}';
                                });
                              },
                              icon: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryBackground,
                                  border: Border.all(
                                    color: AppColors.primaryBackground,
                                    style: BorderStyle.solid,
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Icon(
                                  Icons.location_on,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.95,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xffe7e4e4)),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            title: 'Choisissez une image',
                            btnCancelText: "Galérie",
                            btnOkText: "Appareil Photo",
                            btnCancelColor: Color(0XFF000000),
                            btnOkColor: Color(0XFF1430ff),
                            btnCancelOnPress: () async {
                              final pickedFile = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              setState(() {
                                if (pickedFile != null) {
                                  _imageFile = File(pickedFile.path);
                                  imageSelected = true;
                                } else {
                                  imageSelected = false;
                                }
                              });
                            },
                            btnOkOnPress: () async {
                              final pickedFile = await ImagePicker()
                                  .pickImage(source: ImageSource.camera);
                              setState(() {
                                if (pickedFile != null) {
                                  _imageFile = File(pickedFile.path);
                                  print('----- _imageFile -------#');
                                  print(_imageFile);
                                  imageSelected = true;
                                } else {
                                  imageSelected = false;
                                }
                              });
                            },
                          ).show();
                        },
                        child: _imageFile == null
                            ? Icon(
                                Icons.camera_alt,
                                size: 30,
                                color: Colors.grey.shade800,
                              )
                            : Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.file(
                                    _imageFile!,
                                    width: 200,
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _imageFile = null;
                                          imageSelected = false;
                                        });
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    load == false
                        ? Bouton.primaryBtn(
                            "Enregistrer",
                            () => {
                              savePointDeVente(),
                            },
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  savePointDeVente() async {
    try {
      if (_textEditingController.text.trim() != '' ||
          _nameController.text.trim() != '' ||
          _addressController.text.trim() != '' ||
          _townController.text.trim() != '' ||
          _phone_numberController.text.trim() != '') {
        setState(() {
          load = true;
        });
        var category = selectedValueCategory.toString();
        var city = selectedValueCity.toString();

        print('---load--');
        print(load);

        int? statusData = await pointDeVenteController.registerLocalisationData(
          _nameController.text.toString(),
          _phone_numberController.text.toString(),
          category,
          city,
          _townController.text.toString(),
          _addressController.text.toString(),
          currentPosition!.latitude,
          currentPosition!.longitude,
          _imageFile!,
        );

        print('---statusData----');
        print(statusData);

        if (statusData == 200) {
          setState(() {
            load = false;
            Get.to(Dashboard());
          });
          print('---- load ----');
          print(load);
          await Get.to(Dashboard());
        } else {
          setState(() {
            load = false;
          });
        }
      } else {
        Get.snackbar(
          "Attention",
          "Tout les champs sont obligatoire",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
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
