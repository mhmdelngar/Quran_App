part of 'main_screen_bloc.dart';

abstract class MainScreenEvent extends Equatable {
  const MainScreenEvent();
}

class ChangeToAzkar extends MainScreenEvent {
  const ChangeToAzkar();
  List<Object> get props => throw UnimplementedError();
}

class ChangeToQuran extends MainScreenEvent {
  const ChangeToQuran();
  List<Object> get props => throw UnimplementedError();
}

class NavigteTo extends MainScreenEvent {
  final int id;
  const NavigteTo(this.id);
  List<Object> get props => throw UnimplementedError();
}
