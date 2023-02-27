import 'package:bloc/bloc.dart';
import 'package:firebase_app/services/firebase_auth_service.dart';
import 'package:meta/meta.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBlocBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBlocBloc({required this.repo}) : super(LoginBlocInitial()) {
    on<SendLoginDataEvent>((event, emit) async {
      try {
        await repo.login(email: event.email, password: event.password);

        emit(LoginBlocSucces());
      } catch (e) {
        emit(
          LoginBlocError(
            errorText: e.toString(),
          ),
        );
      }
    });
    on<ResetPasswordEvent>((event, emit) async {
      try {
        await repo.ressetPassword(email: event.email);
        emit(LoginBlocSuccesSentEmail());
      } catch (e) {
        emit(LoginBlocError(errorText: e.toString()));
      }
    });
  }
  final FireBaseAuthService repo;
}
