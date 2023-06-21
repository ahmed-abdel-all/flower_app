import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/constants.dart';
import 'package:flower_app/helper/show_snack_bar.dart';
import 'package:flower_app/pages/sign_in.dart';
import 'package:flower_app/shared/colors.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();
  bool isLoading = false;
  var formKey = GlobalKey<FormState>();

  void resetPassword() async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      if (!mounted) return;
      showSnackBar(context, "Done. Please check your email");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignIn(),
          ));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, 'Error:  ${e.code}');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
  
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: const Text(
          'Reset Password',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 33),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter your email to reset your password.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (email) {
                  return email!.contains(RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                      ? null
                      : "Enter valid Email ";
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    resetPassword();
                  } else {
                    showSnackBar(context, "Error.");
                  }
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
                        'Reset Password',
                        style: TextStyle(fontSize: 20),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
