import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'quran_data.g.dart';

class Quran {
  String message;
  int count;
  List<Data> data;

  Quran({this.message, this.count, this.data});

  Quran.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// ignore: must_be_immutable
@HiveType(typeId: 22)
class Data extends Equatable {
  @HiveField(0)
  String id;
  @HiveField(1)
  String sora;
  @HiveField(2)
  String link;
  @HiveField(3)
  String readerName;
  @HiveField(4)
  String pageNumber;
  @HiveField(5)
  String type;
  @HiveField(6)
  String soraNumber;
  @HiveField(7)
  String ayatsNumber;

  Data(
      {this.id,
      this.sora,
      this.link,
      this.readerName,
      this.pageNumber,
      this.type,
      this.soraNumber,
      this.ayatsNumber});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sora = json['sora'];
    link = json['link'];
    readerName = json['readerName'];
    pageNumber = json['pageNumber'];
    type = json['type'];
    soraNumber = json['soraNumber'];
    ayatsNumber = json['ayatsNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['sora'] = this.sora;
    data['link'] = this.link;
    data['readerName'] = this.readerName;
    data['pageNumber'] = this.pageNumber;
    data['type'] = this.type;
    data['soraNumber'] = this.soraNumber;
    data['ayatsNumber'] = this.ayatsNumber;
    return data;
  }

  @override
  List<Object> get props =>
      [id, sora, link, readerName, pageNumber, type, soraNumber, ayatsNumber];
}
