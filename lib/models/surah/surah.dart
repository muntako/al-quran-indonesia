import 'dart:convert';

import 'package:al_quran/cubits/surat/cubit.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'surah.g.dart';

@HiveType(typeId: 6)
class Surah {
  @HiveField(0)
  final int? nomor;
  @HiveField(1)
  final String? nama;
  @HiveField(2)
  final String? namaLatin;
  @HiveField(3)
  final int? jumlahAyat;
  @HiveField(4)
  final String? tempatTurun;
  @HiveField(5)
  final String? arti;
  @HiveField(6)
  final String? deskripsi;
  @HiveField(7)
  final String? audio;
  Surah(
    this.nomor,
    this.nama,
    this.namaLatin,
    this.jumlahAyat,
    this.tempatTurun,
    this.arti,
    this.deskripsi,
    this.audio,
  );

  Surah copyWith({
    int? nomor,
    String? nama,
    String? namaLatin,
    int? jumlahAyat,
    String? tempatTurun,
    String? arti,
    String? deskripsi,
    String? audio,
  }) {
    return Surah(
      nomor ?? this.nomor,
      nama,
      namaLatin,
      jumlahAyat,
      tempatTurun,
      arti,
      deskripsi,
      audio,
    );
  }

  Surah merge(Surah model) {
    return Surah(
      model.nomor,
      model.nama,
      model.namaLatin,
      model.jumlahAyat,
      model.tempatTurun,
      model.arti,
      model.deskripsi,
      model.audio,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nomor': nomor,
      'nama': nama,
      'namaLatin': namaLatin,
      'jumlahAyat': jumlahAyat,
      'tempatTurun': tempatTurun,
      'arti': arti,
      'deskripsi': deskripsi,
      'audio': audio,
    };
  }

  factory Surah.fromMap(Map<String, dynamic> map) {
    return Surah(
      map['nomor'],
      map['nama'],
      map['nama_latin'],
      map['jumlah_ayat'],
      map['tempat_turun'],
      map['arti'],
      map['deskripsi'],
      map['audio'],
    );
  }

  static Surah? fromNumber(BuildContext context, num index) {
    final surahCubit = SurahCubit.cubit(context);
    final surah = surahCubit.state.data![index.hashCode - 1];
    return surah;
  }

  String toJson() => json.encode(toMap());

  factory Surah.fromJson(String source) => Surah.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Surah(nomor: $nomor, nama: $nama, namaLatin: $namaLatin, jumlahAyat: $jumlahAyat, tempatTurun: $tempatTurun, arti: $arti, deskripsiL: $deskripsi, audio:$audio)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Surah &&
        other.nomor == nomor &&
        other.nama == nama &&
        other.namaLatin == namaLatin &&
        other.jumlahAyat == jumlahAyat &&
        other.tempatTurun == tempatTurun &&
        other.arti == arti &&
        other.deskripsi == deskripsi &&
        other.audio == audio;
  }

  @override
  int get hashCode {
    return nomor.hashCode ^
        deskripsi.hashCode ^
        namaLatin.hashCode ^
        jumlahAyat.hashCode ^
        tempatTurun.hashCode ^
        arti.hashCode ^
        deskripsi.hashCode ^
        audio.hashCode;
  }
}
