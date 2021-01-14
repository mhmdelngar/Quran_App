import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:quran_listienning/bloc/main/main_screen_bloc.dart';
import 'package:quran_listienning/ui/mainScreenUI.dart';

import 'choose_sura.dart';
import 'drawer.dart';

class MyHomePage extends StatelessWidget {
  onTap(int i, BuildContext context) {
    if (i == 0) {
      BlocProvider.of<MainScreenBloc>(context).add(ChangeToQuran());
    }
    if (i == 1) {
      BlocProvider.of<MainScreenBloc>(context).add(ChangeToAzkar());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          await Hive.close(); //to close the dataBase when out
          MoveToBackground.moveTaskToBack();
          return false;
        },
        child: Scaffold(
          drawer: DrawerScreen(),
          backgroundColor: Color(0xFFFFF2F2),
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Builder(builder: (context) => MainScreenUI.appBar(context)),
                    MainScreenUI.buildMood(),
                    SizedBox(
                      height: 24,
                    ),
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              40,
                            ),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DefaultTabController(
                                initialIndex: 0,
                                length: 2,
                                child: TabBar(
                                  indicatorColor: Colors.pinkAccent[100],
                                  labelColor: Colors.pinkAccent[100],
                                  indicatorWeight: 0.5,
                                  unselectedLabelColor: Colors.grey[400],
                                  // controller: DefaultTabController(),
                                  onTap: (i) {
                                    onTap(i, context);
                                  },
                                  tabs: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'َقــران',
                                      ),
                                    ),
                                    Text(
                                      'أذكار',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            BlocConsumer<MainScreenBloc, MainScreenState>(
                                listener: (ctx, state) {
                              if (state is NavigateToGetData) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) {
                                      return ChooseSura(
                                        id: state.id,
                                      );
                                    },
                                  ),
                                );
                              }
                            }, builder: (context, state) {
                              if (state is MainScreenInitial) {
                                onTap(0, context);
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (state is MainScreenLoading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (state is MainScreenAzkar) {
                                return MainScreenUI.azkarBuild(state.azkarData);
                              } else if (state is MainScreenQuran) {
                                return MainScreenUI.quranBuild(
                                    state.items, state.ayaItems);
                              } else if (state is MainScreenError) {
                                return Center(
                                  child: Text('error'),
                                );
                              } else {
                                onTap(0, context);
                                return Container();
                              }
                            })
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              overflow: Overflow.visible,
            ),
          ),
        ));
  }
}

// will be implemented soon
//   Positioned(
//     top: MediaQuery.of(context).size.height * .85,
//     // height: MediaQuery.of(context).size.height * .9,
//     // width: double.infinity,
//     child: Container(
//       color: Colors.green,
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height * .15,
//       child: ListTile(
//           leading: MoodUi(
//             imageAsset: 'images/musical-note.png',
//           ),
//           title: Text('quran.data[index].sora'),
//           subtitle: Text('quran.data[index].type'),
//           trailing: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('qur'),
//               SizedBox(
//                 width: 4,
//               ),
//               Icon(Icons.favorite_border)
//             ],
//           )),
//     ),
//   )
