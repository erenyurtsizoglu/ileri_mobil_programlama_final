import 'package:filmler/screens/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'language_notifier.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final languageNotifier = Provider.of<LanguageNotifier>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 280,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green[800],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                Text(
                  languageNotifier.isEnglish ? 'Menu' : 'Menü',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(languageNotifier.isEnglish ? 'Home Page' : 'Ana Sayfa'),
            onTap: () {
              context.go('/films');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(languageNotifier.isEnglish ? 'Directors' : 'Yönetmenler'),
            onTap: () {
              context.go('/directors');
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text(languageNotifier.isEnglish ? 'Share Movie' : 'Film Paylaş'),
            onTap: () {
              context.go('/myfilms');
            },
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Text(languageNotifier.isEnglish ? 'Dark Mode:' : 'Karanlık Mod:'),
                Spacer(),
                Switch(
                  value: themeNotifier.isDarkMode,
                  onChanged: (value) {
                    themeNotifier.toggleTheme();
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Text(languageNotifier.isEnglish ? 'English' : 'İngilizce'),
                Spacer(),
                Switch(
                  value: languageNotifier.isEnglish,
                  onChanged: (value) {
                    languageNotifier.toggleLanguage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
