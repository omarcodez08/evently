import 'package:flutter/material.dart';

class LanguageSwitch extends StatelessWidget {
  final String title;
  final String languageCode;
  final String selectedLanguage;
  const LanguageSwitch({
    super.key,
    required this.title,
    required this.languageCode,
    required this.selectedLanguage
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: languageCode == selectedLanguage
            ?Theme.of(context).colorScheme.primary
            :Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      onPressed: () {},
      child: Text(title, style: languageCode == selectedLanguage
          ?Theme.of(context).textTheme.labelMedium
          :Theme.of(context).textTheme.labelSmall),
    );
  }
}