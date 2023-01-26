import 'dart:convert';
import 'dart:math';

import 'package:al_quran/cubits/chapterId/cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part 'ayah.g.dart';

@HiveType(typeId: 0)
class Ayah {
  @HiveField(0)
  final num? number;
  @HiveField(1)
  final String? text;
  @HiveField(2)
  final num? surah;
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

  Ayah copyWith({num? number, String? text, num? surah, num? juz}) {
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
        surah: map['surah']['number'],
        numberInSurah: map['numberInSurah'],
        juz: map['juz']);
  }
  factory Ayah.fromChapter(Map<String, dynamic> map, num surah) {
    return Ayah(
        number: map['number'],
        text: map['text'],
        surah: surah,
        numberInSurah: map['numberInSurah'],
        juz: map['juz']);
  }

  static Ayah? randomAyat(BuildContext context) {
    ChapterIdCubit chapterCubit = ChapterIdCubit.cubit(context);
    final chapters = chapterCubit.state.data!;
    final _random = Random();

    // generate a random index based on the list length
    // and use it to retrieve the element
    var chapter = chapters[_random.nextInt(chapters.length)];
    var ayat = chapter!.ayahs![_random.nextInt(chapter.ayahs!.length)];
    return ayat;
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
