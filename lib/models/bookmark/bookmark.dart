import 'dart:convert';

import 'package:hive/hive.dart';

part 'bookmark.g.dart';

@HiveType(typeId: 7)
class Bookmark {
  @HiveField(0)
  final num? number;
  @HiveField(1)
  final num? juz;
  @HiveField(2)
  final num? surah;
  @HiveField(3)
  final num? numberInSurah;
  @HiveField(4)
  final bool? terakhirDibaca;
  Bookmark(
      {this.terakhirDibaca,
      this.number,
      this.juz,
      this.surah,
      this.numberInSurah});

  Bookmark copyWith({
    num? number,
    num? juz,
    num? surah,
    num? numberInSurah,
    bool? terakhirDibaca,
  }) {
    return Bookmark(
      number: number ?? number,
      surah: surah ?? surah,
      numberInSurah: numberInSurah ?? numberInSurah,
      juz: juz ?? juz,
      terakhirDibaca: terakhirDibaca ?? terakhirDibaca,
    );
  }

  Bookmark merge(Bookmark model) {
    return Bookmark(
      number: model.number ?? number,
      surah: model.surah ?? surah,
      numberInSurah: model.numberInSurah ?? numberInSurah,
      juz: model.juz ?? juz,
      terakhirDibaca: model.terakhirDibaca ?? terakhirDibaca,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'surah': surah,
      'numberInSurah': numberInSurah,
      'juz': juz,
      'terakhirDibaca': terakhirDibaca,
    };
  }

  factory Bookmark.fromMap(Map<String, dynamic> map) {
    return Bookmark(
        number: map['number'],
        surah: map['surah'],
        numberInSurah: map['numberInSurah'],
        juz: map['juz'],
        terakhirDibaca: map['terakhirDibaca'] ?? false);
  }

  String toJson() => json.encode(toMap());

  factory Bookmark.fromJson(String source) =>
      Bookmark.fromMap(json.decode(source));

  @override
  String toString() => 'Bookmark(number: $number, juz: $juz)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Bookmark &&
        other.number == number &&
        other.surah == surah &&
        other.numberInSurah == numberInSurah &&
        other.juz == juz &&
        other.terakhirDibaca == terakhirDibaca;
  }

  @override
  int get hashCode =>
      number.hashCode ^
      surah.hashCode ^
      numberInSurah.hashCode ^
      juz.hashCode ^
      terakhirDibaca.hashCode;
}
