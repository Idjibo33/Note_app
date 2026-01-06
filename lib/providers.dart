//les providers
import 'package:flutter/material.dart';
import 'package:note/data/database_helper.dart';
import 'package:note/models/note_class.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

//le provider de theme
class StyleTheme extends ChangeNotifier {
  bool isLightMode = true;
  static const key = "themeKey";

  StyleTheme(this.isLightMode);

  //charger le thème
  Future<void> chargerTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLightMode = prefs.getBool(key)!;
    notifyListeners();
  }

  //changer le theme
  Future<void> changerTheme() async {
    isLightMode = !isLightMode;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, isLightMode);
    notifyListeners();
  }
}

//le provider de Note
class NotesProvider extends ChangeNotifier {
  List<Note> notes = [];

  //charger les notes
  Future chargerNote() async {
    notes = await AppDatabase.instance.lireNotes();
    notifyListeners();
  }

  //Ajouter la note
  Future ajouterNote(Note note) async {
    await AppDatabase.instance.ajouterNote(note);
    await chargerNote();
    notifyListeners();
  }

  //Mettre à jour la
  Future misAJourNote(Note note) async {
    await AppDatabase.instance.misAJourNote(note);
    chargerNote();
    notifyListeners();
  }

  //Supprimer la note
  Future supprimerNote(int id) async {
    await AppDatabase.instance.supprimerNote(id);
    await chargerNote();
    notifyListeners();
  }
}
