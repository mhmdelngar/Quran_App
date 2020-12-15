part of 'search_in_choose_bloc.dart';

abstract class SearchInChooseEvent extends Equatable {
  const SearchInChooseEvent();
}

class StartSearching extends SearchInChooseEvent {
  final TextEditingController controller;
  final Quran quran;
  StartSearching(this.controller, this.quran);
  @override
  // TODO: implement props
  List<Object> get props => [controller, quran];
}

class ThereIsNoSearch extends SearchInChooseEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class Search extends SearchInChooseEvent {
  final List<Data> newValue;

  Search(this.newValue);

  @override
  // TODO: implement props
  List<Object> get props => [newValue];
}
