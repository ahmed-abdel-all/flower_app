import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/shared/colors.dart';
import 'package:flutter/material.dart';

class GetDataFromFirestore extends StatefulWidget {
  final String documentId;
  const GetDataFromFirestore({super.key, required this.documentId});

  @override
  State<GetDataFromFirestore> createState() => _GetDataFromFirestoreState();
}

class _GetDataFromFirestoreState extends State<GetDataFromFirestore> {
  final dialogUserController = TextEditingController();
  final credential = FirebaseAuth.instance.currentUser!;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  showingDilaog(Map<String, dynamic> data, String myKey) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
          child: Container(
            padding: const EdgeInsets.all(22),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  controller: dialogUserController,
                  maxLength: 20,
                  decoration: InputDecoration(hintText: '${data[myKey]}'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cnacel',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        users
                            .doc(credential.uid)
                            .update({myKey: dialogUserController.text});
                        dialogUserController.clear();
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Edit',
                        style: TextStyle(fontSize: 20, color: btnGreen),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "User Name: ${data['username']} ",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showingDilaog(data, "username");
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          users
                              .doc(credential.uid)
                              .update({"username": FieldValue.delete()});
                          setState(() {});
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Email: ${data['email']}",
                      style: const TextStyle(fontSize: 18)),
                  IconButton(
                    onPressed: () {
                      showingDilaog(data, 'email');
                    },
                    icon: const Icon(Icons.edit),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Age: ${data['age']} ",
                      style: const TextStyle(fontSize: 18)),
                  IconButton(
                    onPressed: () {
                      showingDilaog(data, 'age');
                    },
                    icon: const Icon(Icons.edit),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Title: ${data['title']} ",
                      style: const TextStyle(fontSize: 18)),
                  IconButton(
                    onPressed: () {
                      showingDilaog(data, 'title');
                    },
                    icon: const Icon(Icons.edit),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Password: ${data['password']} ",
                      style: const TextStyle(fontSize: 18)),
                  IconButton(
                    onPressed: () {
                      showingDilaog(data, 'password');
                    },
                    icon: const Icon(Icons.edit),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    users.doc(credential.uid).delete();
                    setState(() {});
                  },
                  child: const Text(
                    'Delete Data',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          );
        }

        return const Text("loading");
      },
    );
  }
}
