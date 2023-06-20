import 'dart:math';

import 'package:flower_app/helper/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' show basename, context;
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
        showSnackBar(context as BuildContext, 'No Image Selected');
      }
    } catch (e) {
      showSnackBar(context as BuildContext, e.toString());
    }
    notifyListeners();
  }
}
