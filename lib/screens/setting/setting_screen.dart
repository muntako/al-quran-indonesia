import 'package:al_quran/configs/app.dart';
import 'package:al_quran/configs/app_theme.dart';
import 'package:al_quran/providers/app_provider.dart';
import 'package:al_quran/widgets/app/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

part "widgets/font_settings.dart";

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: appProvider.isDark ? Colors.grey[850] : Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            const CustomAppBar(title: 'Pengaturan'),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.07,
              ),
              child: SettingsList(
                sections: [
                  SettingsSection(
                    title: const Text(''),
                    tiles: [
                      SettingsTile(
                        title: const Text('Tampilan'),
                        onPressed: (BuildContext context) {},
                      ),
                      SettingsTile.switchTile(
                        title: const Text('Mode gelap'),
                        leading: const Icon(Icons.phone_android),
                        onToggle: (value) {
                          if (value) {
                            appProvider.setTheme(ThemeMode.dark);
                          } else {
                            appProvider.setTheme(ThemeMode.light);
                          }
                        },
                        initialValue: appProvider.isDark,
                      ),
                      SettingsTile.navigation(
                        title: const Text('Ukuran huruf'),
                        leading: const Icon(Icons.font_download),
                        onPressed: (context) => showDialog(
                          context: context,
                          builder: (context) => _FontSizeSetting(
                            ayahSize: appProvider.ayahFontSize,
                            artiSize: appProvider.artiFontSize,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
