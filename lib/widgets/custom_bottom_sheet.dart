import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../provider/choose_profile_img.dart';

class ShowModalBottomSheet extends StatelessWidget {
  const ShowModalBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    final selectImage = Provider.of<ChooseProfileImg>(context);
    return Container(
      padding: const EdgeInsets.all(8),
      height: 100,
      alignment: Alignment.centerRight,
      child: Column(
        // mainAxisAlignment:,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              selectImage.uplaodImage(ImageSource.camera);
              Navigator.pop(context);
            },
            child: Row(
              children: const [
                Icon(
                  Icons.photo_camera,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Camera',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: .6,
          ),
          GestureDetector(
            onTap: () {
              selectImage.uplaodImage(ImageSource.gallery);
              Navigator.pop(context);
            },
            child: Row(
              children: const [
                Icon(Icons.photo, color: Colors.grey),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Gallery',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
