import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../shared/colors.dart';
import 'sign_in.dart';

class SignUP extends StatefulWidget {
  const SignUP({super.key});

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  bool isLoading = false;
  bool isNotVisible = true;
  var formKey = GlobalKey<FormState>();

  bool isPassword8Character = false;
  onPasswordChange(String password) {
    isPassword8Character = false;
    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        isPassword8Character = true;
      }
    });
  }

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
          'Sign Up',
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  // username
                  TextField(
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: decorationTextFeild.copyWith(
                      hintText: 'Enter Username: ',
                      suffixIcon: const Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 124, 124, 124),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Email
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
                    height: 10,
                  ),
                  // password
                  TextFormField(
                    validator: (password) {
                      return password != null && password.length < 8
                          ? "At Least 8 characters"
                          : null;
                    },
                    onChanged: (value) {
                      onPasswordChange(value);
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: isNotVisible ? true : false,
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
                                : const Icon(Icons.visibility_off))),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isPassword8Character
                                ? Colors.green
                                : Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                            )),
                        child: const Icon(Icons.check,
                            color: Colors.white, size: 16),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('At Least 8 Characters'),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                            )),
                        child: const Icon(Icons.check,
                            color: Colors.white, size: 16),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('At Least 1 Number'),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                            )),
                        child: const Icon(Icons.check,
                            color: Colors.white, size: 16),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('Has Upper Case'),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                            )),
                        child: const Icon(Icons.check,
                            color: Colors.white, size: 16),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('Has Lower Case'),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                            )),
                        child: const Icon(Icons.check,
                            color: Colors.white, size: 16),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('Has Special Characters'),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // SignUp Button
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          isLoading = true;
                          setState(() {});
                          await registerUser();
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(
                                context, 'The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(context,
                                'The account already exists for that email.');
                          } else {
                            showSnackBar(
                                context, "Error. Please try again later");
                          }
                        } catch (e) {
                          showSnackBar(context, e.toString());
                        }
                        setState(() {
                          isLoading = false;
                        });
                      } else {
                        showSnackBar(context, "Error.");
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(btnGreen),
                      padding:
                          const MaterialStatePropertyAll(EdgeInsets.all(12)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 20),
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'do you have an account?',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignIn(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign In',
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
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(label: 'Close', onPressed: () {}),
      ),
    );
  }

  Future<void> registerUser() async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  }
}