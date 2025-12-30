import 'package:flutter/material.dart';
import 'package:note/ecrans/accueil.dart';
import 'package:note/models/constants.dart';
import 'package:note/models/database_helper.dart';
import 'package:note/models/providers.dart';
import 'package:provider/provider.dart';

void main() async {
  // 1. Interagir avec le code natif (SQLite) avant runApp
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialisez la base de données
  await AppDatabase.instance.database;
  runApp(
    //Définir les providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StyleTheme()),
        ChangeNotifierProvider(create: (context) => NotesProvider()),

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
