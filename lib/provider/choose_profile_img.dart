import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' show basename;
import 'package:image_picker/image_picker.dart';

class ChooseProfileImg with ChangeNotifier {
  File? imgPath;
  String? imgName;
  uplaodImage(ImageSource imageSource) async {
    final pickImage = await ImagePicker().pickImage(source: imageSource);

    try {
      if (pickImage != null) {
        imgPath = File(pickImage.path);
        imgName = basename(pickImage.path);
        int random = Random().nextInt(99999);
        imgName = "$random$imgName";
        print(imgName);
      } else {
        print('No Image Selected');
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }
}
