import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flower_app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/choose_profile_img.dart';
import '../shared/data_from_forestore.dart';
import '../shared/user_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final credential = FirebaseAuth.instance.currentUser!;
  String? url;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final chooseImage = Provider.of<ChooseProfileImg>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: const Text('Profile Page'),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              Navigator.pop(context);
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 22),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 194, 194, 194),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    children: [
                      chooseImage.imgPath == null
                          ? const ImageUser()
                          : Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: FileImage(chooseImage.imgPath!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      Positioned(
                        bottom: -5,
                        right: -12,
                        child: IconButton(
                          onPressed: () async {
                            await chooseImage.uplaodImage(ImageSource.gallery);
                            if (chooseImage.imgPath != null) {
                              final storageRef = FirebaseStorage.instance
                                  .ref(chooseImage.imgName);
                              await storageRef.putFile(chooseImage.imgPath!);
                              url = await storageRef.getDownloadURL();
                              users.doc(credential.uid).update({
                                "imgUrl": url,
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(255, 131, 177, 255)),
                  child: const Text(
                    'Info From Firebase Auth',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email: ${credential.email}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Created At: ${DateFormat("MMMM d,y").format(credential.metadata.creationTime!)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Last Signed In: ${DateFormat("MMMM d,y").format(credential.metadata.lastSignInTime!)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    credential.delete();
                    if (!mounted) return;
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: const Text(
                    'Delete User',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(255, 131, 177, 255)),
                  child: const Text(
                    'Info From Firebase Firestore',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              GetDataFromFirestore(documentId: credential.uid)
            ],
          ),
        ),
      ),
    );
  }
}
