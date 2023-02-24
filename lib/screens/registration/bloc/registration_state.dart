part of 'registration_bloc.dart';

@immutable
abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationError extends RegistrationState {
  final String errorText;
  RegistrationError({required this.errorText});
}

class RegistrationSucces extends RegistrationState {}
