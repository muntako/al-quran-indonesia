import 'dart:convert';

import 'package:al_quran/cubits/chapter/cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import 'package:al_quran/models/ayah/ayah.dart';

part 'chapter.g.dart';

@HiveType(typeId: 1)
class Chapter {
  @HiveField(0)
  final int? number;
  @HiveField(1)
  final List<Ayah?>? ayahs;
  Chapter({
    this.number,
    this.ayahs,
  });

  Chapter copyWith({
    int? number,
    List<Ayah?>? ayahs,
  }) {
    return Chapter(
      number: number ?? this.number,
      ayahs: ayahs ?? this.ayahs,
    );
  }

  Chapter merge(Chapter model) {
    return Chapter(
      number: model.number ?? number,
      ayahs: model.ayahs ?? ayahs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'ayahs': ayahs?.map((x) => x?.toMap()).toList(),
    };
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      number: map['number'],
      ayahs: List<Ayah>.from(
          map['ayahs']?.map((x) => Ayah.fromChapter(x, map['number']))),
    );
  }

  static Future<Chapter?> fromIndex(BuildContext context, int index) async {
    ChapterCubit chapterCubit = ChapterCubit.cubit(context);
    final chapter = chapterCubit.state.data![index];
    return chapter;
  }

  String toJson() => json.encode(toMap());

  factory Chapter.fromJson(String source) =>
      Chapter.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Chapter(number: $number, ayahs: $ayahs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Chapter &&
        other.number == number &&
        listEquals(other.ayahs, ayahs);
  }

  @override
  int get hashCode {
    return number.hashCode ^ ayahs.hashCode;
  }
}
