import 'package:bloc/bloc.dart';
import 'package:firebase_app/models/kandidates_model.dart';
import 'package:firebase_app/services/firebase_auth_service.dart';
import 'package:meta/meta.dart';

part 'get_candidates_data_event.dart';
part 'get_candidates_data_state.dart';

class GetCandidatesDataBloc
    extends Bloc<GetCandidatesDataEvent, GetCandidatesDataState> {
  GetCandidatesDataBloc({required this.repo})
      : super(GetCandidatesDataInitial()) {
    on<GetDataEvent>(
      (event, emit) async {
        try {
          final data = await repo.getData();
          emit(GetCandidatesDataSuccess(data: data));
        } catch (e) {
          emit(GetCandidatesDataError());
        }
      },
    );
    on<SendDataEvent>(
      (event, emit) async {
        try {
          await repo.sendData(data: event.data);
          emit(SendDataSuccesState());
        } catch (e) {
          emit(GetCandidatesDataError());
        }
      },
    );
  }

  final FireBaseAuthService repo;
}
