import 'package:equatable/equatable.dart';

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
class Data extends Equatable {
  String id;
  String sora;
  String link;
  String readerName;
  String pageNumber;
  String type;
  String soraNumber;
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
  // TODO: implement props
  List<Object> get props =>
      [id, sora, link, readerName, pageNumber, type, soraNumber, ayatsNumber];
}
