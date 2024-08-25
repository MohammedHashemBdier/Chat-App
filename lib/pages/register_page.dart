import 'package:chat_app/constens.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/helper/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static const String id = "RegisterPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;
  String? password;
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
                          "REGISTER",
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
                              await registrationMethod();
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                        text: "REGISTER",
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Have an account?",
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "  Login",
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

  Future<void> registrationMethod() async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      Navigator.pushReplacementNamed(context, ChatPage.id, arguments: email);
      showSnackBar(context, "${user.user!.email} was created successfully");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          showSnackBar(context, "The password provided is too weak.");
          break;
        case 'email-already-in-use':
          showSnackBar(context, "An account already exists for this email.");
          break;
        case 'invalid-email':
          showSnackBar(context, "The email address is not valid.");
          break;
        case 'operation-not-allowed':
          showSnackBar(context, "Email/password accounts are not enabled.");
          break;
        default:
          showSnackBar(context, "Registration Error: ${e.message}");
          break;
      }
    } catch (e) {
      showSnackBar(context, "An unexpected error occurred: $e");
    }
  }
}
