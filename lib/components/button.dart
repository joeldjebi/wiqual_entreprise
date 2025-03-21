// ignore_for_file: sort_child_properties_last, sized_box_for_whitespace, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

import '../core/constantes/assets_color.dart';
import '../main.dart';

class Bouton {

  static primaryBtn(
    label,
    Function function, {
    bgColor = Colors.transparent,
    textColor = Colors.black,
    double width = double.infinity,
  }) {
    if (bgColor == Colors.transparent) {
      bgColor = AppColors.primaryBackground;
    }
    return Container(
      width: width,
      child: ElevatedButton(
        onPressed: () => function(),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 18.0,
            bottom: 18.0,
          ),
          child: Text(
            label,
            style: myTextStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor, elevation: 0, backgroundColor: bgColor, // foreground
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  static secondBtnIcon(
    label,
    image,
    function, {
    bgColor = Colors.transparent,
    textColor = Colors.white,
    double width = double.infinity,
  }) {
    if (bgColor == Colors.transparent) {
      bgColor = AppColors.secondBackground;
    }
    return Container(
      width: width,
      child: ElevatedButton(
        onPressed: () => function(),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 13.0,
            bottom: 13.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image,
              SizedBox(
                width: 5,
              ),
              Text(
                label,
                style: myTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor, elevation: 0, backgroundColor: bgColor, // foreground
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  static textBtn(
    label,
    function, {
    Color textColor = Colors.black,
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: textColor, textStyle: myTextStyle.copyWith(fontSize: 14), // foreground
      ),
      onPressed: () => function(),
      child: Text(
        label,
        style: myTextStyle.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.primaryBackground,
        ),
      ),
    );
  }
  static textBtnOnboardin(
    label,
    function, {
    Color textColor = Colors.black,
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: textColor, textStyle:  myTextStyle.copyWith(fontSize: 16), // foreground
      ),
      onPressed: () => function(),
      child: Text(
        label,
        style: myTextStyle.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  static primaryBtnTab(
    label,
    Function function, {
    bgColor = Colors.transparent,
    textColor = Colors.black,
    double width = double.infinity,
  }) {
    if (bgColor == Colors.transparent) {
      bgColor = AppColors.primaryBackground;
    }
    return Container(
      width: width,
      child: ElevatedButton(
        onPressed: () => function(),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 10.0,
          ),
          child: Text(
            label,
            style: myTextStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor, elevation: 0, backgroundColor: bgColor, // foreground
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
