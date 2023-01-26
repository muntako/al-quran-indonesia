part of '../home_screen.dart';

class _MainScreen extends StatefulWidget {
  const _MainScreen({Key? key}) : super(key: key);

  @override
  State<_MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<_MainScreen> {
  @override
  initState() {
    _next();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final appProvider = Provider.of<AppProvider>(context);
    final bookmarkCubit = BookmarkCubit.cubit(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      color: appProvider.isDark ? Colors.grey[850] : Colors.white,
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Space.y1!,
                  Space.y2!,
                  const Calligraphy(),
                  Space.y1!,
                  AppButton(
                    title: 'Surat',
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.surah),
                  ),
                  Space.y1!,
                  AppButton(
                    title: 'Juz',
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.juz),
                  ),
                  Space.y1!,
                  AppButton(
                    title: 'Bookmark',
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.bookmarks),
                  ),
                  Space.y1!,
                  Center(
                    child: BlocBuilder<BookmarkCubit, BookmarkState>(
                        builder: (context, state) {
                      if (state is BookmarkFetchSuccess &&
                          state.data!.isNotEmpty) {
                        final bookmark = bookmarkCubit.state.data;
                        return AppButton(
                          title: 'Terakhir Dibaca',
                          onPressed: () async {
                            final juz = await Juz.fromIndex(
                                context, bookmark!.first!.juz!.hashCode);
                            final juzId = await JuzId.fromIndex(
                                context, bookmark.first!.juz!.hashCode);
                            final chapter = await Chapter.fromIndex(
                                context, bookmark.first!.surah!.hashCode - 1);
                            final chapterId = await ChapterId.fromIndex(
                                context, bookmark.first!.surah!.hashCode - 1);
                            final surah = Surah.fromNumber(
                                context, chapter!.number.hashCode);
                            showDialog(
                                context: context,
                                builder: (_) => BookmarkInformation(
                                      bookmark: bookmark.first!,
                                      surah: surah,
                                      juz: juz,
                                      juzId: juzId,
                                      chapter: chapter,
                                      chapterId: chapterId,
                                    ));
                          },
                        );
                      }
                      return const Text('');
                    }),
                  ),
                ],
              ),
            ),
            const _AyahBottom(),
          ],
        ),
      ),
    );
  }

  Future<void> _next() async {
    final bookmarkCubit = BookmarkCubit.cubit(context);
    await bookmarkCubit.fetch(lastRead: true);
  }

  getMenu() {
    return <Widget>[];
  }
}
