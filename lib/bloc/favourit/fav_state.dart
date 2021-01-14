part of 'fav_bloc.dart';

abstract class FavState extends Equatable {
  const FavState();
}

class FavInitial extends FavState {
  @override
  List<Object> get props => [];
}

class FavLoading extends FavState {
  @override
  List<Object> get props => [];
}

class FavLoaded extends FavState {
  final List<Data> data;

  FavLoaded(this.data);
  @override
  List<Object> get props => [data];
}

class NoFav extends FavState {
  @override
  List<Object> get props => [];
}
