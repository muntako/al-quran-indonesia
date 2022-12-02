import 'dart:convert';

import 'package:al_quran/models/chapter/chapter.dart';
import 'package:al_quran/models/surah/surah.dart';
import 'package:hive/hive.dart';

part 'ayah.g.dart';

@HiveType(typeId: 0)
class Ayah {
  @HiveField(0)
  final num? number;
  @HiveField(1)
  final String? text;
  @HiveField(2)
  final Surah? surah;
  @HiveField(3)
  final num? numberInSurah;
  @HiveField(4)
  final num? juz;
  Ayah({
    this.number,
    this.text,
    this.surah,
    this.numberInSurah,
    this.juz,
  });

  Ayah copyWith({num? number, String? text, Surah? surah, num? juz}) {
    return Ayah(
        number: number ?? number,
        text: text ?? text,
        surah: surah ?? surah,
        numberInSurah: numberInSurah ?? numberInSurah,
        juz: juz ?? juz);
  }

  Ayah merge(Ayah model) {
    return Ayah(
        number: model.number ?? number,
        text: model.text ?? text,
        surah: model.surah ?? surah,
        numberInSurah: model.numberInSurah ?? numberInSurah,
        juz: model.juz ?? juz);
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'text': text,
      'surah': surah,
      'numberInSurah': numberInSurah,
      'juz': juz
    };
  }

  factory Ayah.fromMap(Map<String, dynamic> map) {
    return Ayah(
        number: map['number'],
        text: map['text'],
        surah: Surah.fromMap(map['surah']),
        numberInSurah: map['numberInSurah'],
        juz: map['juz']);
  }
  factory Ayah.fromChapter(
      Map<String, dynamic> map, Map<String, dynamic> surah) {
    return Ayah(
        number: map['number'],
        text: map['text'],
        surah: Surah.fromMap(surah),
        numberInSurah: map['numberInSurah'],
        juz: map['juz']);
  }

  String toJson() => json.encode(toMap());

  factory Ayah.fromJson(String source) => Ayah.fromMap(json.decode(source));

  @override
  String toString() => 'Ayah(number: $number, text: $text)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ayah &&
        other.number == number &&
        other.text == text &&
        other.surah == surah &&
        other.numberInSurah == numberInSurah &&
        other.juz == juz;
  }

  @override
  int get hashCode =>
      number.hashCode ^
      text.hashCode ^
      surah.hashCode ^
      numberInSurah.hashCode ^
      juz.hashCode;
}
