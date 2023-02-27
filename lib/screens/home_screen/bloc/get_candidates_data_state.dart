part of 'get_candidates_data_bloc.dart';

@immutable
abstract class GetCandidatesDataState {}

class GetCandidatesDataInitial extends GetCandidatesDataState {}

class GetCandidatesDataSuccess extends GetCandidatesDataState {
  final ListCandidates data;

  GetCandidatesDataSuccess({required this.data});
}

class GetCandidatesDataError extends GetCandidatesDataState {}

class SendDataSuccesState extends GetCandidatesDataState {}
