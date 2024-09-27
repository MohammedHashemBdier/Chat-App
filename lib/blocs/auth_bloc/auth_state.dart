part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {
  final String successMassage;
  RegisterSuccess({
    required this.successMassage,
  });
}

final class RegisterFailure extends AuthState {
  final String errMessage;
  RegisterFailure({
    required this.errMessage,
  });
}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final String successMassage;
  LoginSuccess({
    required this.successMassage,
  });
}

final class LoginFailure extends AuthState {
  final String errMassage;
  LoginFailure({
    required this.errMassage,
  });
}
