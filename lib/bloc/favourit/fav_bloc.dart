import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:quran_listienning/data/hiveDatabase.dart';
import 'package:quran_listienning/data/models/quran_data.dart';

part 'fav_event.dart';
part 'fav_state.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  FavBloc() : super(FavInitial());

  DataBase dataBase = DataBase();
  StreamSubscription watcher;
  @override
  Stream<FavState> mapEventToState(
    FavEvent event,
  ) async* {
    if (event is GetFav) {
      yield FavLoading();

      List<Data> data = await dataBase.getAllFav();
      watcher = Hive.box<Data>('favorite').watch().listen((event) async {
        add(Triger());
      });
      yield FavLoaded(data);
    }
    if (event is Triger) {
      List<Data> data = await dataBase.getAllFav();

      yield FavLoaded(data);
    }
    if (event is Dispose) {
      await watcher.cancel();
    }
  }
}
