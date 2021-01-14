import 'package:flutter/material.dart';
import 'package:quran_listienning/widgets/mood_ui.dart';

class PlayListUi extends StatelessWidget {
  final String title;
  final int ayahNumber;
  final Function onTap;

  const PlayListUi({this.title, this.ayahNumber, this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        leading: MoodUi(
          imageAsset: 'images/musical-note.png',
        ),
        title: Text(
          title,
          textDirection: TextDirection.rtl,
        ),
        subtitle: Text(
          'مشاري العفاسي',
          textDirection: TextDirection.rtl,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 4,
            ),
          ],
        ));
  }
}
