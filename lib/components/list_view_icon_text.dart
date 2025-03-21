// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../core/constantes/assets_color.dart';
import '../main.dart';

class IconsAndTitle extends StatelessWidget {
  final IconData? icon1;
  final IconData? icon2;
  final String? title;
  final void Function()? onTap;

   IconsAndTitle({
    this.icon1,
    this.icon2,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.secondBackgroundActive,
                      ),
                      child: Icon(
                        icon1,
                        color: AppColors.primaryBackground,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      title!,
                      style: myTextStyle.copyWith(
                        fontSize: 16,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
                Icon(
                  icon2,
                  color: AppColors.textColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
