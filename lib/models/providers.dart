//les providers
import 'package:flutter/material.dart';
import 'package:note/models/database_helper.dart';
import 'package:note/models/note.dart';

//le provider de theme
class StyleTheme extends ChangeNotifier {
  bool isLightMode = true;

  //changer le theme
  void changerTheme() {
    isLightMode = !isLightMode;
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
