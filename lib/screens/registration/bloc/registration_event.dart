part of 'registration_bloc.dart';

@immutable
abstract class RegistrationEvent {}

class SendDataEvent extends RegistrationEvent {
  final String email;
  final String password;
  SendDataEvent({required this.email, required this.password});
}
