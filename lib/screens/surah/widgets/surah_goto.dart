part of '../surah_index_screen.dart';

class _SurahGoToNumber extends StatefulWidget {
  final Chapter? chapterData;
  final ItemScrollController? scrollController;
  const _SurahGoToNumber({
    Key? key,
    this.chapterData,
    this.scrollController,
  }) : super(key: key);

  @override
  _SurahGoToNumberState createState() => _SurahGoToNumberState();
}

class _SurahGoToNumberState extends State<_SurahGoToNumber>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  int _searchedNumber = -1;
  int indexTile = -1;

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
            height: height * 0.17,
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
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    NumericalRangeFormatter(
                        min: 1,
                        max: widget.chapterData!.ayahs!.length.toDouble()),
                  ],
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        _searchedNumber = -1;
                      });
                    }
                    if (value.isNotEmpty) {
                      _searchedNumber = int.parse(value);
                      if (_searchedNumber <=
                              widget.chapterData!.ayahs!.length &&
                          _searchedNumber >= 0) {
                        setState(() {
                          indexTile = _searchedNumber;
                        });
                      } else {}
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: Space.h,
                    hintText: '[ 1 - ' +
                        widget.chapterData!.ayahs!.length.toString() +
                        ' ]',
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
                      if (indexTile > -1) {
                        _PageScreenState.scrollTo(indexTile - 1);
                      }
                    },
                    child: const Text("OK"),
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
