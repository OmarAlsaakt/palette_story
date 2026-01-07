import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/color_palette.dart';
import 'models/wardrobe_item.dart';
import 'models/app_settings.dart';
import 'providers/palette_provider.dart';
import 'providers/wardrobe_provider.dart';
import 'providers/settings_provider.dart';
import 'screens/home_screen.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters (you'll need to generate these with build_runner)
  Hive.registerAdapter(ColorPaletteAdapter());
  Hive.registerAdapter(WardrobeItemAdapter());

  // Open boxes
  await Hive.openBox<ColorPalette>('palettes');
  await Hive.openBox<WardrobeItem>('wardrobe');

  // Load app settings
  final settings = await AppSettings.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => PaletteProvider()..loadPalettes()),
        ChangeNotifierProvider(create: (_) => WardrobeProvider()..loadItems()),
        ChangeNotifierProvider(create: (_) => SettingsProvider(settings)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: settingsProvider.themeMode,
      home: const HomeScreen(),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppConstants.primaryPurple,
        secondary: AppConstants.secondaryPink,
        surface: Colors.white,
        background: AppConstants.backgroundLight,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 6,
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppConstants.primaryPurple,
        secondary: AppConstants.secondaryPink,
        surface: const Color(0xFF2E2E3A),
        background: AppConstants.backgroundDark,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
