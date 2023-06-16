import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/helper/show_snack_bar.dart';
import 'package:flower_app/pages/sign_up.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../shared/colors.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  bool isLoading = false;
  bool isNotVisible = true;
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: const Text(
          'Sign In',
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                //email
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  decoration: decorationTextFeild.copyWith(
                    suffixIcon: const Icon(
                      Icons.email,
                      color: Color.fromARGB(255, 124, 124, 124),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //password
                TextField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: isNotVisible,
                  decoration: decorationTextFeild.copyWith(
                    hintText: 'Enter Your password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isNotVisible = !isNotVisible;
                          });
                        },
                        color: const Color.fromARGB(255, 124, 124, 124),
                        icon: isNotVisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // sign up btn
                ElevatedButton(
                  onPressed: () async {
                    try {
                      setState(() {
                        isLoading = true;
                      });
                      await loginUser();
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showSnackBar(context, 'No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        showSnackBar(
                            context, 'Wrong password provided for that user.');
                      }
                    } catch (e) {
                      showSnackBar(context, e.toString());
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(btnGreen),
                    padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Sign In',
                          style: TextStyle(fontSize: 20),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'don\'t have an account?',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUP(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 16,
                          color: btnGreen,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }
}
