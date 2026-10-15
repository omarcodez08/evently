import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/start/widgets/language_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        "Welcome Back ✨",
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(fontSize: 14),
                      ),
                      Text(
                        "John Safwat",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (themeProvider.themeMode == ThemeMode.dark) {
                          themeProvider.changeTheme(ThemeMode.light);
                        } else {
                          themeProvider.changeTheme(ThemeMode.dark);
                        }
                      },
                      child: SvgPicture.asset(
                        themeProvider.themeMode == ThemeMode.dark
                            ? AssetsManager.moon
                            : AssetsManager.sun,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    LanguageSwitch(
                      title: "EN",
                      languageCode: "en",
                      selectedLanguage: "en",
                      width: 32,
                      height: 32,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
