// ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../home/home_view.dart';

class PointDeVenteController extends GetxController {
  String serverUrl = "https://mobile-app.wiqual.org";
  var status;
  var message;
  var dataListPointDeVente = [];
  var dataListCity = [];
  final box = GetStorage();

  fetchDataPointDeVente() async {
    dynamic myUrl = Uri.parse("${serverUrl}/api/v1/locations/all");

    try {
      http.Response response = await http.post(myUrl, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('access_token')}'
      });

      // Si la réponse est OK, convertissez le JSON en un objet Comite et renvoyez-le
      var data = json.decode(response.body);

      if (response.statusCode == 401) {
        dataListPointDeVente = data['data'];

        return dataListPointDeVente;
      } else {
        // Si la réponse n'est pas OK, lancez une exception
        throw Exception('Impossible de récupérer les données');
      }
    } on SocketException catch (_) {
      print('not connected');
      throw Exception('Veuillez vérifier votre connexion internet !');
    }
  }

  fetchDataCity() async {
    dynamic myUrl = Uri.parse("${serverUrl}/api/v1/settings/cities/all");

    try {
      http.Response response = await http.post(myUrl, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('access_token')}'
      });

      // Si la réponse est OK, convertissez le JSON en un objet Comite et renvoyez-le
      var data = json.decode(response.body);

      if (response.statusCode == 401) {
        dataListCity = data['data'];

        return dataListCity;
      } else {
        // Si la réponse n'est pas OK, lancez une exception
        throw Exception('Impossible de récupérer les données');
      }
    } on SocketException catch (_) {
      print('not connected');
      throw Exception('Veuillez vérifier votre connexion internet !');
    }
  }

  // Future<int> registerLocalisationData(
  //   String name,
  //   String phoneNumber,
  //   int selectedValueCategory,
  //   int selectedValueCity,
  //   String town,
  //   String address,
  //   double lat,
  //   double long,
  //   var _imageFile,
  // ) async {
  //   var myUrl = Uri.parse("$serverUrl/api/v1/locations/store");

  //   try {
  //     var imagePath = File(_imageFile.toString());
  //     http.Response response = await http.post(myUrl, headers: {
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer ${box.read('access_token')}'
  //     }, body: {
  //       "name": name,
  //       "phone_number": phoneNumber,
  //       "category_id": selectedValueCategory.toString(),
  //       "city_id": selectedValueCity.toString(),
  //       "town": town,
  //       "address": address,
  //       "lat": lat.toString(),
  //       "long": long.toString(),
  //       "photo": imagePath,
  //       "is_open": '1',
  //     });

  //     final data = json.decode(response.body);

  //     print('-------data--------#');
  //     print(data);

  //     int status = response.statusCode;
  //     print('-status-');
  //     print(status);

  //     if (status == 200) {
  //       // Get.offAllNamed('/');
  //       Get.snackbar(
  //         'Success',
  //         data['message'],
  //         backgroundColor: Color(0xFF016737),
  //         colorText: Color(0xFFFFFFFF),
  //       );
  //     } else {
  //       throw Exception('Erreur ${response.statusCode}: ${response.body}');
  //     }

  //     return status;
  //   } catch (e) {
  //     // Gérer les erreurs ici, comme les erreurs de connexion ou les erreurs lors de l'analyse JSON
  //     print("Erreur lors de la requête : $e");
  //     throw Exception('Erreur inattendue lors de la requête.');
  //   }
  // }

  Future<int> registerLocalisationData(
    String name,
    String phoneNumber,
    String selectedValueCategory,
    String selectedValueCity,
    String town,
    String address,
    double lat,
    double long,
    File imageFile, // Utilisez directement le type File pour le fichier image
  ) async {
    var myUrl = Uri.parse("$serverUrl/api/v1/locations/store");

    try {
      File compressedImageFile;

      final filePath = imageFile.path;

      final Uint8List? compressedImageData =
          await FlutterImageCompress.compressWithFile(
        filePath,
        quality: 65,
      );

      // Créez un fichier temporaire pour l'image compressée
      compressedImageFile =
          File('${Directory.systemTemp.path}/local_image.jpg');
      await compressedImageFile.writeAsBytes(compressedImageData!);

      var request = http.MultipartRequest('POST', myUrl)
        ..headers['Accept'] = 'application/json'
        ..headers['Authorization'] = 'Bearer ${box.read('access_token')}'
        ..fields["name"] = name
        ..fields["phone"] = phoneNumber
        ..fields["category_id"] = selectedValueCategory.toString()
        ..fields["city_id"] = selectedValueCity.toString()
        ..fields["town"] = town
        ..fields["address"] = address
        ..fields["lat"] = lat.toString()
        ..fields["long"] = long.toString()
        ..fields["is_open"] = '1'
        ..files.add(
          await http.MultipartFile.fromPath(
            'photo',
            compressedImageFile.path,
          ),
        );

      print('------- imageFile -------');
      print(compressedImageFile.path);

      var response = await request.send();

      final data = await response.stream.bytesToString();
      var decodedData = json.decode(data);

      int status = response.statusCode;

      if (status == 200) {
        await Get.to(Dashboard());
        Get.snackbar(
          'Success',
          decodedData['message'],
          backgroundColor: Color(0xFF016737),
          colorText: Color(0xFFFFFFFF),
        );
      } else {
        throw Exception('Erreur ${response.statusCode}: $data');
      }

      return status;
    } catch (e) {
      // Gérer les erreurs ici, comme les erreurs de connexion ou les erreurs lors de l'analyse JSON
      print("Erreur lors de la requête : $e");
      throw Exception('Erreur inattendue lors de la requête.');
    }
  }
}
