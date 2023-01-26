import 'package:al_quran/app_routes.dart';
import 'package:flutter/material.dart';

class DrawerUtils {
  static const List items = [
    {
      'title': 'Surat',
      'icon': Icons.format_list_numbered_outlined,
      'route': AppRoutes.surah,
    },
    {
      'title': 'Juz',
      'icon': Icons.list,
      'route': AppRoutes.juz,
    },
    {
      'title': 'Bookmark',
      'icon': Icons.bookmark_outline,
      'route': AppRoutes.bookmarks,
    },
    {
      'title': 'Bantuan',
      'icon': Icons.help_outline,
      'route': AppRoutes.helpGuide,
    },
    {
      'title': 'Pengaturan',
      'icon': Icons.settings,
      'route': AppRoutes.setting,
    },
    {
      'title': 'Bagikan Aplikasi',
      'icon': Icons.share_outlined,
      'route': AppRoutes.shareApp,
    },
  ];
}
