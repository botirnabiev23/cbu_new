import 'package:cbu/pages/currency_page.dart';
import 'package:cbu/pages/maps_page.dart';
import 'package:cbu/pages/news_page.dart';
import 'package:cbu/pages/settings_page.dart';
import 'package:cbu/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class HomePageCB extends StatefulWidget {
  const HomePageCB({super.key});

  @override
  State<HomePageCB> createState() => _HomePageCBState();
}

class _HomePageCBState extends State<HomePageCB> {
  int _currentIndex = 0;

  List<Widget> body = const [
    CurrencyPage(),
    NewsPage(),
    MapsPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    List<String> appBar = [
      AppLocalizations.of(context)!.currency,
      AppLocalizations.of(context)!.news,
      AppLocalizations.of(context)!.maps,
      AppLocalizations.of(context)!.settings,
    ];

    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey.shade400,
        showUnselectedLabels: true,
        unselectedIconTheme: IconThemeData(color: Colors.grey.shade400),
        selectedIconTheme: IconThemeData(color: Colors.yellow.shade700),
        selectedItemColor: Colors.yellow.shade700,
        type: BottomNavigationBarType.fixed,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.arrow_upward,
            ),
            label: AppLocalizations.of(context)!.currency,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.newspaper,
            ),
            label: AppLocalizations.of(context)!.news,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.map,
            ),
            label: AppLocalizations.of(context)!.maps,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.settings,
            ),
            label: AppLocalizations.of(context)!.settings,
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(
          appBar[_currentIndex],
          style: TextStyle(color: isDarkMode ? Colors.black : Colors.white),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.yellow.shade700,
      ),
      body: body[_currentIndex],
    );
  }
}
