import 'package:chat_app/constens.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubits/register_cubit/register_cubit.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/helper/custom_text_form_field.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static const String id = "RegisterPage";
  static String? email;
  static String? password;
  static bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          BlocProvider.of<ChatCubit>(context).getMassages();
          showSnackBar(context, state.successMassage);
          Navigator.pushReplacementNamed(
            context,
            ChatPage.id,
            arguments: email,
          );
          isLoading = false;
        } else if (state is RegisterFailure) {
          isLoading = false;
          showSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) => ModalProgressHUD(
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
                              BlocProvider.of<RegisterCubit>(context)
                                  .registrationMethod(
                                email: email!,
                                password: password!,
                              );
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
      ),
    );
  }
}
