import 'package:al_quran/animations/bottom_animation.dart';
import 'package:al_quran/configs/app.dart';
import 'package:al_quran/configs/app_theme.dart';
import 'package:al_quran/configs/app_typography.dart';
import 'package:al_quran/cubits/bookmarks/cubit.dart';
import 'package:al_quran/models/bookmark/bookmark.dart';
import 'package:al_quran/models/chapter/chapter.dart';
import 'package:al_quran/models/chapterId/chapterId.dart';
import 'package:al_quran/models/juz/juz.dart';
import 'package:al_quran/models/juzId/juzId.dart';
import 'package:al_quran/models/surah/surah.dart';
import 'package:al_quran/providers/app_provider.dart';
import 'package:al_quran/screens/bookmarks/bookmark_information.dart';
import 'package:al_quran/widgets/loader/loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

part 'widgets/bookmark_tile.dart';

// part 'widgets/bookmark_information.dart';
class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  void initState() {
    final bookmarkCubit = BookmarkCubit.cubit(context);
    bookmarkCubit.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final appProvider = Provider.of<AppProvider>(context);
    final bookmarkCubit = BookmarkCubit.cubit(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bookmarks',
          style: TextStyle(fontFamily: 'Poopins'),
        ),
        foregroundColor:
            appProvider.isDark ? Colors.white : AppTheme.c!.accentLight,
        backgroundColor: appProvider.isDark
            ? AppTheme.dark.background
            : AppTheme.light.accent,
      ),
      backgroundColor: appProvider.isDark ? Colors.grey[850] : Colors.white,
      body: SafeArea(
        child: BlocBuilder<BookmarkCubit, BookmarkState>(
          builder: (context, state) {
            if (state is BookmarkFetchLoading) {
              return const Center(
                child: LoadingShimmer(
                  text: 'Memuat data...',
                ),
              );
            } else if (state is BookmarkFetchSuccess && state.data!.isEmpty) {
              return Center(
                child: Text(
                  'Belum ada bookmark!',
                  style: AppText.b1b!.copyWith(
                    color: AppTheme.c!.text,
                  ),
                ),
              );
            } else if (state is BookmarkFetchSuccess) {
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Color(0xff26c6da),
                ),
                itemCount: bookmarkCubit.state.data!.length,
                itemBuilder: (context, index) {
                  final bookmark = bookmarkCubit.state.data![index];
                  return BookmarkTile(
                    index: index,
                    bookmark: bookmark,
                  );
                },
              );
            }
            return Center(
              child: Text(
                '',
                style: AppText.b1b!.copyWith(
                  color: AppTheme.c!.text,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
