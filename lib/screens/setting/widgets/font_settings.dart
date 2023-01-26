part of '../setting_screen.dart';

class _FontSizeSetting extends StatefulWidget {
  final double? ayahSize;
  final double? artiSize;
  const _FontSizeSetting({
    Key? key,
    this.ayahSize,
    this.artiSize,
  }) : super(key: key);

  @override
  _FontSizeSettingState createState() => _FontSizeSettingState();
}

class _FontSizeSettingState extends State<_FontSizeSetting>
    with SingleTickerProviderStateMixin {
  // late AnimationController controller;
  // late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    // controller = AnimationController(
    //     vsync: this, duration: const Duration(milliseconds: 500));
    // scaleAnimation =
    //     CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    // controller.addListener(() {
    //   setState(() {});
    // });

    // controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // controller = AnimationController(
    //     vsync: this, duration: const Duration(milliseconds: 500));
    // scaleAnimation =
    //     CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    List<double> fontSizes = [12, 15, 18, 20, 23, 25, 28, 30];
    return Center(
      child: Material(
        // color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
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
                child: Column(
                  children: [
                    Text(
                      'بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
                      style: TextStyle(
                        fontSize: widget.ayahSize,
                      ),
                    ),
                    Text(
                      'Dengan menyebut nama Allah Yang Maha Pengasih lagi Maha Penyayang',
                      style: TextStyle(
                        fontSize: widget.artiSize,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text("Ayat"),
                  DropdownButton(
                    value: widget.ayahSize,
                    items:
                        fontSizes.map<DropdownMenuItem<double>>((double value) {
                      return DropdownMenuItem<double>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (double? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        appProvider.setAyahFontSize(value!);
                      });
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text("Terjemah"),
                  DropdownButton(
                    value: widget.artiSize,
                    items:
                        fontSizes.map<DropdownMenuItem<double>>((double value) {
                      return DropdownMenuItem<double>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (double? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        appProvider.setArtiFontSize(value!);
                      });
                    },
                  )
                ],
              ),
              // SizedBox(
              //   height: height * 0.02,
              // ),
              SizedBox(
                height: height * 0.05,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      AppTheme.c!.accent,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
