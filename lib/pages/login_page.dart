import 'package:chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/constens.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/helper/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  static const String id = "LoginPage";
  const LoginPage({super.key});
  static bool isLoading = false;
  static String? email;
  static String? password;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMassages();
          Navigator.pushReplacementNamed(
            context,
            ChatPage.id,
            arguments: email,
          );
          isLoading = false;
          showSnackBar(context, state.successMassage);
        } else if (state is LoginFailure) {
          isLoading = false;
          showSnackBar(context, state.errMassage);
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
                              BlocProvider.of<AuthBloc>(context).add(
                                LoginEvent(
                                  email: email!,
                                  password: password!,
                                ),
                              );
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
      ),
    );
  }
}
