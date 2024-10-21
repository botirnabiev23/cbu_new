import 'package:cbu/providers/lang_provider.dart';
import 'package:cbu/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String selectedOption = 'Русский';

  @override
  void initState() {
    super.initState();
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final currentLocale = localeProvider.locale;
    if (currentLocale != null) {
      setState(() {
        selectedOption = _getLanguageName(currentLocale.languageCode);
      });
    }
  }

  String _getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'uz':
        return 'O\'zbekcha';
      case 'ru':
        return 'Русский';
      case 'en':
        return 'English';
      default:
        return 'Русский';
    }
  }

  void openRadioList() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RadioListTile<String>(
                  title: const Text('O\'zbekcha'),
                  value: 'O\'zbekcha',
                  groupValue: selectedOption,
                  onChanged: (String? value) {
                    setModalState(() {
                      selectedOption = value!;
                    });
                    setState(() {
                      selectedOption = value!;
                      _changeLanguage('uz');
                    });
                    Navigator.pop(context);
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Русский'),
                  value: 'Русский',
                  groupValue: selectedOption,
                  onChanged: (String? value) {
                    setModalState(() {
                      selectedOption = value!;
                    });
                    setState(() {
                      selectedOption = value!;
                      _changeLanguage('ru');
                    });
                    Navigator.pop(context);
                  },
                ),
                RadioListTile<String>(
                  title: const Text('English'),
                  value: 'English',
                  groupValue: selectedOption,
                  onChanged: (String? value) {
                    setModalState(() {
                      selectedOption = value!;
                    });
                    setState(() {
                      selectedOption = value!;
                      _changeLanguage('en');
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _changeLanguage(String languageCode) {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    provider.setLocale(Locale(languageCode));
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return ListView(
      children: [
        Column(
          children: [
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.system_settings,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              titleTextStyle: const TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.language),
              subtitle: Text(
                selectedOption,
              ),
              onTap: openRadioList,
              leading: const Icon(Icons.language),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.theme),
              subtitle: Text(
                isDarkMode
                    ? AppLocalizations.of(context)!.dark_theme
                    : AppLocalizations.of(context)!.light_theme,
              ),
              leading: isDarkMode
                  ? const Icon(Icons.brightness_2_outlined)
                  : const Icon(Icons.brightness_4_outlined),
              trailing: Switch(
                activeColor: Colors.green,
                value: isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },
              ),
            ),
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.other,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              titleTextStyle: const TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.support),
              onTap: () {},
              leading: const Icon(Icons.mail),
            ),
          ],
        ),
      ],
    );
  }
}
