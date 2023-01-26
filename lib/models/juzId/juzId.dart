import 'dart:convert';

import 'package:al_quran/cubits/juzId/cubit.dart';
import 'package:flutter/foundation.dart';

import 'package:al_quran/models/ayah/ayah.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part 'juzId.g.dart';

@HiveType(typeId: 5)
class JuzId {
  @HiveField(0)
  final int? number;
  @HiveField(1)
  final List<Ayah?>? ayahs;
  JuzId({
    this.number,
    this.ayahs,
  });

  JuzId copyWith({
    int? number,
    List<Ayah?>? ayahs,
  }) {
    return JuzId(
      number: number ?? this.number,
      ayahs: ayahs ?? this.ayahs,
    );
  }

  JuzId merge(JuzId model) {
    return JuzId(
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

  factory JuzId.fromMap(Map<String, dynamic> map) {
    return JuzId(
      number: map['number'],
      ayahs: List<Ayah>.from(map['ayahs']?.map((x) => Ayah.fromMap(x))),
    );
  }
  static Future<JuzId?> fromIndex(BuildContext context, int index) async {
    JuzIdCubit juzCubit = JuzIdCubit.cubit(context);
    await juzCubit.fetch(index);
    final juz = juzCubit.state.data;
    return juz;
  }

  String toJson() => json.encode(toMap());

  factory JuzId.fromJson(String source) => JuzId.fromMap(json.decode(source));

  @override
  String toString() => 'JuzId(number: $number, ayahs: $ayahs)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JuzId &&
        other.number == number &&
        listEquals(other.ayahs, ayahs);
  }

  @override
  int get hashCode => number.hashCode ^ ayahs.hashCode;
}
