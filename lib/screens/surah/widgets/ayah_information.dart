part of '../surah_index_screen.dart';

class _AyahInformation extends StatefulWidget {
  final Ayah? ayah;
  final BookmarkCubit? bookmarkCubit;
  const _AyahInformation({Key? key, this.ayah, this.bookmarkCubit})
      : super(key: key);

  @override
  _AyahInformationState createState() => _AyahInformationState();
}

class _AyahInformationState extends State<_AyahInformation>
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
    final bookmark = Bookmark.fromMap(widget.ayah!.toMap());

    final surah = Surah.fromNumber(context, widget.ayah!.surah!);
    return ScaleTransition(
      scale: scaleAnimation,
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
                Center(
                  child: Text(
                    'Informasi Ayat',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: height * 0.03,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      surah == null ? '' : surah.namaLatin!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      surah == null ? '' : surah.nama!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                Text("Nomor urut pada surat: ${widget.ayah!.numberInSurah}"),
                Text("turun di ${surah!.tempatTurun!}"),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: height * 0.05,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        AppTheme.c!.accent,
                      ),
                    ),
                    onPressed: () async {
                      await widget.bookmarkCubit?.updateBookmark(
                        bookmark: bookmark,
                      );
                      Navigator.pop(context);
                    },
                    child: const Text("Bookmark"),
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
                    onPressed: () async {
                      await widget.bookmarkCubit
                          ?.updateBookmark(bookmark: bookmark, lastRead: true);
                      Navigator.pop(context);
                    },
                    child: const Text("Terakhir dibaca"),
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
