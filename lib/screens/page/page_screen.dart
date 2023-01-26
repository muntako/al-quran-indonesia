part of '../surah/surah_index_screen.dart';

class PageScreen extends StatefulWidget {
  final JuzId? juzId;
  final Juz? juz;
  final Chapter? chapter;
  final Surah? surah;
  final ChapterId? chapterId;
  final Bookmark? bookmark;
  const PageScreen({
    Key? key,
    this.chapter,
    this.surah,
    this.juz,
    this.juzId,
    this.chapterId,
    this.bookmark,
  }) : super(key: key);

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  // final dataKey = new GlobalKey();
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      //write or call your logic
      //code will run when widget rendering complete
      if (widget.bookmark != null) {
        final indexTile = widget.chapter == null
            ? widget.juz!.ayahs!.indexWhere(
                (element) => element!.number! == widget.bookmark!.number!)
            : widget.bookmark!.numberInSurah! - 1;
        _PageScreenState.scrollTo(indexTile.hashCode);
      }
    });
    super.initState();
  }

  static final ItemScrollController _itemScrollController =
      ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final appProvider = Provider.of<AppProvider>(context);
    final bookmarkCubit = BookmarkCubit.cubit(context);

    final arabicNumber = ArabicNumbers();
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.chapter == null
              ? "Juz " + widget.juz!.number!.toString()
              : widget.surah!.namaLatin!,
          style: const TextStyle(fontFamily: 'Poopins'),
        ),
        foregroundColor:
            appProvider.isDark ? Colors.white : AppTheme.c!.accentLight,
        backgroundColor: appProvider.isDark
            ? AppTheme.dark.background
            : AppTheme.light.accent,
        actions: [
          if (widget.surah != null)
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => _SurahGoToNumber(
                  chapterData: widget.chapter,
                  scrollController: _itemScrollController,
                ),
              ),
              icon: Icon(
                Icons.manage_search,
                color:
                    appProvider.isDark ? Colors.white : AppTheme.c!.accentLight,
              ),
            ),
          IconButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.bookmarks),
            icon: Icon(
              Icons.bookmark,
              color:
                  appProvider.isDark ? Colors.white : AppTheme.c!.accentLight,
            ),
            tooltip: 'Bookmark',
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.setting),
            icon: Icon(
              Icons.settings,
              color:
                  appProvider.isDark ? Colors.white : AppTheme.c!.accentLight,
            ),
            tooltip: 'Pengaturan',
          )
        ],
      ),
      backgroundColor: appProvider.isDark ? Colors.grey[900] : Colors.white,
      body: SafeArea(
        // top: false,
        child: ScrollablePositionedList.builder(
          initialScrollIndex: 0,
          itemScrollController: _itemScrollController,
          itemPositionsListener: itemPositionsListener,
          itemCount: widget.surah == null
              ? widget.juz!.ayahs!.length
              : widget.chapter!.ayahs!.length,
          itemBuilder: (context, index) {
            final verse = widget.chapter == null
                ? widget.juz!.ayahs![index < 0 ? 0 : index]
                : widget.chapter!.ayahs![index < 0 ? 0 : index];

            final translate = widget.chapterId == null && widget.juzId != null
                ? widget.juzId!.ayahs![index]
                : (widget.chapterId != null
                    ? widget.chapterId!.ayahs![index < 0 ? 0 : index]
                    : null);
            final numberOfAyah =
                widget.chapter == null && verse!.numberInSurah != null
                    ? verse.numberInSurah
                    : (index + 1);
            return Padding(
              padding: EdgeInsets.fromLTRB(
                width * 0.001,
                0,
                width * 0.001,
                0,
              ),
              child: WidgetAnimator(
                child: ListTile(
                  tileColor: index % 2 == 0
                      ? (appProvider.isDark
                          ? const Color(0xff616161)
                          : const Color(0xffb2ebf2))
                      : (appProvider.isDark
                          ? const Color(0xff424242)
                          : const Color(0xffe0f7fa)),
                  contentPadding: Space.h,
                  minLeadingWidth: 0.5,
                  leading: CircleAvatar(
                    radius: AppDimensions.normalize(4),
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
                    textWidthBasis: TextWidthBasis.longestLine,
                    style: TextStyle(
                      fontFamily: 'Noor',
                      fontSize: appProvider.ayahFontSize,
                    ),
                  ),
                  subtitle: Text(
                    translate == null ? '' : translate.text!,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: appProvider.artiFontSize,
                    ),
                  ),
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => _AyahInformation(
                      ayah: widget.chapter == null
                          ? widget.juz!.ayahs![index]
                          : widget.chapter!.ayahs![index],
                      bookmarkCubit: bookmarkCubit,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static void scrollTo(int index) {
    if (_itemScrollController.isAttached) {
      _itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void jumpTo(int index) {
    if (_itemScrollController.isAttached) {
      _itemScrollController.jumpTo(index: index);
    }
  }
}
