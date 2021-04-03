import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_listienning/data/models/quran_data.dart';

import 'mood_ui.dart';

class ListTileOfSura extends StatelessWidget {
  final int index;
  final Quran quran;
  final Function onTap;

  const ListTileOfSura({this.index, this.quran, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: MoodUi(
        imageAsset: 'images/musical-note.png',
      ),
      title: Text(quran.data[index].sora),
      subtitle: Text(quran.data[index].type),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(quran.data[index].soraNumber.toString()),
          SizedBox(
            width: 4,
          ),
        ],
      ),
    );
  }
}
