// ignore_for_file: unused_import, sort_child_properties_last, prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../core/constantes/assets_color.dart';
import '../features/auth/profil/index.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

class TopMenu {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Container(
        color: Color(0xfff7f7f8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.to(ProfilPage()),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Mon compte',
                    style: myTextStyle.copyWith(
                      fontSize: 16,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffe4e4e4),
                ),
              ),
            ),
            // IconButton(
            //   icon: const Icon(
            //     Icons.settings,
            //     size: 30,
            //   ),
            //   onPressed: () {
            //     showModalBottomSheet(
            //       context: context,
            //       isScrollControlled: true,
            //       isDismissible: true,
            //       backgroundColor: Colors.transparent,
            //       builder: (context) => Container(
            //         height: MediaQuery.of(context).size.height * 0.90,
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.only(
            //             topLeft: const Radius.circular(25.0),
            //             topRight: const Radius.circular(25.0),
            //           ),
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Row(
            //                 children: [
            //                   Container(
            //                     height: 45,
            //                     width: 45,
            //                     child: IconButton(
            //                       icon: const Icon(
            //                         Icons.close,
            //                         color: Colors.white,
            //                       ),
            //                       onPressed: () => Navigator.of(context).pop(),
            //                     ),
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(50),
            //                       color: Color(0xfffb5607),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     width: 10,
            //                   ),
            //                   Text(
            //                     "Paramètres de l'application",
            //                     style: const TextStyle(
            //                       fontWeight: FontWeight.bold,
            //                       color: Color(0xff000000),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               SizedBox(
            //                 height: 20,
            //               ),
            //               Row(
            //                 children: [
            //                   SizedBox(
            //                     width: 5,
            //                   ),
            //                   Container(
            //                     height: 40,
            //                     width: 40,
            //                     child: IconButton(
            //                       icon: const Icon(
            //                         Icons.share,
            //                         color: Colors.black,
            //                         size: 20,
            //                       ),
            //                       onPressed: () => Navigator.of(context).pop(),
            //                     ),
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(50),
            //                       color: Color(0xffe4e4e4),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               Divider(),
            //               Row(
            //                 children: [
            //                   SizedBox(
            //                     width: 5,
            //                   ),
            //                   Container(
            //                     height: 40,
            //                     width: 40,
            //                     child: IconButton(
            //                       icon: const Icon(
            //                         Icons.star,
            //                         color: Colors.black,
            //                         size: 20,
            //                       ),
            //                       onPressed: () => Navigator.of(context).pop(),
            //                     ),
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(50),
            //                       color: Color(0xffe4e4e4),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     width: 10,
            //                   ),
            //                   Text(
            //                     "Noter l'application",
            //                     style: const TextStyle(
            //                       color: Color(0xff000000),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               Divider(),
            //               Row(
            //                 children: [
            //                   SizedBox(
            //                     width: 5,
            //                   ),
            //                   Container(
            //                     height: 40,
            //                     width: 40,
            //                     child: IconButton(
            //                       icon: const Icon(
            //                         Icons.verified_user_sharp,
            //                         color: Colors.black,
            //                         size: 20,
            //                       ),
            //                       onPressed: () => Navigator.of(context).pop(),
            //                     ),
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(50),
            //                       color: Color(0xffe4e4e4),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     width: 10,
            //                   ),
            //                   Text(
            //                     "Condifition d'utilisation",
            //                     style: const TextStyle(
            //                       color: Color(0xff000000),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               Divider(),
            //               Row(
            //                 children: [
            //                   SizedBox(
            //                     width: 5,
            //                   ),
            //                   Container(
            //                     height: 40,
            //                     width: 40,
            //                     child: IconButton(
            //                       icon: const Icon(
            //                         Icons.link,
            //                         color: Colors.black,
            //                         size: 20,
            //                       ),
            //                       onPressed: () => Navigator.of(context).pop(),
            //                     ),
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(50),
            //                       color: Color(0xffe4e4e4),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     width: 10,
            //                   ),
            //                   Text(
            //                     "Visiter notre site internet",
            //                     style: const TextStyle(
            //                       color: Color(0xff000000),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               Divider(),
            //               SizedBox(
            //                 height: MediaQuery.of(context).size.height * 0.45,
            //               ),
            //               Center(
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   // ignore: prefer_const_literals_to_create_immutables
            //                   children: [
            //                     Text(
            //                       'Version 1.0.0',
            //                       textAlign: TextAlign.center,
            //                     ),
            //                   ],
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
