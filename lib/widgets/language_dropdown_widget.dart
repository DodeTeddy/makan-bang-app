import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class LanguageDropdownWidget extends StatelessWidget {
  final bool isOnPrimary;
  const LanguageDropdownWidget({
    super.key,
    this.isOnPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem(
        value: 'en',
        child: Text(
          'English',
          style: TextStyle(
            color: isOnPrimary
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      DropdownMenuItem(
        value: 'id',
        child: Text(
          'Indonesia',
          style: TextStyle(
            color: isOnPrimary
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    ];

    return Consumer<LanguageProvider>(
      builder: (context, _, __) {
        return DropdownButton(
          dropdownColor: isOnPrimary
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.primary,
          icon: Icon(
            Icons.language_rounded,
            color: isOnPrimary
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.primary,
          ),
          underline: const SizedBox(),
          items: items,
          onChanged: (locale) =>
              context.read<LanguageProvider>().changeLanguage(Locale(locale!)),
        );
      },
    );
  }
}
