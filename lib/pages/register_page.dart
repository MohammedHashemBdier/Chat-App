import 'package:chat_app/constens.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static const String id = "RegisterPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Image.asset("assets/images/scholar.png"),
            const Text(
              "Chat App",
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontFamily: "Pacifico",
              ),
            ),
            const Spacer(
              flex: 2,
            ),
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
            const SizedBox(
              height: 15,
            ),
            const CustomTextField(
              hintText: "Email",
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomTextField(
              hintText: "Password",
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomButton(
              text: "REGISTER",
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "have an account?",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(
                      context,
                    );
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
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
