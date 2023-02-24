import 'package:bloc/bloc.dart';
import 'package:firebase_app/services/firebase_auth_service.dart';
import 'package:meta/meta.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc({required this.repo}) : super(RegistrationInitial()) {
    on<SendDataEvent>(
      (event, emit) async {
        try {
          await repo.registation(email: event.email, password: event.password);
          emit(RegistrationSucces());
        } catch (e) {
          emit(RegistrationError(errorText: e.toString()));
        }
      },
    );
  }

  final FireBaseAuthService repo;
}
