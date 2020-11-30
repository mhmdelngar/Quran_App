part of 'choose_sura_bloc.dart';

abstract class ChooseSuraEvent extends Equatable {
  const ChooseSuraEvent();
}

class GetAllQuranEvent extends ChooseSuraEvent {
  final int readerId;

  GetAllQuranEvent({@required this.readerId}) : assert(readerId != null);
  @override
  List<Object> get props => [readerId];
}
