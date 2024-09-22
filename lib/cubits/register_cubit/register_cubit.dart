import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> registrationMethod({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(
        RegisterSuccess(
            successMassage: "${user.user!.email} was created successfully"),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase Auth Exception Code: ${e.code}");
      if (e.code == 'weak-password') {
        emit(
          RegisterFailure(errMessage: "The password provided is too weak."),
        );
      } else if (e.code == 'email-already-in-use') {
        emit(
          RegisterFailure(
              errMessage: "An account already exists for this email."),
        );
      } else if (e.code == 'invalid-email') {
        emit(
          RegisterFailure(errMessage: "The email address is not valid."),
        );
      } else if (e.code == 'operation-not-allowed') {
        emit(
          RegisterFailure(
              errMessage: "Email/password accounts are not enabled."),
        );
      } else {
        emit(
          RegisterFailure(errMessage: "Registration Error: ${e.message}"),
        );
      }
    } catch (e) {
      emit(
        RegisterFailure(errMessage: "An unexpected error occurred: $e"),
      );
    }
  }
}
