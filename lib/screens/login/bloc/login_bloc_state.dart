part of 'login_bloc_bloc.dart';

@immutable
abstract class LoginBlocState {}

class LoginBlocInitial extends LoginBlocState {}

class LoginBlocError extends LoginBlocState {
  final String errorText;
  LoginBlocError({required this.errorText});
}

class LoginBlocSucces extends LoginBlocState {}

class LoginBlocSuccesSentEmail extends LoginBlocState {}
