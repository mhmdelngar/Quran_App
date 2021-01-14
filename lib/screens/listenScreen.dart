import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_listienning/bloc/listen/listen_bloc.dart';
import 'package:quran_listienning/data/models/quran_data.dart';
import 'package:quran_listienning/ui/listenUi.dart';

class Listen extends StatefulWidget {
  final List<Data> data;
  final int id;
  final int index;

  Listen(this.data, this.id, this.index);

  @override
  _ListenState createState() => _ListenState();
}

class _ListenState extends State<Listen> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;
  ListenBloc _listenBloc;
  ListenUi listenUi;

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
      final listenBloc = BlocProvider.of<ListenBloc>(context);
      _listenBloc = listenBloc;
      return _listenBloc.add(PlayAudio(widget.data, widget.index));
    });

    super.initState();
  }

  @override
  void dispose() {
    _listenBloc.add(StopListener());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    listenUi = ListenUi(_listenBloc, context, widget.id, animation.value);

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
      backgroundColor: Color(0xFFFFF2F2),
      body: BlocBuilder<ListenBloc, ListenState>(
        builder: (ctx, state) {
          if (state is ListenInitial) {
            return Center(child: Text('initial'));
          }
          if (state is ListenLoading) {
            return Text('loading');
          } else if (state is ListenLoaded) {
            return listenUi.loaded(
                sliderValue: state.sliderValue,
                sliderValue1: state.sliderValue1,
                position: state.position,
                isOn: state.isOn,
                data: state.data,
                isFav: state.isFav,
                context: ctx);
          } else if (state is ErrorInListen) {
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
