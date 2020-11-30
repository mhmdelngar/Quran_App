class AzkarData {
  List<Azkar> items = [];

  AzkarData({this.items});
  AzkarData.fromJson(List json) {
    json.forEach((element) {
      items.add(Azkar.fromJson(element));
    });
  }
}

class Azkar {
  String name;
  String readerName;
  String readerImg;
  String link;

  Azkar({this.name, this.readerName, this.readerImg, this.link});

  Azkar.fromJson(dynamic json) {
    print(json);
    name = json['Name'];
    readerName = json['reader_name'];
    readerImg = json['reader_img'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['reader_name'] = this.readerName;
    data['reader_img'] = this.readerImg;
    data['link'] = this.link;
    return data;
  }
}
