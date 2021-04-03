import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:quran_listienning/bloc/listen/listen_bloc.dart';
import 'package:quran_listienning/data/models/quran_data.dart';
import 'package:quran_listienning/data/repo.dart';
import 'package:quran_listienning/widgets/arrow_card.dart';
import 'package:quran_listienning/widgets/mood_ui.dart';

class ListenUi {
  final ListenBloc _listenBloc;
  final BuildContext context;
  final int id;
  final hieght;
  ListenUi(this._listenBloc, this.context, this.id, this.hieght);

  onSeekToAnewPosition(double value) {
    _listenBloc.add(ChangePosition(newValue: value));
  }

  Widget contentDetail(Data data) {
    return Container(
        margin: EdgeInsets.only(top: 15),
        height: MediaQuery.of(context).size.height * .6 -
            MediaQuery.of(context).padding.top,
        child: Column(
          children: [
            SizedBox(
              height: hieght,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.values[1],
                    color: Colors.lightBlue,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .17,
                    width: MediaQuery.of(context).size.width * .36,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Image.network(
                      id != null
                          ? DataRepo().items[id - 1].imageUrl
                          : 'http://www.hizb.org.uk/wp-content/uploads/2017/08/quran-open-05.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Text(
              data.sora == null ? 'loading' : data.sora,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              data.readerName == null ? 'loading' : data.readerName,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ],
        ));
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    print('working');
    if (!isLiked) {
      _listenBloc.add(AddToDataBase());
    } else {
      _listenBloc.add(RemoveFromDataBase());
    }
    return true;
  }

  Widget controlInSound(
      {double sliderValue,
      Duration sliderValue1,
      Duration position,
      bool isOn,
      bool isFav}) {
    return Expanded(
      child: Stack(
        clipBehavior: Clip.none, children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.Hms().format(
                          DateTime.fromMillisecondsSinceEpoch(
                              position.inMilliseconds,
                              isUtc: true),
                        ),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                          sliderValue1 != null
                              ? DateFormat.Hms()
                                  .format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        sliderValue1.inMilliseconds,
                                        isUtc: true),
                                  )
                                  .toString()
                              : 'buffering',
                          style: TextStyle(
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ),
                SliderTheme(
                  data: SliderThemeData(
                      activeTrackColor: Colors.black,
                      thumbColor: Colors.red,
                      thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 8,
                          elevation: 4,
                          pressedElevation: 15),
                      overlayColor: Colors.white12,
                      inactiveTrackColor: Colors.grey),
                  child: Slider(
                    onChanged: (value) {
                      onSeekToAnewPosition(value);
                    },
                    min: 0,
                    max: sliderValue ?? 0,
                    value: position.inSeconds.toDouble() ?? 0,
                    // value: position.inSeconds.toDouble(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.loop),
                    ArrowCard(
                      onPressed: previousSura,
                      icon: Icons.arrow_left,
                    ),
                    CircleAvatar(
                        radius: 37,
                        child: IconButton(
                            icon: Icon(isOn ? Icons.pause : Icons.play_arrow,
                                color: Colors.white),
                            onPressed: () {
                              isOn
                                  ? _listenBloc.add(PauseAudio())
                                  : _listenBloc.add(ResumeAudio());
                            }),
                        backgroundColor: Color(0xFF393b4a)),
                    ArrowCard(
                      icon: Icons.arrow_right,
                      onPressed: nextSura,
                    ),
                    Icon(Icons.autorenew),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: -30,
            child: MoodUi(
              widget: LikeButton(
                isLiked: isFav,
                onTap: (issliked) {
                  return onLikeButtonTapped(issliked);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  nextSura() {
    _listenBloc.add(NextSura());
  }

  previousSura() {
    _listenBloc.add(PreviousSura());
  }

  Widget loaded(
      {double sliderValue,
      Duration sliderValue1,
      Duration position,
      bool isOn,
      Data data,
      bool isFav,
      BuildContext context}) {
    return Column(
      children: [
        // appBar(context),
        contentDetail(data),
        controlInSound(
            isOn: isOn,
            position: position,
            sliderValue1: sliderValue1,
            sliderValue: sliderValue,
            isFav: isFav),
      ],
    );
  }
}
