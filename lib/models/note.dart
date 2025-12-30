//la classe Note
class Note {
  final int? id;
  final String titre;
  final String text;

  Note({this.id, required this.titre, required this.text});

  //Convertir l'objet Note en Map pour la base de donnée
  Map<String, dynamic> toMap() {
    return {'id': id, 'titre': titre, 'text': text};
  }

  //Convertir une Map de la base de donnée en objet Note
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int?,
      titre: map['titre'] as String,
      text: map['text'] as String,
    );
  }

  @override
  String toString() => 'Note(id: $id, titre: $titre, text: $text)';
}
