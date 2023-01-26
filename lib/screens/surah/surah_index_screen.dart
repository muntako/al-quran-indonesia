import 'package:al_quran/animations/bottom_animation.dart';
import 'package:al_quran/app_routes.dart';
import 'package:al_quran/configs/app.dart';
import 'package:al_quran/configs/configs.dart';
import 'package:al_quran/cubits/bookmarks/cubit.dart';
import 'package:al_quran/cubits/chapter/cubit.dart';
import 'package:al_quran/cubits/chapterId/cubit.dart';
import 'package:al_quran/cubits/surat/cubit.dart';
import 'package:al_quran/models/ayah/ayah.dart';
import 'package:al_quran/models/bookmark/bookmark.dart';
import 'package:al_quran/models/chapter/chapter.dart';
import 'package:al_quran/models/chapterId/chapterId.dart';
import 'package:al_quran/models/juz/juz.dart';
import 'package:al_quran/models/juzId/juzId.dart';
import 'package:al_quran/models/surah/surah.dart';
import 'package:al_quran/providers/app_provider.dart';
import 'package:al_quran/utils/assets.dart';
import 'package:al_quran/widgets/app/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:al_quran/widgets/flare.dart';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../widgets/form_input_range.dart';
part '../page/page_screen.dart';

part 'widgets/surah_tile.dart';
part 'widgets/surah_app_bar.dart';
part 'widgets/surah_information.dart';
part 'widgets/ayah_information.dart';
part 'widgets/surah_goto.dart';

class SurahIndexScreen extends StatefulWidget {
  const SurahIndexScreen({Key? key}) : super(key: key);

  @override
  State<SurahIndexScreen> createState() => _SurahIndexScreenState();
}

class _SurahIndexScreenState extends State<SurahIndexScreen> {
  List<Chapter?>? chapters = [];
  List<ChapterId?>? chapterIds = [];
  List<Surah?>? searchedChapters = [];
  List<Surah?>? surahs = [];

  @override
  void initState() {
    final surahCubit = SurahCubit.cubit(context);
    surahs = surahCubit.state.data;

    final chapterCubit = ChapterCubit.cubit(context);
    chapters = chapterCubit.state.data;
    final chapterIdCubit = ChapterIdCubit.cubit(context);
    chapterIds = chapterIdCubit.state.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);

    final appProvider = Provider.of<AppProvider>(context);
    final chapterCubit = ChapterCubit.cubit(context);
    final chapterIdCubit = ChapterIdCubit.cubit(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: appProvider.isDark ? Colors.grey[850] : Colors.white,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              // CustomImage(
              //   opacity: 0.3,
              //   height: height * 0.17,
              //   imagePath: StaticAssets.kaba,
              // ),
              // const AppBackButton(),
              // const CustomTitle(
              //   title: 'Surah Index',
              // ),
              const CustomAppBar(title: 'Surat'),
              if (chapters!.isEmpty)
                Center(
                  child: BlocBuilder<ChapterCubit, ChapterState>(
                    builder: (context, state) {
                      if (state is ChapterFetchLoading) {
                        return LinearProgressIndicator(
                          backgroundColor: AppTheme.c!.accent,
                          valueColor:
                              const AlwaysStoppedAnimation(Colors.white),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: AppDimensions.normalize(25),
                          ),
                          Space.y!,
                          Text(
                            'Something went wrong!',
                            style: AppText.h3b,
                          ),
                          Space.y1!,
                          SizedBox(
                            width: AppDimensions.normalize(70),
                            height: AppDimensions.normalize(17),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  AppTheme.c!.accent,
                                ),
                              ),
                              onPressed: () {
                                chapterCubit.fetch();
                                chapterIdCubit.fetch();
                              },
                              child: const Text('Retry'),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              if (chapters!.isNotEmpty)
                Container(
                  height: AppDimensions.normalize(20),
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.07,
                    left: AppDimensions.normalize(5),
                    right: AppDimensions.normalize(5),
                  ),
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          searchedChapters = [];
                        });
                      }
                      if (value.isNotEmpty) {
                        setState(() {
                          var lowerCaseQuery = value.toLowerCase();

                          searchedChapters = surahs!.where((surah) {
                            final chapterName = surah!.namaLatin!
                                .toLowerCase()
                                .contains(lowerCaseQuery);
                            return chapterName;
                          }).toList(growable: false)
                            ..sort(
                              (a, b) => a!.nama!
                                  .toLowerCase()
                                  .indexOf(lowerCaseQuery)
                                  .compareTo(
                                    b!.nama!
                                        .toLowerCase()
                                        .indexOf(lowerCaseQuery),
                                  ),
                            );
                        });
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: Space.h,
                      hintText: 'Cari Surat...',
                      hintStyle: AppText.b2!.copyWith(
                        color: AppTheme.c!.textSub2,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppTheme.c!.textSub2!,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.c!.textSub2!,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.c!.textSub2!,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              if (chapters!.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15,
                  ),
                  child: searchedChapters!.isNotEmpty
                      ? ListView.separated(
                          separatorBuilder: (context, index) => const Divider(
                            color: Color(0xff26c6da),
                          ),
                          itemCount: searchedChapters!.length,
                          itemBuilder: (context, index) {
                            final surah = searchedChapters![index];
                            final chapterId = chapterIds!
                                .where((chapterId) =>
                                    chapterId!.number == surah!.nomor)
                                .toList()[0];
                            return SurahTile(
                              surah: surah,
                              chapterId: chapterId,
                            );
                          },
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) => const Divider(
                            color: Color(0xff26c6da),
                          ),
                          itemCount: chapters!.length,
                          itemBuilder: (context, index) {
                            final surah = surahs![index];
                            final chapterId = chapterIds![index];
                            return SurahTile(
                              surah: surah,
                              chapterId: chapterId,
                            );
                          },
                        ),
                ),
              if (appProvider.isDark) ...[
                Flare(
                  color: const Color(0xfff9e9b8),
                  offset: Offset(width, -height),
                  bottom: -50,
                  flareDuration: const Duration(seconds: 17),
                  left: 100,
                  height: 60,
                  width: 60,
                ),
                Flare(
                  color: const Color(0xfff9e9b8),
                  offset: Offset(width, -height),
                  bottom: -50,
                  flareDuration: const Duration(seconds: 12),
                  left: 10,
                  height: 25,
                  width: 25,
                ),
                Flare(
                  color: const Color(0xfff9e9b8),
                  offset: Offset(width, -height),
                  bottom: -40,
                  left: -100,
                  flareDuration: const Duration(seconds: 18),
                  height: 50,
                  width: 50,
                ),
                Flare(
                  color: const Color(0xfff9e9b8),
                  offset: Offset(width, -height),
                  bottom: -50,
                  left: -80,
                  flareDuration: const Duration(seconds: 15),
                  height: 50,
                  width: 50,
                ),
                Flare(
                  color: const Color(0xfff9e9b8),
                  offset: Offset(width, -height),
                  bottom: -20,
                  left: -120,
                  flareDuration: const Duration(seconds: 12),
                  height: 40,
                  width: 40,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
