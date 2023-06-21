import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ImageUser extends StatefulWidget {
  const ImageUser({super.key});

  @override
  State<ImageUser> createState() => _ImageUserState();
}

class _ImageUserState extends State<ImageUser> {
  final credential = FirebaseAuth.instance.currentUser!;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(credential.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          // ${data['title']}
          return Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage("${data["imgUrl"]}"),
                fit: BoxFit.cover,
              ),
            ),
          );
        }

        return const Text("loading");
      },
    );
  }
}



// Image.network(
//             "${data["imgUrl"]}",
//             width: 150,
//             height: 150,
//           );