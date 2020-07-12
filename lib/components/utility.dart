import 'dart:typed_data';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class Utility {
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Future<String> convertImageToBaseString(PickedFile pf) async {
    var intBytes = await pf.readAsBytes();
    return base64Encode(intBytes);
  }

//  static String baseStringFromImage(Image image) async {
//    final bytes = image.image.re
//  }
}
