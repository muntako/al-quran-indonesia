part of '../surah_index_screen.dart';

class _SurahAppBar extends StatelessWidget {
  final Surah? data;
  const _SurahAppBar({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      centerTitle: true,
      title: Text(
        data!.namaLatin!,
        style: AppText.b2b,
      ),
      background: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                StaticAssets.quranRail,
                height: AppDimensions.normalize(60),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  data!.nama!,
                  style: AppText.h1b!.copyWith(
                    fontFamily: 'Noor',
                    height: 1.5,
                  ),
                ),
                Space.y1!,
                Text(
                  data!.arti == null ? data!.nama! : data!.arti!,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
