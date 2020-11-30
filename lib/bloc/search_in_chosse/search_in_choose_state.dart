part of 'search_in_choose_bloc.dart';

abstract class SearchInChooseState extends Equatable {
  const SearchInChooseState();
}

class SearchInChooseInitial extends SearchInChooseState {
  @override
  List<Object> get props => [];
}

class Searching extends SearchInChooseState {
  final List<Data> newValue;

  Searching(this.newValue);
  @override
  List<Object> get props => [newValue];
}

class NoSearch extends SearchInChooseState {
  @override
  List<Object> get props => [];
}
