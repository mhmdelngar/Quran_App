part of 'listen_bloc.dart';

abstract class ListenEvent extends Equatable {
  const ListenEvent();
}

class PlayAudio extends ListenEvent {
  final List<Data> data;
  final int index;

  PlayAudio(this.data, this.index);

  @override
  List<Object> get props => [this.index, this.data];
}

class Triger extends ListenEvent {
  final Duration position;

  Triger(
    this.position,
  );

  @override
  List<Object> get props => [position];
}

class PauseAudio extends ListenEvent {
  PauseAudio();

  @override
  List<Object> get props => throw UnimplementedError();
}

class ResumeAudio extends ListenEvent {
  ResumeAudio();

  @override
  List<Object> get props => throw UnimplementedError();
}

class NextSura extends ListenEvent {
  NextSura();

  @override
  List<Object> get props => throw UnimplementedError();
}

class PreviousSura extends ListenEvent {
  PreviousSura();

  @override
  List<Object> get props => throw UnimplementedError();
}

class Error extends ListenEvent {
  Error();

  @override
  List<Object> get props => throw UnimplementedError();
}

class ChangePosition extends ListenEvent {
  final double newValue;

  ChangePosition({this.newValue});

  @override
  List<Object> get props => [newValue];
}

class AddToDataBase extends ListenEvent {
  @override
  List<Object> get props => [];
}

class RemoveFromDataBase extends ListenEvent {
  @override
  List<Object> get props => [];
}

class StopListener extends ListenEvent {
  StopListener();

  @override
  List<Object> get props => throw UnimplementedError();
}
