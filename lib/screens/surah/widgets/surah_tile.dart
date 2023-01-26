part of '../surah_index_screen.dart';

class SurahTile extends StatelessWidget {
  final Surah? surah;
  final ChapterId? chapterId;
  const SurahTile({Key? key, this.surah, this.chapterId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChapterCubit chapterCubit = ChapterCubit.cubit(context);
    List<Chapter?>? chapters = chapterCubit.state.data;
    return WidgetAnimator(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PageScreen(
                chapter: chapters!
                    .where((chapter) => chapter?.number == surah!.nomor)
                    .toList()[0],
                surah: surah,
                chapterId: chapterId,
              ),
            ),
          );
        },
        onLongPress: () => showDialog(
          context: context,
          builder: (context) => _SurahInformation(
            chapterData: surah,
          ),
        ),
        child: Padding(
          padding: Space.all(1, 0.2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(surah!.nomor!.toString()),
              Space.x1!,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah!.namaLatin!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    surah!.arti!,
                    style: AppText.b2,
                  )
                ],
              ),
              Expanded(
                child: Text(
                  surah!.nama!,
                  style: const TextStyle(
                    fontFamily: "Noor",
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
