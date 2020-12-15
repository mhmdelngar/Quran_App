import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:quran_listienning/data/models/quran_data.dart';
import 'package:quran_listienning/data/repo.dart';

part 'choose_sura_event.dart';
part 'choose_sura_state.dart';

class ChooseSuraBloc extends Bloc<ChooseSuraEvent, ChooseSuraState> {
  final DataRepo dataRepo;
  ChooseSuraBloc({@required this.dataRepo})
      : assert(dataRepo != null),
        super(ChooseSuraInitial());

  @override
  Stream<ChooseSuraState> mapEventToState(
    ChooseSuraEvent event,
  ) async* {
    if (event is GetAllQuranEvent) {
      yield ChooseSuraLoading();
      try {
        Quran quran = await dataRepo.getAllQuranData(event.readerId);
        yield ChooseSuraLoaded(
          quran: quran,
        );
      } catch (error) {
        print(error);
        yield ChooseSuraError();
      }
    }
  }
}
