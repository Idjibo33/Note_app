import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:note/ecrans/ajouter_note.dart';
import 'package:note/models/constants.dart';
import 'package:note/models/providers.dart';
import 'package:note/widgets/note_widget.dart';
import 'package:provider/provider.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    final mesNotes = context.watch<NotesProvider>();
    final monTheme = context.watch<StyleTheme>().isLightMode;
    final TextEditingController rechercheText = TextEditingController();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const AjouterNote();
                },
              ),
            );
          },
          child: Icon(FluentSystemIcons.ic_fluent_add_filled),
        ),
        appBar: AppBar(
          title: FittedBox(
            child: Text(
              "NOTES",
              style: Styles.titreTexte.copyWith(
                fontSize: 25,
                letterSpacing: 5,
                color: Styles.primaryColor,
              ),
            ),
          ),
          actions: [
            monTheme
                ?
                  //Activer le mode sombre
                  IconButton(
                    onPressed: () {
                      context.read<StyleTheme>().changerTheme();
                    },
                    icon: Icon(Icons.dark_mode_rounded),
                  )
                :
                  //Activer le mode sombre
                  IconButton(
                    onPressed: () {
                      context.read<StyleTheme>().changerTheme();
                    },
                    icon: Icon(Icons.light_mode_rounded),
                  ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                controller: rechercheText,
                decoration: InputDecoration(
                  hintText: "Recherche une note",
                  hintStyle: Styles.hintText,
                  prefixIcon: Icon(FluentSystemIcons.ic_fluent_search_regular),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const Gap(20),
              Expanded(
                child: mesNotes.notes.isEmpty
                    ? const Center(child: Text("Aucune note trouvée"))
                    : ListView.builder(
                        itemCount: mesNotes.notes.length,
                        itemBuilder: (context, index) {
                          return NoteWidget(mesNotes.notes[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
