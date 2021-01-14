import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quran_listienning/bloc/main/main_screen_bloc.dart';
import 'package:quran_listienning/data/models/ayah.dart';
import 'package:quran_listienning/data/models/azkar.dart';
import 'package:quran_listienning/data/models/quran_data.dart';
import 'package:quran_listienning/data/models/sheikh.dart';
import 'package:quran_listienning/data/repo.dart';
import 'package:quran_listienning/screens/listenScreen.dart';
import 'package:quran_listienning/widgets/mood_ui.dart';
import 'package:quran_listienning/widgets/play_list_ui.dart';
import 'package:quran_listienning/widgets/sheikh_container.dart';

import '../screens/searchBar.dart';

class MainScreenUI {
  static Widget appBar(BuildContext ctx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(ctx).openDrawer();
              }),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              showSearch(context: ctx, delegate: DataSearch(DataRepo().items));
            },
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(
                      'Search',
                      style: Theme.of(ctx).textTheme.caption,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showSearch(
                          context: ctx, delegate: DataSearch(DataRepo().items));
                    },
                    icon: Icon(
                      Icons.search,
                    ),
                  )
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  25,
                ),
              ),
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            FontAwesomeIcons.headphones,
            size: 30,
          ),
        )
      ],
    );
  }

  static randomlyAyah(BuildContext context, int index) {
    List<Data> ayaItemsData = [];

    Random random = Random();

    final int randomNumber = random.nextInt(6236);
    ayaItemsData.add(
      Data(
          link:
              'http://cdn.alquran.cloud/media/audio/ayah/ar.alafasy/$randomNumber/high',
          sora: 'ارح قلبك ',
          id: randomNumber.toString(),
          readerName: 'مشاري العفاسي ',
          soraNumber: randomNumber.toString()),
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (
          context,
        ) =>
            Listen(ayaItemsData, null, 0),
      ),
    );
  } //generate 5 random ayat

  static Widget buildMood() {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(left: 20, top: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              'My mood',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
        Padding(
          padding: const EdgeInsets.all(13.0),
          child: Container(
            width: double.infinity,
            height: 50,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    GestureDetector(
                        child: MoodUi(
                          imageNumber: index + 1,
                        ),
                        onTap: () {
                          randomlyAyah(context, index);
                        }),
                    SizedBox(
                      width: 24,
                    )
                  ],
                );
              },
              itemCount: 5,
              scrollDirection: Axis.horizontal,
            ),
          ),
        )
      ],
    );
  }

  static Widget quranBuild(List<Sheikh> items, List<Ayah> ayaItems) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 200,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ShikhContainer(
                    title: items[index].name,
                    imageUrl: items[index].imageUrl,
                    id: items[index].id,
                    onTap: toNavigate);
              },
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              'PLAY LISTS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: playList(ayaItems),
          )
        ],
      ),
    );
  }

  static Widget playList(List<Ayah> ayaItems) {
    final List<Data> ayaItemsData = ayaItems
        .map(
          (e) => Data(
              link: e.ayaUrl,
              sora: e.aya,
              id: e.ayahNumper.toString(),
              readerName: 'مشاري',
              soraNumber: e.ayahNumper.toString()),
        )
        .toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return PlayListUi(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (
                  context,
                ) =>
                    Listen(ayaItemsData, 1, index),
              ),
            );
          },
          title: ayaItems[index].aya,
          ayahNumber: ayaItems[index].ayahNumper,
        );
      },
      itemCount: ayaItems.length,
    );
  }

  static Widget azkarBuild(AzkarData azkarData) {
    return Expanded(
      child: AnimationLimiter(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                childAspectRatio: 7 / 6,
                mainAxisSpacing: 1,
                crossAxisCount: 2),
            itemCount: azkarData.items.length,
            itemBuilder: (context, i) => AnimationConfiguration.staggeredGrid(
                  duration: const Duration(milliseconds: 375),
                  columnCount: azkarData.items.length,
                  position: i,
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FlipAnimation(
                      child: Container(
                        margin: EdgeInsets.all(15),
                        height: 300,
                        child: GestureDetector(
                          onTap: () {
                            final List<Data> dataAzkar = azkarData.items
                                .map(
                                  (e) => Data(
                                      link: azkarData.items[i].link,
                                      readerName: azkarData.items[i].readerName,
                                      sora: azkarData.items[i].name,
                                      id: '1',
                                      soraNumber: i.toString()),
                                )
                                .toList();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    Listen(dataAzkar, null, i),
                              ),
                            );
                          },
                          child: Stack(
                            overflow: Overflow.visible,
                            children: [
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  child: Image.asset(
                                    'images/Azkar.jpg',
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 40,
                                right: 0,
                                top: 85,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Wrap(
                                      direction: Axis.vertical,
                                      alignment: WrapAlignment.center,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        Text(
                                          azkarData.items[i].name,
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }

  static toNavigate(int id, BuildContext context) {
    BlocProvider.of<MainScreenBloc>(context).add(NavigateTo(id));
  }
}
