// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constantes/assets_color.dart';

class Utils {
  Utils._();

  static Future openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  static checkConnection() async {
    bool reset = false;
    do {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          // ignore: avoid_print
          print('connected');
          return true;
        }
      } on SocketException catch (_) {
        final resultat = await bottomSheetException(
            "Connexion internet non disponible",
            checkConnection: true);
        if (resultat != null && resultat) {
          reset = resultat;
        }
      }
    } while (reset);
    return false;
  }

  static bottomSheetException(e, {bool checkConnection = false}) {
    bool reset = false;
    return Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: checkConnection ? 200 : 160,
          child: Card(
            elevation: 1,
            color: Colors.white,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline,
                        size: 40, color: Colors.red.shade500),
                    const SizedBox(height: 5),
                    Text(
                      e.toString(),
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    Visibility(
                      visible: checkConnection,
                      child: TextButton.icon(
                        onPressed: () {
                          reset = true;
                          Get.back(result: reset);
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text("Réessayer"),
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

  static loaderAnimation(double size) {
    return Center(
        child: SpinKitFadingCube(
      color: AppColors.primaryBackground,
      size: size,
    ));
  }
}
