part of '../bookmarks_screen.dart';

class BookmarkTile extends StatelessWidget {
  final Bookmark? bookmark;
  final int? index;
  const BookmarkTile({Key? key, this.bookmark, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final surah = Surah.fromNumber(context, bookmark!.surah!.hashCode);

    return WidgetAnimator(
      child: InkWell(
          onTap: () async {
            final juz = await Juz.fromIndex(context, bookmark!.juz!.hashCode);
            final juzId =
                await JuzId.fromIndex(context, bookmark!.juz!.hashCode);
            final chapter =
                await Chapter.fromIndex(context, bookmark!.surah!.hashCode - 1);
            final chapterId = await ChapterId.fromIndex(
                context, bookmark!.surah!.hashCode - 1);
            showDialog(
                context: context,
                builder: (_) => BookmarkInformation(
                      bookmark: bookmark,
                      surah: surah,
                      juz: juz,
                      juzId: juzId,
                      chapter: chapter,
                      chapterId: chapterId,
                    ));
          },
          child: ListTile(
            leading: Text(
              (index! + 1).toString(),
            ),
            title: Text(surah!.nama!),
            subtitle: Text('Qs. ' +
                surah.namaLatin! +
                ' (' +
                surah.nomor.toString() +
                ' : ' +
                bookmark!.numberInSurah.toString() +
                ')'),
            trailing: Text(bookmark!.terakhirDibaca! ? 'terakhir dibaca' : ''),
          )),
    );
  }
}
