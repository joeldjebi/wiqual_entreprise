// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/sharpref.dart';
import '../../models/User.dart';
import '../home/home_view.dart';
import 'otp_forget_password.dart';

class UserController extends GetxController {
  String serverUrl = "https://mobile-app.wiqual.org";
  var status;
  var message;
  final box = GetStorage();
  var token = "".obs;
  var jsonDataProfil;

  var name = "".obs;
  var pays = "".obs;
  var ville = "".obs;
  var avatarUser = "".obs;

  // loginUser(String phoneNumber, String password) async {
  //   dynamic myUrl = Uri.parse("$serverUrl/api/v1/login");

  //   try {
  //     http.Response response = await http.post(myUrl, headers: {
  //       'Accept': 'application/json',
  //     }, body: {
  //       "email_mobile": phoneNumber,
  //       "password": password,
  //     });

  //     final data = json.decode(response.body);
  //     message = data['error'];
  //     print(message);
  //     status = response.statusCode;
  //     if (response.statusCode == 200) {
  //       UserModel user = await UserModel.fromJson(data['user']);
  //       await EventPref.saveUser(user);

  //       token.value = await data['access_token'];

  //       box.write('access_token', token.value);
  //     } else {
  //       Get.snackbar(
  //         'Attention',
  //         message,
  //         backgroundColor: Color.fromARGB(255, 219, 5, 16),
  //         colorText: Color(0xFFFFFFFF),
  //       );
  //     }
  //   } catch (e) {
  //     Get.snackbar('Oups', "Une erreur est survenue ! ${e}");
  //     print(e);
  //   }
  // }

// Méthode pour désactiver la vérification du certificat SSL
bool trustSelfSigned = true;
HttpClient httpClient = HttpClient()
  ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
Future<void> loginUser(String phoneNumber, String password) async {
  try {
    dynamic myUrl = Uri.parse("$serverUrl/api/v1/login");

    HttpClientRequest request = await httpClient.postUrl(myUrl);
    request.headers.set('Accept', 'application/json');
    request.headers.set('Content-Type', 'application/json'); // Ajout du type de contenu

    // Conversion des données en JSON et envoi dans le corps de la requête
    String jsonData = jsonEncode({
      "email_mobile": phoneNumber,
      "password": password,
    });

    request.write(jsonData); // Écriture des données JSON dans le corps de la requête

    HttpClientResponse response = await request.close();

    // Lire la réponse
    String responseBody = await response.transform(utf8.decoder).join();
    final data = json.decode(responseBody);

    print('----- data ----');
    print(data);

    String message = data['message'];

    print('---message---');
    print(message);


    int status = response.statusCode;
    print('---status---');
    print(status);

    if (status == 200) {
      UserModel user = UserModel.fromJson(data['user']);
      await EventPref.saveUser(user);

      print('----- user.name ----');
      print(user.name);
      print(user.mobile);
      print(user.email);
      print(user.uniqId);

      String tokenValue = data['access_token'];
      token.value = tokenValue;

      box.write('access_token', tokenValue);
      Get.to(Dashboard());
    } else {
      Get.snackbar(
        'Attention',
        message,
        backgroundColor: Color.fromARGB(255, 219, 5, 16),
        colorText: Color(0xFFFFFFFF),
      );
    }
  } catch (e) {
    Get.snackbar('Oups', "Une erreur est survenue ! ${e}");
    print("Une erreur est survenue ! ${e}");
    print(e);
  }
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

      if (response.statusCode == 200) {
        jsonDataProfil = jsonDecode(response.body);
        return jsonDataProfil;
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      print(error);
    }
  }

