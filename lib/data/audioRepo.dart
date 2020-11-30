import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';

import 'models/quran_data.dart';

class AudioRepo {
  double sliderValue = 0;
  Duration sliderValue1;
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
                  title: e.sora,
                  artist: e.readerName,
                  // album: "CountryAlbum",
                  image: MetasImage.asset(
                      "images/musical-note.png"), //can be MetasImage.network
                ), //so you can handle what's on notification
              ))
          .toList();

      await player.open(Playlist(audios: audio),
          autoStart: false,
          loopMode: LoopMode.playlist,
          showNotification: true,
          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
          notificationSettings: NotificationSettings()); // time to play
      await player.playlistPlayAtIndex(index);
      player.playlistAudioFinished.listen((event) {
        sliderValue1 = null;
        sliderValue = 0;
      });
      player.current.listen((event) {
        quranData = data[event.index];
        sliderValue1 = player.current.value.audio.duration;
        sliderValue = sliderValue1.inSeconds.toDouble();
      });

      player.isPlaying.listen((event) {
        isOn = event;
      });
      sliderValue1 = player.current.value.audio.duration; //to get duration
      sliderValue = sliderValue1.inSeconds.toDouble();
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
  }

  clear() {
    quranData = null;
  }

  Future<void> nextAudio() async {
    await player.next();
  }

  Future<void> previousSura() async {
    await player.previous();
  }
}
