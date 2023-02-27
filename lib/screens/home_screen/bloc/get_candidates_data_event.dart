part of 'get_candidates_data_bloc.dart';

@immutable
abstract class GetCandidatesDataEvent {}

class GetDataEvent extends GetCandidatesDataEvent {}

class SendDataEvent extends GetCandidatesDataEvent {
  final ListCandidates data;
  SendDataEvent({required this.data});
}
