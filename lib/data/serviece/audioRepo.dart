import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';

import '../models/quran_data.dart';

class AudioRepo {
  double sliderValue = 0;
  Duration sliderValueOnText;
  Duration position = Duration(seconds: 0);
  bool isOn = false;
  final AssetsAudioPlayer player;
  Data quranData;
  AudioRepo(this.player);

  playAudio(List<Data> data, int index) async {
    quranData = data[index];
    try {
      List<Audio> audio = data
          .map((e) => Audio.network(
                e.link,
                metas: Metas(
                  title: '   ' + e.sora + '  ',
                  artist: '   ' + e.readerName + '  ',
                  // album: "CountryAlbum",
                  image: MetasImage.asset(
                      "images/musical-note.png"), //can be MetasImage.network
                ), //so you can handle what's on notification
              ))
          .toList();

      await player.open(
        Playlist(audios: audio),
        autoStart: false,
        loopMode: LoopMode.playlist,
        showNotification: true,
        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
      ); // time to play
      await player.playlistPlayAtIndex(index);
      player.playlistAudioFinished.listen((event) {
        sliderValueOnText = null;
        sliderValue = 0;
      });
      player.current.listen((event) {
        quranData = data[event.index];
        sliderValueOnText = player.current.value.audio.duration;
        sliderValue = sliderValueOnText.inSeconds.toDouble();
      });

      player.isPlaying.listen((event) {
        print(event);
        isOn = event;
      });

      sliderValueOnText = player.current.value.audio.duration; //to get duration
      sliderValue = sliderValueOnText.inSeconds.toDouble();
    } on HttpException catch (error) {
      print(error);
      throw error;
    }
  }

  pauseAudio() async {
    try {
      await player.pause();
      position = player.currentPosition.value;
      print(position);
    } catch (error) {
      print(error);
    }
  }

  onResume() async {
    try {
      await player.play();
    } catch (error) {
      print(error);
    }
  }

  onSeekToAnewPosition(double value) {
    player.seek(
      Duration(
        seconds: value.toInt(),
      ),
    );
    position = Duration(
      seconds: value.toInt(),
    );
    // sliderValue1 = Duration(
    //   seconds: value.toInt(),
    // );
    // sliderValue = value;
  }
  //
  // clear() {
  //   quranData = null;
  // }

  Future<void> nextAudio() async {
    await player.next();
  }

  Future<void> previousSura() async {
    await player.previous();
  }
}
