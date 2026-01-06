import 'package:flutter/material.dart';
import 'package:note/ecrans/accueil.dart';
import 'package:note/models/constants.dart';
import 'package:note/data/database_helper.dart';
import 'package:note/providers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // 1. Interagir avec le code natif (SQLite) avant runApp
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final monTheme = prefs.getBool("themeKey");

  // 2. Initialisez la base de données
  await AppDatabase.instance.database;
  runApp(
    //Définir les providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StyleTheme(monTheme!)),
        //Charger les notes présentes dans la base de données présentes dans la base de donnée
        ChangeNotifierProvider(
          create: (context) => NotesProvider()..chargerNote(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //accéder au provider de style de thème
    final monTheme = context.watch<StyleTheme>().isLightMode;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Styles.primaryColor,
          brightness: monTheme ? Brightness.light : Brightness.dark,
        ),
      ),
      home: const Accueil(),
    );
  }
}
