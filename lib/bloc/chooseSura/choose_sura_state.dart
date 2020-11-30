part of 'choose_sura_bloc.dart';

abstract class ChooseSuraState extends Equatable {
  const ChooseSuraState();
}

class ChooseSuraInitial extends ChooseSuraState {
  ChooseSuraInitial() : super();

  @override
  List<Object> get props => [];
}

class ChooseSuraLoading extends ChooseSuraState {
  ChooseSuraLoading() : super();

  @override
  List<Object> get props => [];
}

class ChooseSuraError extends ChooseSuraState {
  ChooseSuraError() : super();

  @override
  List<Object> get props => [];
}

class ChooseSuraLoaded extends ChooseSuraState {
  final Quran quran;
  ChooseSuraLoaded({@required this.quran, readerId})
      : assert(quran != null),
        super();

  @override
  List<Object> get props => [quran];
}
