// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'juzId.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JuzIdAdapter extends TypeAdapter<JuzId> {
  @override
  final int typeId = 5;

  @override
  JuzId read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JuzId(
      number: fields[0] as int?,
      ayahs: (fields[1] as List?)?.cast<Ayah?>(),
    );
  }

  @override
  void write(BinaryWriter writer, JuzId obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.ayahs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JuzIdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
