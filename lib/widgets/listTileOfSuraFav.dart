import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mood_ui.dart';

class ListTileOfSuraFav extends StatelessWidget {
  final int index;
  final List<dynamic> data;
  final Function onTap;

  const ListTileOfSuraFav({this.index, this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: MoodUi(
        imageAsset: 'images/musical-note.png',
      ),
      title: Text(data[index].sora),
      subtitle: Text(data[index].readerName),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(data[index].soraNumber),
          SizedBox(
            width: 4,
          ),
          // Icon(Icons.)
        ],
      ),
    );
  }
}
