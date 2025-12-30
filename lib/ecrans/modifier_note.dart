import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:note/models/constants.dart';
import 'package:note/models/note.dart';
import 'package:note/models/providers.dart';
import 'package:provider/provider.dart';

class ModifierNote extends StatelessWidget {
  final int id;
  final String titre;
  final String texte;

  const ModifierNote(this.titre, this.texte, {super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titreText = TextEditingController(text: titre);
    final TextEditingController descriptionText = TextEditingController(
      text: texte,
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Modifier la note", style: Styles.titreTexte),
          actions: [
            TextButton.icon(
              onPressed: () {
                context.read<NotesProvider>().misAJourNote(
                  Note(
                    id: id,
                    titre: titreText.text,
                    text: descriptionText.text,
                  ),
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "la note a été modifié avec succès",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Styles.primaryColor,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: Icon(FluentSystemIcons.ic_fluent_save_as_regular),
              label: Text("enregistrer"),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  minLines: 1,
                  maxLines: 3,
                  style: Styles.titreTexte,
                  controller: titreText,
                  decoration: InputDecoration(
                    label: Text("Titre"),
                    hintStyle: Styles.hintText,
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                TextField(
                  style: Styles.corpsTexte,
                  minLines: 5,
                  maxLines: 15,
                  controller: descriptionText,
                  decoration: InputDecoration(
                    label: Text("Texte"),
                    hintStyle: Styles.hintText,
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
