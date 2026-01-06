//Le widget d'affichage d'une note
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:note/ecrans/modifier_note.dart';
import 'package:note/models/constants.dart';
import 'package:note/models/note_class.dart';
import 'package:note/providers.dart';
import 'package:provider/provider.dart';

class NoteWidget extends StatelessWidget {
  //parametre Note
  final Note note;
  const NoteWidget(this.note, {super.key});

  @override
  Widget build(BuildContext context) {
    //Obtenir les données de la note
    //le id de la note
    final noteId = note.id;
    //le titre de la note
    final noteTitre = note.titre;
    //le texte de la note
    final noteTexte = note.text;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        //Se diriger à la page de modification de note en transmettant les données de la note
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ModifierNote(noteTitre, noteTexte, id: noteId!);
              },
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16),
            side: BorderSide(color: Colors.grey, width: 0),
          ),

          child: ListTile(
            splashColor: Styles.primaryColor,
            title: Text(
              noteTitre,
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: Styles.titreTexte,
            ),
            subtitle: Text(
              noteTexte,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Styles.corpsTexte,
            ),
            leading: Icon(FluentSystemIcons.ic_fluent_note_regular),
            trailing: IconButton(
              icon: Icon(FluentSystemIcons.ic_fluent_delete_regular),
              color: Colors.redAccent,

              //Supprimer la note et afficher un snackbar de confirmation de la suppression
              onPressed: () {
                context.read<NotesProvider>().supprimerNote(noteId!);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Note supprimée",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.redAccent,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
