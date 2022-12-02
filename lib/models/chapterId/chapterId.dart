import 'dart:convert';

import 'package:al_quran/models/chapter/chapter.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:al_quran/models/ayah/ayah.dart';

part 'chapterId.g.dart';

@HiveType(typeId: 4)
class ChapterId {
  @HiveField(0)
  final int? number;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? englishName;
  @HiveField(3)
  final String? englishNameTranslation;
  @HiveField(4)
  final String? revelationType;
  @HiveField(5)
  final List<Ayah?>? ayahs;
  ChapterId({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.revelationType,
    this.ayahs,
  });

  ChapterId copyWith({
    int? number,
    String? name,
    String? englishName,
    String? englishNameTranslation,
    String? revelationType,
    List<Ayah?>? ayahs,
  }) {
    return ChapterId(
      number: number ?? this.number,
      name: name ?? this.name,
      englishName: englishName ?? this.englishName,
      englishNameTranslation:
          englishNameTranslation ?? this.englishNameTranslation,
      revelationType: revelationType ?? this.revelationType,
      ayahs: ayahs ?? this.ayahs,
    );
  }

  factory ChapterId.fromChapterNumber(List<ChapterId> chapters, int index) {
    return chapters.where((element) => element.number == index).toList()[0];
  }

  ChapterId merge(ChapterId model) {
    return ChapterId(
      number: model.number ?? number,
      name: model.name ?? name,
      englishName: model.englishName ?? englishName,
      englishNameTranslation:
          model.englishNameTranslation ?? englishNameTranslation,
      revelationType: model.revelationType ?? revelationType,
      ayahs: model.ayahs ?? ayahs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'name': name,
      'englishName': englishName,
      'englishNameTranslation': englishNameTranslation,
      'revelationType': revelationType,
      'ayahs': ayahs?.map((x) => x?.toMap()).toList(),
    };
  }

  factory ChapterId.fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> surah = {
      'number': map['number'],
      'name': map['name'],
      'englishName': map['englishName'],
      'englishNameTranslation': map['englishNameTranslation'],
      'revelationType': map['revelationType'],
      'numberOfAyahs': List.from(map['ayahs']).length,
    };
    return ChapterId(
      number: map['number'],
      name: map['name'],
      englishName: map['englishName'],
      englishNameTranslation: map['englishNameTranslation'],
      revelationType: map['revelationType'],
      ayahs:
          List<Ayah>.from(map['ayahs']?.map((x) => Ayah.fromChapter(x, surah))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChapterId.fromJson(String source) =>
      ChapterId.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChapterId(number: $number, name: $name, englishName: $englishName, englishNameTranslation: $englishNameTranslation, revelationType: $revelationType, ayahs: $ayahs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChapterId &&
        other.number == number &&
        other.name == name &&
        other.englishName == englishName &&
        other.englishNameTranslation == englishNameTranslation &&
        other.revelationType == revelationType &&
        listEquals(other.ayahs, ayahs);
  }

  @override
  int get hashCode {
    return number.hashCode ^
        name.hashCode ^
        englishName.hashCode ^
        englishNameTranslation.hashCode ^
        revelationType.hashCode ^
        ayahs.hashCode;
  }
}
