import 'package:chat_app/constens.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/helper/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String id = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

String? email;
String? password;

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Spacer(flex: 1),
                      Image.asset(
                        kLogo,
                        scale: 8,
                      ),
                      const Text(
                        "Chat App",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: "Pacifico",
                        ),
                      ),
                      const Spacer(flex: 2),
                      const Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      CustomFormTextField(
                        obscureText: false,
                        hintText: "Email",
                        onChanged: (data) {
                          email = data;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomFormTextField(
                        obscureText: true,
                        hintText: "Password",
                        onChanged: (data) {
                          password = data;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });

                            try {
                              await loginMethod();
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                        text: "LOGIN",
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RegisterPage.id);
                            },
                            child: const Text(
                              "  Register",
                              style: TextStyle(
                                color: Color(0xffC3E7E4),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(flex: 3),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginMethod() async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      Navigator.pushReplacementNamed(context, ChatPage.id, arguments: email);
      showSnackBar(context, "Logged in as ${user.user!.email}");
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Exception Code: ${e.code}"); // طباعة رمز الخطأ

      if (e.code == 'user-not-found') {
        showSnackBar(context, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, "Wrong password provided for that user.");
      } else if (e.code == 'invalid-credential') {
        showSnackBar(context,
            "Invalid credentials. Please check your email and password.");
      } else {
        showSnackBar(context, "Authentication Error: ${e.message}");
      }
    } catch (e) {
      showSnackBar(context, "An unexpected error occurred: $e");
    }
  }
}
