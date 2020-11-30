import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quran_listienning/bloc/search_in_chosse/search_in_choose_bloc.dart';
import 'package:quran_listienning/screens/main_screen.dart';

import 'bloc/chooseSura/choose_sura_bloc.dart';
import 'bloc/listen/listen_bloc.dart';
import 'bloc/main/main_screen_bloc.dart';
import 'data/audioRepo.dart';
import 'data/repo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainScreenBloc>(
          create: (context) => MainScreenBloc(DataRepo()),
        ),
        BlocProvider<ChooseSuraBloc>(
          create: (context) => ChooseSuraBloc(dataRepo: DataRepo()),
        ),
        BlocProvider<SearchInChooseBloc>(
          create: (context) => SearchInChooseBloc(),
        ),
        BlocProvider<ListenBloc>(
          create: (
            context,
          ) =>
              ListenBloc(AudioRepo(AssetsAudioPlayer())),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quran App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          // visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SafeArea(
          child: AnimatedSplashScreen(
            duration: 1000,
            splash: 'images/quran_icon.png',
            splashIconSize: 200,
            nextScreen: MyHomePage(),
            splashTransition: SplashTransition.sizeTransition,
            backgroundColor: Color(0xFFFFF2F2),
            pageTransitionType: PageTransitionType.fade,
          ),
        ),
      ),
    );
  }
}