  // MODIFICATION DES INFORMATIONS D L'UTILISATEUR
  updateUser(
    String name,
    String pays,
    String ville,
  ) async {
    // Requête API pour mettre à jour le mot de passe
    dynamic myUrl = Uri.parse("$serverUrl/api/v1/user-update");

    http.Response response = await http.post(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('access_token')}'
    }, body: {
      "name": name,
      "pays": pays,
      "ville": ville,
    });

    final data = json.decode(response.body);
    message = data['message'];
    status = response.statusCode;

    if (response.statusCode == 200) {
      UserModel user = await UserModel.fromJson(data['user']);
      await EventPref.saveUser(user);

      Get.to(Dashboard());
      Get.snackbar('Succès', 'Profil modifié avec succès.');
    } else {
      // if (Get.isOverlaysOpen) {
      //   Get.find<UserController>().updateUser(name, pays,ville);
      // }
      Get.snackbar('Erreur', 'Une erreur est survenue veuillez recommencer.');
    }
  }

  Future<void> sendSms(String recipient, String message) async {
    String apiUrl = "http://jaimeboutik.com/API/";
    String apiKey =
        "1d9aa67969b780c480ed5693213f1990:fX6d05woJdwq8ksc5ega4m9NjGwSIBCu";
    String username = "wiqual";
    String sender = "Wiqual";
    String unicode = "0";
    String mms = "0";
    String media = "";

    Uri myUrl = Uri.parse(
      "$apiUrl?action=compose&username=$username&api_key=$apiKey&sender=$sender&to=$recipient&message=$message&unicode=$unicode&mms=$mms&media=$media",
    );

    http.Response response = await http.get(
      myUrl,
      headers: {
        'Accept': 'application/json',
      },
    );

    int statusCode = response.statusCode;
    String responseData = response.body;

    print("********* RESPONSE DATA *********");
    print(responseData);
    print(statusCode);
    Get.to(() => VerifyPhoneForgetPassword(
          phoneNumber: recipient,
          verificationCode: message,
        ));
  }

  changePasswordForget(
    String mobile,
  ) async {
    // Requête API pour mettre à jour le mot de passe
    dynamic myUrl =
        Uri.parse("$serverUrl/api/v1/users/${mobile}/send-password-reset-code");

    http.Response response = await http.get(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('access_token')}'
    });

    final data = json.decode(response.body);
    message = data['message'];

    status = response.statusCode;

    print('------response.statusCode -----');
    print(status);
    print('------DATA -----');
    print(data);

    // Vérifiez si la requête a réussi
    if (response.statusCode == 200) {
      Get.snackbar(
        'Success',
        message,
        backgroundColor: Color(0xFF016737),
        colorText: Color(0xFFFFFFFF),
      );
      return data['error'];
    } else {
      Get.snackbar('Échèc', message);
      return false;
    }
  }

  changePasswordResetCode(
    String mobile,
    String code,
  ) async {
    // Requête API pour mettre à jour le mot de passe
    dynamic myUrl = Uri.parse("$serverUrl/api/v1/users/verify-reset-code");

    print(myUrl);

    http.Response response = await http.post(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('access_token')}'
    }, body: {
      "mobile": mobile,
      "code": code,
    });

    final data = json.decode(response.body);
    message = data['message'];

    status = response.statusCode;
    print('------response.statusCode -----');
    print(status);

    print('------DATA -----');
    print(data);

    // Vérifiez si la requête a réussi
    if (status == 200) {
      Get.snackbar(
        'Success',
        message,
        backgroundColor: Color(0xFF016737),
        colorText: Color(0xFFFFFFFF),
      );
      return data['error'];
    } else {
      Get.snackbar('Échèc', message);
      return false;
    }
  }

  changePasswordResetPassword(
    String mobile,
    String code,
    String new_password,
    String new_password_confirmation,
  ) async {
    // Requête API pour mettre à jour le mot de passe
    dynamic myUrl = Uri.parse("$serverUrl/api/v1/users/reset-password");

    http.Response response = await http.post(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('access_token')}'
    }, body: {
      "mobile": mobile,
      "code": code,
      "new_password": new_password,
      "new_password_confirmation": new_password_confirmation,
    });

    final data = json.decode(response.body);
    message = data['message'];

    status = response.statusCode;
    print('------response.statusCode -----');
    print(status);

    print('------DATA -----');
    print(data);

    // Vérifiez si la requête a réussi
    if (status == 200) {
      Get.snackbar(
        'Success',
        message,
        backgroundColor: Color(0xFF016737),
        colorText: Color(0xFFFFFFFF),
      );
      return data['error'];
    } else {
      Get.snackbar('Échèc', message);
      return false;
    }
  }

  changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    // Requête API pour mettre à jour le mot de passe
    dynamic myUrl = Uri.parse("$serverUrl/api/v1/update-password");

    print(myUrl);

    http.Response response = await http.post(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('access_token')}'
    }, body: {
      "lastpassword": oldPassword,
      "password": newPassword,
      "password_confirmation": newPassword,
    });

    final data = json.decode(response.body);
    message = data['message'];

    print('------token -----');
    print(box.read('access_token'));
    print(response.statusCode);
    print(data);

    // Vérifiez si la requête a réussi
    if (response.statusCode == 200) {
      Get.snackbar(
        'Success',
        message,
        backgroundColor: Color(0xFF016737),
        colorText: Color(0xFFFFFFFF),
      );
      return true;
    } else {
      Get.snackbar('Échèc', message);
      return false;
    }
  }

  iniGetUserData() async {
    final prefs = await SharedPreferences.getInstance();

    name.value = await prefs.getString('name').toString();
    pays.value = await prefs.getString('pays').toString();
    ville.value = await prefs.getString('ville').toString();
    avatarUser.value = await prefs.getString('avatarUser').toString();
  }

  saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}
