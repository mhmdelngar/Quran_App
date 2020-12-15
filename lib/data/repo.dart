import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/ayah.dart';
import 'models/azkar.dart';
import 'models/quran_data.dart';
import 'models/sheikh.dart';

class DataRepo {
  getAllQuranData(int readerId) async {
    final response = await http.post(
        'https://gad25.xyz/Quran/QuranShared.php/?reader_id=1',
        body: {'reader_id': '$readerId'});
    if (response.statusCode == 200) {
      return Quran.fromJson(jsonDecode(response.body));
    }
  }

  Future<dynamic> getAzkar() async {
    try {
      final response = await http.get('https://gad25.xyz/Quran/Azkar.php');

      if (response.statusCode == 200) {
        return AzkarData.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
      return e;
    }
  }

  List<Sheikh> _items = [
    Sheikh(
      id: 1,
      imageUrl:
          'https://i1.sndcdn.com/artworks-000026309409-acfg4k-t500x500.jpg',
      name: 'مشارى العفاسى',
    ),
    Sheikh(
      id: 2,
      imageUrl: 'http://quran.com.kw/wp-content/uploads/maher-almoeqly.jpg',
      name: 'ماهر المعيقلي',
    ),
    Sheikh(
      id: 3,
      imageUrl:
          'https://masjidassunnah-fl.com/wp-content/uploads/2012/07/Ahmed-Al-Ajami.jpg',
      name: 'أحــمد العجمى',
    ),
    Sheikh(
      id: 4,
      imageUrl: 'http://quran.com.kw/wp-content/uploads/saad-alghamedi.jpg',
      name: 'سعد الغامدى',
    ),
    Sheikh(
      id: 5,
      imageUrl:
          'https://s3-eu-west-1.amazonaws.com/content.argaamnews.com/37f617fd-7b85-4a3e-92c9-6fff09a79ca8.jpg',
      name: 'عبدالرحمن السديسى',
    ),
    Sheikh(
      id: 6,
      imageUrl: 'http://quran.com.kw/wp-content/uploads/Mohammed-Jebreil.jpg',
      name: 'محــمد جـــبريــل',
    ),
    Sheikh(
      id: 7,
      imageUrl:
          'https://e3raph.com/wp-content/uploads/2018/11/2016-08-01_005302.png',
      name: 'عبدالــباسط عبدالصمد',
    ),
    Sheikh(
      id: 8,
      imageUrl: 'https://upload.sqorebda3.com/uploads/153811939590334.jpg',
      name: 'محمد صديق المنشاوى',
    ),
    Sheikh(
      id: 9,
      imageUrl:
          'https://1.bp.blogspot.com/-VtHnX0NLZTk/VMp8kVMkilI/AAAAAAAAAtA/FtjA4jcXjko/s1600/fares-abbad-2249.jpg',
      name: 'فـــــارس عـــباد',
    ),
    Sheikh(
      id: 10,
      imageUrl:
          'https://i.pinimg.com/564x/01/5d/f6/015df643ce7ea23193ef69dc5c1a5a0e.jpg',
      name: 'وديــــع اليمني',
    ),
    Sheikh(
      id: 11,
      imageUrl: 'https://quran.com.kw/wp-content/uploads/altablawy.jpg',
      name: 'مـــحمد الطبلاوى',
    ),
    Sheikh(
      id: 12,
      imageUrl:
          'https://alqol.com/wp-content/uploads/2016/04/%D8%A7%D9%84%D9%82%D8%A7%D8%B1%D8%A6-%D8%A3%D8%AD%D9%85%D8%AF-%D8%A7%D9%84%D8%AD%D8%B0%D9%8A%D9%81%D9%8A.jpg',
      name: 'أحــمد الحذيفى',
    ),
    Sheikh(
      id: 13,
      imageUrl:
          'https://static.suratmp3.com/pics/reciters/thumbs/14_160_160.jpg',
      name: 'نــاصر القطامي',
    ),
    Sheikh(
      id: 14,
      imageUrl:
          'https://twasul.info/wp-content/themes/twasul/timthumb/?src=https://twasul.info/wp-content/uploads/2020/04/5e523e8c559ce.jpg&w=1586278&h=',
      name: 'عبدالله الجهنى',
    ),
    Sheikh(
      id: 15,
      imageUrl:
          'https://pbs.twimg.com/profile_images/612614000262561792/c_jiq6WF.jpg',
      name: 'ياسر الدوسري',
    ),
    Sheikh(
      id: 16,
      imageUrl: 'https://i.ytimg.com/vi/OqVRw4mcJw4/hqdefault.jpg',
      name: 'بندر بليلة',
    ),
    Sheikh(
      id: 17,
      imageUrl: 'https://i.ytimg.com/vi/IlkIqbV2oXU/hqdefault.jpg',
      name: 'سعود الشريم',
    ),
    Sheikh(
      id: 18,
      imageUrl:
          'https://yt3.ggpht.com/a/AGF-l78AKwwCDkS1iMtcZ2OqQkOikEU8nzeJA3G8KQ=s900-mo-c-c0xffffffff-rj-k-no',
      name: 'إدريس أبكر',
    ),
    Sheikh(
      id: 19,
      imageUrl:
          'https://i1.sndcdn.com/artworks-000042761240-joz1m0-t500x500.jpg',
      name: 'محمود خليل الحصري',
    ),
    Sheikh(
      id: 20,
      imageUrl:
          'https://www.almrsal.com/wp-content/uploads/2015/08/ahmed-al-trabulsy.jpg',
      name: 'أحمد خضر الطرابلسي',
    ),
    Sheikh(
      id: 21,
      imageUrl: 'https://i.imgur.com/Xth9HdF.jpg',
      name: 'أبو بكر الشاطري',
    ),
    Sheikh(
      id: 22,
      imageUrl:
          'https://i.pinimg.com/originals/b2/d1/af/b2d1af7141c2697159e4fb35046dc8c5.jpg',
      name: 'ياسر القرشي',
    ),
    Sheikh(
      id: 23,
      imageUrl: 'https://i.ytimg.com/vi/E6AqfhH_ibk/hqdefault.jpg',
      name: 'عبدالله خياط',
    ),
    Sheikh(
      id: 24,
      imageUrl:
          'https://tvquran.com/uploads/authors/images/%D8%B9%D8%A7%D8%AF%D9%84%20%D8%B1%D9%8A%D8%A7%D9%86.png',
      name: 'عادل ريان',
    ),
    Sheikh(
      id: 25,
      imageUrl:
          'http://ar.assabile.com/media/photo/full_size/ahmed-nuinaa-1335.jpg',
      name: 'أحمد نعينع',
    ),
    Sheikh(
      id: 26,
      imageUrl:
          'https://i1.sndcdn.com/artworks-000177626867-qz95qs-t500x500.jpg',
      name: 'محمود علي البنا',
    ),
    Sheikh(
      id: 27,
      imageUrl:
          'https://yt3.ggpht.com/a-/AAuE7mDLkiSQSojCHdNZE7BolYBqshJoxXL4YarTww=s900-mo-c-c0xffffffff-rj-k-no',
      name: 'هزاع البلوشي',
    ),
    Sheikh(
      id: 28,
      imageUrl:
          'https://tvquran.com/uploads/authors/images/%D9%85%D8%AD%D9%85%D8%AF%20%D8%B1%D9%81%D8%B9%D8%AA.jpg',
      name: 'محمد رفعت',
    ),
  ];

  List<Ayah> _ayaItems = [
    Ayah(
        ayahNumper: 262,
        aya: 'الله لا اله الا هو الحي القيوم ....',
        ayaUrl:
            'http://cdn.alquran.cloud/media/audio/ayah/ar.alafasy/262/high'),
    Ayah(
        aya: 'يا أهل الكتاب لم تلبسون  ....',
        ayahNumper: 364,
        ayaUrl:
            'http://cdn.alquran.cloud/media/audio/ayah/ar.alafasy/364/high'),
    Ayah(
        ayahNumper: 145,
        aya: 'صبغه الله ومن  ....',
        ayaUrl:
            'http://cdn.alquran.cloud/media/audio/ayah/ar.alafasy/145/high'),
    Ayah(
        ayahNumper: 486,
        aya: 'ربنا اننا سمعنا منادي ....',
        ayaUrl:
            'http://cdn.alquran.cloud/media/audio/ayah/ar.alafasy/486/high'),
  ];

  List<Ayah> get ayaItems {
    return [..._ayaItems];
  }

  List<Sheikh> get items {
    return [..._items];
  }
}
