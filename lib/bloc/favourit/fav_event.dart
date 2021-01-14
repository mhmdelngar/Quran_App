part of 'fav_bloc.dart';

abstract class FavEvent extends Equatable {
  const FavEvent();
}

class GetFav extends FavEvent {
  @override
  List<Object> get props => [];
}

class Triger extends FavEvent {
  @override
  List<Object> get props => [];
}

class Dispose extends FavEvent {
  @override
  List<Object> get props => [];
}
