import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_listienning/bloc/favourit/fav_bloc.dart';
import 'package:quran_listienning/bloc/search_in_chosse/search_in_choose_bloc.dart';
import 'package:quran_listienning/data/models/quran_data.dart';
import 'package:quran_listienning/screens/main_screen.dart';

import 'bloc/chooseSura/choose_sura_bloc.dart';
import 'bloc/listen/listen_bloc.dart';
import 'bloc/main/main_screen_bloc.dart';
import 'data/repo.dart';
import 'data/serviece/audioRepo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  ); //to make statusBarColor as the screen

  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path); //init the Hive
  Hive.registerAdapter(
    DataAdapter(),
  ); //register an object which called Data

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp())); //no landScape mood
}

class MyApp extends StatelessWidget {
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
        BlocProvider<FavBloc>(
          create: (context) => FavBloc(),
        ),
        BlocProvider<ListenBloc>(
          create: (
            context,
          ) =>
              ListenBloc(
            AudioRepo(AssetsAudioPlayer()),
          ),
        ),
      ],
      child: MaterialApp(
        //splash screen
        debugShowCheckedModeBanner: false,
        title: 'Quran App',
        home: AnimatedSplashScreen(
          duration: 1000,
          splash: 'images/quran_icon.png',
          splashIconSize: 200,
          nextScreen: MyHomePage(),
          splashTransition: SplashTransition.sizeTransition,
          backgroundColor: Color(0xFFFFF2F2),
          pageTransitionType: PageTransitionType.fade,
        ),
      ),
    );
  }
}
