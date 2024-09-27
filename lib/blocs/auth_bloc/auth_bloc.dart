import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is LoginEvent) {
          emit(LoginLoading());
          try {
            UserCredential user =
                await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email,
              password: event.password,
            );
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
                LoginFailure(
                    errMassage: "Wrong password provided for that user."),
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
        } else if (event is RegisterEvent) {
          emit(RegisterLoading());
          try {
            UserCredential user =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: event.email,
              password: event.password,
            );

            emit(
              RegisterSuccess(
                  successMassage:
                      "${user.user!.email} was created successfully"),
            );
          } on FirebaseAuthException catch (e) {
            debugPrint("Firebase Auth Exception Code: ${e.code}");
            if (e.code == 'weak-password') {
              emit(
                RegisterFailure(
                    errMessage: "The password provided is too weak."),
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
      },
    );
  }
}
