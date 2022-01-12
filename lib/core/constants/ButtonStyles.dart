import 'package:flutter/material.dart';
import 'package:otomasyon/core/constants/CustomColors.dart';

class CustomButtonStyles {
  static final ButtonStyle palatinateBlueButton = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w400),
      primary: CustomColors.palatinateBlue,
      onPrimary: CustomColors.white,
      padding: EdgeInsets.all(12),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.all(Radius.circular(15)),
      ),minimumSize: Size(190, 40)
  );
}
