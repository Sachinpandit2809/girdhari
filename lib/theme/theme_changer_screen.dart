import "package:flutter/material.dart";
import "package:girdhari/resource/k_text_style.dart";
import "package:girdhari/theme/theme_controller.dart";
import "package:provider/provider.dart";

class ThemeChangerScreen extends StatefulWidget {
  const ThemeChangerScreen({super.key});

  @override
  State<ThemeChangerScreen> createState() => _ThemeChangerScreenState();
}

class _ThemeChangerScreenState extends State<ThemeChangerScreen> {
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChangerprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Theme",
          style: KTextStyle.K_20,
        ),
      ),
      body: Column(
        children: [
          Center(
              child: Text(
            "Theme Mode",
            style: KTextStyle.K_16,
          )),
          SizedBox(
            height: 30,
          ),
          RadioListTile<ThemeMode>(
              title: Text(
                "light Mode",
                style: KTextStyle.K_16,
              ),
              value: ThemeMode.light,
              groupValue: themeChanger.themeMode,
              onChanged: themeChanger.setTheme),
          RadioListTile<ThemeMode>(
              title: Text(
                "dark mode",
                style: KTextStyle.K_16,
              ),
              value: ThemeMode.dark,
              groupValue: themeChanger.themeMode,
              onChanged: themeChanger.setTheme),
          RadioListTile<ThemeMode>(
              title: Text(
                "system mode",
                style: KTextStyle.K_16,
              ),
              value: ThemeMode.system,
              groupValue: themeChanger.themeMode,
              onChanged: themeChanger.setTheme),
        ],
      ),
    );
  }
}
