part of '../surah/surah_index_screen.dart';

class PageScreen extends StatefulWidget {
  final JuzId? juzId;
  final Juz? juz;
  final Chapter? chapter;
  final ChapterId? chapterId;
  const PageScreen({
    Key? key,
    this.chapter,
    this.juz,
    this.juzId,
    this.chapterId,
  }) : super(key: key);

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  @override
  void initState() {
    final bookmarkCubit = BookmarkCubit.cubit(context);
    if (widget.chapter != null) {
      bookmarkCubit.checkBookmarked(widget.chapter!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final appProvider = Provider.of<AppProvider>(context);
    final bookmarkCubit = BookmarkCubit.cubit(context);

    final arabicNumber = ArabicNumbers();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appProvider.isDark ? Colors.grey[900] : Colors.white,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              actions: [
                if (widget.juz == null)
                  BlocBuilder<BookmarkCubit, BookmarkState>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          if (bookmarkCubit.state.isBookmarked!) {
                            bookmarkCubit.updateBookmark(
                                widget.chapter!, false);
                          } else {
                            bookmarkCubit.updateBookmark(widget.chapter!, true);
                          }
                        },
                        icon: Icon(
                          bookmarkCubit.state.isBookmarked!
                              ? Icons.bookmark_added
                              : Icons.bookmark_add_outlined,
                          color: appProvider.isDark
                              ? Colors.white
                              : Colors.black54,
                        ),
                      );
                    },
                  ),
              ],
              leading: BackButton(
                color: appProvider.isDark ? Colors.white : Colors.black54,
              ),
              backgroundColor:
                  appProvider.isDark ? Colors.grey[850] : Colors.white,
              pinned: true,
              floating: true,
              expandedHeight: height * 0.27,
              flexibleSpace: _SurahAppBar(
                data: widget.chapter ??
                    Chapter(
                      englishName: 'Juz No. ${widget.juz!.number}',
                      englishNameTranslation:
                          'بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
                      name: JuzUtils.juzNames[(widget.juz!.number! - 1)],
                    ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final verse = widget.chapter == null
                      ? widget.juz!.ayahs![index]
                      : widget.chapter!.ayahs![index];

                  final translate =
                      widget.chapterId == null && widget.juzId != null
                          ? widget.juzId!.ayahs![index]
                          : (widget.chapterId != null
                              ? widget.chapterId!.ayahs![index]
                              : null);
                  final numberOfAyah =
                      widget.chapter == null && verse!.numberInSurah != null
                          ? verse.numberInSurah
                          : (index + 1);
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                      width * 0.01,
                      0,
                      width * 0.01,
                      0,
                    ),
                    child: WidgetAnimator(
                      child: GestureDetector(
                        onLongPress: () => showDialog(
                          context: context,
                          builder: (context) => _AyahInformation(
                            ayah: widget.chapter == null
                                ? widget.juz!.ayahs![index]
                                : widget.chapter!.ayahs![index],
                          ),
                        ),
                        child: ListTile(
                          tileColor: index % 2 == 0
                              ? (appProvider.isDark
                                  ? const Color(0xff616161)
                                  : const Color(0xffb2ebf2))
                              : (appProvider.isDark
                                  ? const Color(0xff424242)
                                  : const Color(0xffe0f7fa)),
                          contentPadding: Space.h,
                          trailing: CircleAvatar(
                            radius: AppDimensions.normalize(4.2),
                            backgroundColor: const Color(0xff04364f),
                            child: CircleAvatar(
                              radius: AppDimensions.normalize(3.5),
                              backgroundColor: Colors.white,
                              child: Text(
                                arabicNumber.convert(numberOfAyah),
                                style: AppText.l1b!.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            verse!.text!,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'Noor',
                              fontSize: height * 0.0270,
                            ),
                          ),
                          subtitle: Text(
                            translate == null ? '' : translate.text!,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: height * 0.0175,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: widget.chapter == null
                    ? widget.juz!.ayahs!.length
                    : widget.chapter!.ayahs!.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
