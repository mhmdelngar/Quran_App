import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';

import '../models/quran_data.dart';

class AudioRepo {
  final AssetsAudioPlayer player;
  AudioRepo(this.player);

  double _sliderValue = 0;
  Duration _sliderValueOnText = Duration.zero;
  Duration _position = Duration(seconds: 0);
  bool _isOn = false;
  Data _quranData;
  StreamSubscription stream;
  StreamSubscription stream1;
  StreamSubscription stream2;

  playAudio(List<Data> data, int index) async {
    //passing the whole list for the package
    var mood = LoopMode.playlist;
    if (data.length == 1) {
      mood = LoopMode.none;
    }
    _quranData = data[index];
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
        loopMode: mood,
        showNotification: true,
        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
      ); // time to play
      await player.playlistPlayAtIndex(index);
      listener(
          data); //setting my listener in this repo (never tr to forget them unclosed)
    } on HttpException catch (error) {
      print(error);
      throw error;
    } catch (e) {
      print(e); //overall the package handle the error
    }
  }

  pauseAudio() async {
    try {
      await player.pause();
      _position = player.currentPosition.value;
      print(position);
    } catch (error) {
      print(error);
    }
  }

  listener(List<Data> data) {
    stream = player.playlistAudioFinished.listen((event) {
      _sliderValueOnText = null;
      _sliderValue = 0;
    }); //this to make buffer before load the next sura
    stream1 = player.current.listen((event) {
      _quranData = data[event.index];
      _sliderValueOnText = player.current.value.audio.duration;
      _sliderValue = sliderValueOnText.inSeconds.toDouble();
    });

    stream2 = player.isPlaying.listen((event) {
      _isOn = event;
    });
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
    _position = Duration(
      seconds: value.toInt(),
    );
  }

  clearListener() async {
    await stream.cancel();
    await stream1.cancel();
    await stream2.cancel();
  }

  Future<void> nextAudio() async {
    await player.next();
  }

  Future<void> previousSura() async {
    await player.previous();
  }

  Duration get position {
    return _position;
  }

  Duration get sliderValueOnText {
    return _sliderValueOnText;
  }

  bool get isOn {
    return _isOn;
  }

  double get sliderValue {
    return _sliderValue;
  }

  Data get quranData {
    return _quranData;
  }
}
