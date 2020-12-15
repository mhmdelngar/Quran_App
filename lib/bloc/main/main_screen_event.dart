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

class NavigateTo extends MainScreenEvent {
  final int id;
  const NavigateTo(this.id);
  List<Object> get props => [id];
}
