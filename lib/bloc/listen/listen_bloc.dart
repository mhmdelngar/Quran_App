import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quran_listienning/data/models/quran_data.dart';
import 'package:quran_listienning/data/serviece/audioRepo.dart';

part 'listen_event.dart';
part 'listen_state.dart';

class ListenBloc extends Bloc<ListenEvent, ListenState> {
  final AudioRepo audioRepo;

  // AudioPlayer player = AudioPlayer();

  ListenBloc(this.audioRepo) : super(ListenInitial());

  @override
  Stream<ListenState> mapEventToState(
    ListenEvent event,
  ) async* {
    if (event is PlayAudio) {
      Duration s;
      yield ListenLoaded(
          isOn: audioRepo.isOn,
          position: Duration.zero,
          sliderValue1: null,
          sliderValue: 0,
          data: event.data[event.index]); // null value to Show buffering

      await audioRepo.playAudio(event.data, event.index);

      audioRepo.player.currentPosition.listen((p) {
        s = p;
        add(Triger(p));
      });
      //to make time moving
      audioRepo.player.isPlaying.listen((event) {
        if (event == false) {
          add(Triger(s));
        }
      });
    }

    if (event is Triger) {
      yield ListenLoaded(
          isOn: audioRepo.isOn,
          position: event.d,
          sliderValue1: audioRepo.sliderValueOnText,
          sliderValue: audioRepo.sliderValue,
          data: audioRepo.quranData);
    }
    if (event is PauseAudio) {
      await audioRepo.pauseAudio();
      print('is ${audioRepo.isOn}');
      yield ListenLoaded(
          isOn: audioRepo.isOn,
          position: audioRepo.position,
          sliderValue1: audioRepo.sliderValueOnText,
          sliderValue: audioRepo.sliderValue,
          data: audioRepo.quranData);
    }
    if (event is NextSura) {
      yield ListenLoaded(
          isOn: audioRepo.isOn,
          position: Duration.zero,
          sliderValue1: null,
          sliderValue: 0,
          data: audioRepo.quranData);
      await audioRepo.nextAudio();
    }
    if (event is PreviousSura) {
      yield ListenLoaded(
          isOn: audioRepo.isOn,
          position: Duration.zero,
          sliderValue1: null,
          sliderValue: 0,
          data: audioRepo.quranData);
      await audioRepo.previousSura();
    }
    if (event is ChangePosition) {
      await audioRepo.onSeekToAnewPosition(event.newValue);
    }
    if (event is ResumeAudio) {
      await audioRepo.onResume();
    }
    if (event is Error) {
      yield ErrorInListen();
    }
  }
}
