part of 'main_screen_bloc.dart';

abstract class MainScreenState extends Equatable {
  const MainScreenState();
}

class MainScreenInitial extends MainScreenState {
  const MainScreenInitial();
  @override
  List<Object> get props => [];
}

class MainScreenError extends MainScreenState {
  const MainScreenError();
  @override
  List<Object> get props => [];
}

class MainScreenLoading extends MainScreenState {
  const MainScreenLoading();
  @override
  List<Object> get props => [];
}

class NavigateToGetData extends MainScreenState {
  final id;
  const NavigateToGetData(this.id);
  @override
  List<Object> get props => [id];
}

class MainScreenQuran extends MainScreenState {
  final List<Sheikh> items;
  final List<Ayah> ayaItems;
  MainScreenQuran(this.items, this.ayaItems);
  @override
  List<Object> get props => [items, ayaItems];
}

class MainScreenAzkar extends MainScreenState {
  final AzkarData azkarData;

  MainScreenAzkar(this.azkarData);
  @override
  List<Object> get props => [azkarData];
}
