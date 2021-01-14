part of 'listen_bloc.dart';

abstract class ListenState extends Equatable {
  const ListenState();
}

class ListenInitial extends ListenState {
  const ListenInitial() : super();

  @override
  List<Object> get props => [];
}

class ListenLoading extends ListenState {
  @override
  List<Object> get props => [];

  const ListenLoading() : super();
}

class ListenError extends ListenState {
  @override
  List<Object> get props => [];

  const ListenError() : super();
}

class ListenLoaded extends ListenState {
  final double sliderValue;

  final Duration sliderValue1;

  final Duration position;
  final bool isOn;
  final bool isFav;
  final Data data;

  @override
  List<Object> get props =>
      [sliderValue1, sliderValue, isOn, position, data, isFav];

  const ListenLoaded(
      {this.data,
      this.sliderValue,
      this.sliderValue1,
      this.position,
      this.isOn,
      this.isFav})
      : super();
}

class ErrorInListen extends ListenState {
  const ErrorInListen();

  @override
  List<Object> get props => [];
}
