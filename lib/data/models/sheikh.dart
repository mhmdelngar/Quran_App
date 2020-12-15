import 'package:equatable/equatable.dart';

class Sheikh extends Equatable {
  final String name;
  final String imageUrl;
  final int id;

  Sheikh({this.name, this.imageUrl, this.id});

  @override
  // TODO: implement props
  List<Object> get props => [name, imageUrl, id];
}
