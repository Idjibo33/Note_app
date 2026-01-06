import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:note/models/constants.dart';
import 'package:note/models/note_class.dart';
import 'package:note/providers.dart';
import 'package:provider/provider.dart';

class AjouterNote extends StatelessWidget {
  const AjouterNote({super.key});

  @override
  Widget build(BuildContext context) {
    final titreText = TextEditingController();
    final descriptionText = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ajouter une note", style: Styles.titreTexte),
          actions: [
            TextButton.icon(
              onPressed: () {
                final nouvelleNote = Note(
                  titre: titreText.text,
                  text: descriptionText.text,
                );
                context.read<NotesProvider>().ajouterNote(nouvelleNote);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Nouvelle note ajoutée",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Styles.primaryColor,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(FluentSystemIcons.ic_fluent_save_regular),
              label: Text("Enregistrer"),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  style: Styles.titreTexte,
                  minLines: 1,
                  maxLines: 3,
                  controller: titreText,
                  decoration: InputDecoration(
                    hintText: "Titre",
                    hintStyle: Styles.hintText,
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                const Divider(),
                SizedBox(
                  child: TextField(
                    style: Styles.corpsTexte,
                    minLines: 15,
                    maxLines: 20,
                    controller: descriptionText,
                    decoration: InputDecoration(
                      hintText: "Texte",
                      hintStyle: Styles.hintText,
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
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
