// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataAdapter extends TypeAdapter<Data> {
  @override
  final int typeId = 22;

  @override
  Data read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Data(
      id: fields[0] as String,
      sora: fields[1] as String,
      link: fields[2] as String,
      readerName: fields[3] as String,
      pageNumber: fields[4] as String,
      type: fields[5] as String,
      soraNumber: fields[6] as String,
      ayatsNumber: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Data obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.sora)
      ..writeByte(2)
      ..write(obj.link)
      ..writeByte(3)
      ..write(obj.readerName)
      ..writeByte(4)
      ..write(obj.pageNumber)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.soraNumber)
      ..writeByte(7)
      ..write(obj.ayatsNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
