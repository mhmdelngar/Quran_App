import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quran_listienning/data/models/ayah.dart';
import 'package:quran_listienning/data/models/azkar.dart';
import 'package:quran_listienning/data/models/sheikh.dart';
import 'package:quran_listienning/data/repo.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final DataRepo dataRepo;
  MainScreenBloc(this.dataRepo) : super(MainScreenInitial());

  @override
  Stream<MainScreenState> mapEventToState(
    MainScreenEvent event,
  ) async* {
    if (event is ChangeToAzkar) {
      yield MainScreenLoading();
      try {
        final azkar = await dataRepo.getAzkar();

        yield MainScreenAzkar(azkar);
      } catch (e) {
        yield MainScreenError();
      }
    }
    if (event is ChangeToQuran) {
      List<Sheikh> items = dataRepo.items;
      List<Ayah> ayaItems = dataRepo.ayaItems;
      yield MainScreenQuran(items, ayaItems);
    }
    if (event is NavigateTo) {
      yield NavigateToGetData(event.id);
      List<Sheikh> items = dataRepo.items;
      List<Ayah> ayaItems = dataRepo.ayaItems;
      yield MainScreenQuran(
          items, ayaItems); //to return the same state after navigate
    }
  }
}
