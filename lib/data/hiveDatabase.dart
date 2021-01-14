import 'package:hive/hive.dart';

import 'models/quran_data.dart';

class DataBase {
  checkFav(Data data) async {
    if (Hive.isBoxOpen('favorite')) {
      var box = Hive.box<Data>('favorite');
      var isFav = box.containsKey(data.link);
      // print('mmmmmm' + isFav.toString());
      return isFav;
    } else {
      var box = await Hive.openBox<Data>('favorite');
      var isFav = box.containsKey(data.link);
      // print('mmmmmm' + isFav.toString());

      return isFav;
    }
  }

  addFav(Data data) {
    Box<Data> box = Hive.box<Data>('favorite');
    box.put(data.link, data);
  }

  removeFavItem(Data data) {
    var box = Hive.box<Data>('favorite');
    box.delete(data.link);
  }

  Future<dynamic> getAllFav() async {
    if (Hive.isBoxOpen('favorite')) {
      var box = Hive.box<Data>('favorite');
      var data = box.values.toList();
      // print(box.values.toList()[0].link);

      return data;
    } else {
      var box = await Hive.openBox<Data>('favorite');
      var data = box.values.toList();
      print(box.values.toList()[0]);
      return data;
    }
  }
}
