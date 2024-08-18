import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makan_bang_app/screens/home_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'constants/colors.dart';
import 'providers/category_provider.dart';
import 'providers/language_provider.dart';
import 'providers/menu_provider.dart';
import 'providers/search_provider.dart';
import 'screens/get_started_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ProxyProvider2<SearchProvider, CategoryProvider, MenuProvider>(
          update: (_, searchProvider, categoryProvider, __) {
            return MenuProvider(
              searchProvider: searchProvider,
              categoryProvider: categoryProvider,
            );
          },
        ),
      ],
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return Consumer<LanguageProvider>(
            builder: (_, languageProvider, __) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Makan Bang App',
                locale: languageProvider.locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                theme: ThemeData(
                  colorScheme: const ColorScheme(
                    brightness: Brightness.light,
                    primary: primary,
                    onPrimary: onPrimary,
                    secondary: secondary,
                    onSecondary: onSecondary,
                    error: error,
                    onError: onError,
                    surface: surface,
                    onSurface: onSurface,
                  ),
                  textTheme: TextTheme(
                    bodyLarge: GoogleFonts.notoSerifTibetan(),
                    bodyMedium: GoogleFonts.notoSerifTibetan(),
                    bodySmall: GoogleFonts.poppins(),
                  ),
                  useMaterial3: true,
                ),
                initialRoute: '/',
                routes: {
                  '/': (context) => const GetStartedScreen(),
                  '/home': (context) => const HomeScreen(),
                },
              );
            },
          );
        },
      ),
    );
  }
}
