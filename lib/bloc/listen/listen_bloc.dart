import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quran_listienning/data/hiveDatabase.dart';
import 'package:quran_listienning/data/models/quran_data.dart';
import 'package:quran_listienning/data/serviece/audioRepo.dart';

part 'listen_event.dart';
part 'listen_state.dart';

class ListenBloc extends Bloc<ListenEvent, ListenState> {
  final AudioRepo audioRepo;
  DataBase dataBase = DataBase();
  bool isFav;
  Duration currentPosition;
  StreamSubscription<Duration> stream;
  StreamSubscription<bool> stream1;
  StreamSubscription<Playing> stream2;

  ListenBloc(this.audioRepo) : super(ListenInitial());

  @override
  Stream<ListenState> mapEventToState(
    ListenEvent event,
  ) async* {
    if (event is PlayAudio) {
      if (event.data[event.index] == audioRepo.quranData) {
        audioRepo.listener(event.data);
      } //so it can complete from the same point when enter the same soura until i can figure out how to do it with bloc
      else {
        yield ListenLoaded(
            isOn: audioRepo.isOn,
            position: Duration.zero,
            sliderValue1: null,
            sliderValue: 0,
            data: event.data[event.index],
            isFav: false); // null value to Show buffering
        isFav = await dataBase.checkFav(event.data[event.index]);
        await audioRepo.playAudio(event.data, event.index);
      }
      stream = audioRepo.player.currentPosition.listen((position) {
        currentPosition = position;
        print(position);
        print(audioRepo.sliderValue);
        add(Triger(position));
      }); //to make time moving
      stream1 = audioRepo.player.isPlaying.listen((event) {
        if (event == false) {
          add(Triger(currentPosition));
        }
      });
      stream2 = audioRepo.player.current.listen((event) async {
        isFav = await dataBase.checkFav(audioRepo.quranData);
      });
    }

    if (event is Triger) {
      yield ListenLoaded(
        isOn: audioRepo.isOn,
        position: event.position,
        sliderValue1: audioRepo.sliderValueOnText,
        sliderValue: audioRepo.sliderValue,
        data: audioRepo.quranData,
        isFav: isFav,
      );
    }
    if (event is AddToDataBase) {
      isFav = true;
      Data data = audioRepo.quranData;
      dataBase.addFav(data);
      if (!audioRepo.player.isPlaying.value) {
        add(Triger(currentPosition));
      }
    }
    if (event is PauseAudio) {
      await audioRepo.pauseAudio();
    } //pause Audio
    if (event is NextSura) {
      yield ListenLoaded(
        isOn: audioRepo.isOn,
        position: Duration.zero,
        sliderValue1: null,
        sliderValue: 0,
        data: audioRepo.quranData,
        isFav: isFav,
      );
      await audioRepo.nextAudio();
    }
    if (event is PreviousSura) {
      yield ListenLoaded(
          isOn: audioRepo.isOn,
          position: Duration.zero,
          sliderValue1: null,
          sliderValue: 0,
          data: audioRepo.quranData,
          isFav: isFav);
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

    if (event is RemoveFromDataBase) {
      isFav = false;
      dataBase.removeFavItem(audioRepo.quranData);
      if (!audioRepo.player.isPlaying.value) {
        print('is that right' + isFav.toString());
        add(Triger(currentPosition));
      }
    }
    if (event is StopListener) {
      await audioRepo.clearListener();
      await stream.cancel();
      await stream1.cancel();
      await stream2.cancel();
    }

    // close();
  }

  @override
  close() async {
    await stream.cancel();
    await stream1.cancel();
    await stream2.cancel();

    super.close();
  }
}
