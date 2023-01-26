part of '../surah_index_screen.dart';

class _SurahInformation extends StatefulWidget {
  final Surah? chapterData;
  const _SurahInformation({
    Key? key,
    this.chapterData,
  }) : super(key: key);

  @override
  _SurahInformationState createState() => _SurahInformationState();
}

class _SurahInformationState extends State<_SurahInformation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

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
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
              width: width * 0.8,
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
                    child: Text(
                      'Informasi Surat',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.03,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.chapterData!.namaLatin!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        widget.chapterData!.nama!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  Text("Jumlah Ayat: ${widget.chapterData!.jumlahAyat}"),
                  Text("Nomor Surat: ${widget.chapterData!.nomor!}"),
                  Text("Tempat Turun: ${widget.chapterData!.tempatTurun!}"),
                  Text("Arti: ${widget.chapterData!.arti!}"),
                  const Text("Deskripsi:"),
                  Html(
                    data: widget.chapterData!.deskripsi,
                    shrinkWrap: false,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
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
        ),
      ),
    );
  }
}
