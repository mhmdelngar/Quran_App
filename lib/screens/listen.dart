import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quran_listienning/bloc/listen/listen_bloc.dart';
import 'package:quran_listienning/data/models/quran_data.dart';
import 'package:quran_listienning/data/repo.dart';
import 'package:quran_listienning/widgets/arrow_card.dart';
import 'package:quran_listienning/widgets/mood_ui.dart';

class Listen extends StatefulWidget {
  final List<Data> data;
  final int id;
  int index;

  Listen(this.data, this.id, this.index);

  @override
  _ListenState createState() => _ListenState();
}

class _ListenState extends State<Listen> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;

  pauseAudio() async {}

  onSeekToAnewPosition(double value) {
    BlocProvider.of<ListenBloc>(context).add(ChangePosition(newValue: value));
  }

  Widget swiper(
    Data data,
  ) {
    return Container(
        margin: EdgeInsets.only(top: 15),
        height: MediaQuery.of(context).size.height * .6 -
            MediaQuery.of(context).padding.top,
        child: Column(
          children: [
            SizedBox(
              height: animation.value,
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
                    width: 150,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Image.network(
                      widget.id != null
                          ? DataRepo().items[widget.id - 1].imageUrl
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

  Widget controlInSound(
      {double sliderValue,
      Duration sliderValue1,
      Duration position,
      bool isOn}) {
    return Expanded(
      child: Stack(
        overflow: Overflow.visible,
        children: [
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
                    max: sliderValue ?? 1,
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
                                  ? context.read<ListenBloc>().add(PauseAudio())
                                  : context
                                      .read<ListenBloc>()
                                      .add(ResumeAudio());
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
              imageNumber: 4,
            ),
          )
        ],
      ),
    );
  }

  nextSura() {
    BlocProvider.of<ListenBloc>(
      context,
    ).add(NextSura());
  }

  previousSura() {
    BlocProvider.of<ListenBloc>(
      context,
    ).add(PreviousSura());
  }

  Widget loaded(
      {double sliderValue,
      Duration sliderValue1,
      Duration position,
      bool isOn,
      Data data,
      BuildContext context}) {
    return Column(
      children: [
        // appBar(context),
        swiper(data),
        controlInSound(
            isOn: isOn,
            position: position,
            sliderValue1: sliderValue1,
            sliderValue: sliderValue),
      ],
    );
  }

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 100, end: 0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
    Future.delayed(Duration.zero).then((value) {
      return BlocProvider.of<ListenBloc>(
        context,
      ).add(PlayAudio(widget.data, widget.index));
    });

    super.initState();
  }

  @override
  Future<void> dispose() async {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          'Now playing',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        backgroundColor: Color(0xFFFFF2F2),
        centerTitle: true,
      ),
      // key:GlobalKey(debugLabel: 'l'),
      backgroundColor: Color(0xFFFFF2F2),
      body: BlocBuilder<ListenBloc, ListenState>(
        builder: (ctx, state) {
          if (state is ListenInitial) {
            return Center(child: Text('intial'));
          }
          if (state is ListenLoading) {
            return Text('loading');
          } else if (state is ListenLoaded) {
            return loaded(
                sliderValue: state.sliderValue,
                sliderValue1: state.sliderValue1,
                position: state.position,
                isOn: state.isOn,
                data: state.data,
                context: ctx);
          } else if (state is ListenResume) {
            return loaded(
                sliderValue: state.sliderValue,
                sliderValue1: state.sliderValue1,
                position: state.position,
                isOn: state.isOn,
                data: state.data,
                context: ctx);
          } else if (state is ListenNextSura) {
            return loaded(
                sliderValue1: null,
                isOn: true,
                position: Duration.zero,
                sliderValue: 0,
                context: ctx);
          }
          if (state is ErrorInListen) {
            return Container(
              child: Center(
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('go back'),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
