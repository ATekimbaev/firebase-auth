part of 'login_bloc_bloc.dart';

@immutable
abstract class LoginBlocEvent {}

class SendLoginDataEvent extends LoginBlocEvent {
  final String email;
  final String password;
  SendLoginDataEvent({required this.email, required this.password});
}

class ResetPasswordEvent extends LoginBlocEvent {
  final String email;
  ResetPasswordEvent({required this.email});
}
