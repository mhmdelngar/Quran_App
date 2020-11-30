import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:quran_listienning/data/models/quran_data.dart';

part 'search_in_choose_event.dart';
part 'search_in_choose_state.dart';

class SearchInChooseBloc
    extends Bloc<SearchInChooseEvent, SearchInChooseState> {
  SearchInChooseBloc() : super(SearchInChooseInitial());

  @override
  Stream<SearchInChooseState> mapEventToState(
    SearchInChooseEvent event,
  ) async* {
    if (event is StartSearching) {
      event.controller.addListener(() {
        if (event.controller.text.isEmpty) {
          add(ThereIsNoSearch());
        } else {
          List<Data> _searchListItems = List<Data>();
          for (int i = 0; i < event.quran.data.length; i++) {
            var item = event.quran.data[i];

            if (item.sora.contains(event.controller.text)) {
              _searchListItems.add(item);
            }
          }
          add(Search(_searchListItems));
        }
      });
    }
    if (event is ThereIsNoSearch) {
      yield NoSearch();
    }
    if (event is Search) {
      yield Searching(event.newValue);
    }
  }
}
