// ignore_for_file: dead_code, avoid_print, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChampInput {
  static TextFieldInput(
      String libelle, String label, controller, TextInputType textInputType) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            libelle,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xffe7e4e4)),
            ),
            child: Center(
              child: TextField(
                keyboardType: textInputType,
                controller: controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: '',
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white),
                    borderRadius: new BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white),
                    borderRadius: new BorderRadius.circular(25.7),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static TextFieldInputPassord(
      String libelle, String label, controller, TextInputType textInputType) {
    final _obscure = true.obs;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            libelle,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xffe7e4e4)),
            ),
            child: Center(
              child: Obx(
                () => TextField(
                  keyboardType: textInputType,
                  controller: controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: '',
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.white),
                      borderRadius: new BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.white),
                      borderRadius: new BorderRadius.circular(25.7),
                    ),
                    suffixIcon: GestureDetector(
                      child: Container(
                        width: 25,
                        height: 25,
                        padding: const EdgeInsetsDirectional.only(
                          start: 10,
                          end: 10,
                        ),
                        alignment: Alignment.center,
                        child: Obx(
                          () => Icon(
                            _obscure.value
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined,
                            size: 18,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      onTap: () {
                        _obscure.value = !_obscure.value;
                        Get.appUpdate();
                      },
                    ),
                  ),
                  obscureText: _obscure.value,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static TextFieldInputCode(controller, TextInputType textInputType) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 62,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xffe7e4e4)),
              borderRadius: BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.zero,
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.zero,
              ),
            ),
            child: Center(
              child: TextField(
                readOnly: true,
                keyboardType: textInputType,
                controller: controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: '',
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 0.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static TextFieldInputNumber(controller, TextInputType textInputType, width) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xffe7e4e4)),
              borderRadius: BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.zero,
                bottomLeft: Radius.zero,
                bottomRight: Radius.circular(8.0),
              ),
            ),
            child: Center(
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: textInputType,
                controller: controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: '',
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
