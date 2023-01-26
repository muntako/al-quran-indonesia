// part of '../bookmarks_screen.dart';

import 'package:al_quran/configs/app_theme.dart';
import 'package:al_quran/cubits/bookmarks/cubit.dart';
import 'package:al_quran/models/bookmark/bookmark.dart';
import 'package:al_quran/models/chapter/chapter.dart';
import 'package:al_quran/models/chapterId/chapterId.dart';
import 'package:al_quran/models/juz/juz.dart';
import 'package:al_quran/models/juzId/juzId.dart';
import 'package:al_quran/models/surah/surah.dart';
import 'package:al_quran/providers/app_provider.dart';
import 'package:al_quran/screens/surah/surah_index_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkInformation extends StatefulWidget {
  final Bookmark? bookmark;
  final Surah? surah;
  final Juz? juz;
  final JuzId? juzId;
  final Chapter? chapter;
  final ChapterId? chapterId;
  const BookmarkInformation({
    Key? key,
    this.bookmark,
    this.surah,
    this.juz,
    this.juzId,
    this.chapter,
    this.chapterId,
  }) : super(key: key);

  @override
  BookmarkInformationState createState() => BookmarkInformationState();
}

class BookmarkInformationState extends State<BookmarkInformation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ScaleTransition(
      scale: scaleAnimation,
      alignment: Alignment.bottomCenter,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
            width: width * 0.75,
            height: height * 0.37,
            decoration: ShapeDecoration(
              color: appProvider.isDark ? Colors.grey[850] : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Center(
                //   child: Text(
                //     'Aksi',
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: height * 0.03,
                //     ),
                //   ),
                // ),
                Center(
                  child: Text(
                    'Qs. ${widget.surah!.namaLatin} (${widget.surah!.nomor}:${widget.bookmark!.numberInSurah})',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: height * 0.02,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        AppTheme.c!.accent,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PageScreen(
                            juz: widget.juz,
                            juzId: widget.juzId,
                            bookmark: widget.bookmark,
                          ),
                        ),
                      );
                    },
                    child: const Text("Buka sebagai Juz"),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        AppTheme.c!.accent,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PageScreen(
                            chapter: widget.chapter,
                            chapterId: widget.chapterId,
                            surah: widget.surah,
                            bookmark: widget.bookmark,
                          ),
                        ),
                      );
                    },
                    child: const Text("Buka sebagai Surat"),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.deepOrange,
                      ),
                    ),
                    onPressed: () {
                      BookmarkCubit bookmarkCubit =
                          BookmarkCubit.cubit(context);
                      bookmarkCubit.removeBookmark(widget.bookmark!);
                      Navigator.pop(context);
                    },
                    child: const Text("Hapus"),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.white,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Tutup",
                      style: TextStyle(color: AppTheme.c!.accent!),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
