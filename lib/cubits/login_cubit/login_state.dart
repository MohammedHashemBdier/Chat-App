part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String successMassage;
  LoginSuccess({
    required this.successMassage,
  });
}

final class LoginFailure extends LoginState {
  final String errMassage;
  LoginFailure({
    required this.errMassage,
  });
}
