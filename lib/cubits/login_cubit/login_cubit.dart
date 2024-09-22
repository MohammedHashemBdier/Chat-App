import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> loginMethod(
    String email,
    String password,
  ) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(
        LoginSuccess(
          successMassage: "Logged in as ${user.user!.email}",
        ),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase Auth Exception Code: ${e.code}");
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {
        emit(
          LoginFailure(errMassage: "No user found for that email."),
        );
      } else if (e.code == 'invalid-credential') {
        emit(
          LoginFailure(errMassage: "Wrong password provided for that user."),
        );
      } else {
        emit(
          LoginFailure(errMassage: "Authentication Error: ${e.message}"),
        );
      }
    } on Exception catch (e) {
      emit(
        LoginFailure(errMassage: "An unexpected error occurred: $e"),
      );
    }
  }
}
