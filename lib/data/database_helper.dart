//Le fichier database_helper de sqflite
import 'package:note/models/note_class.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _open();
    return _db!;
  }

  Future<Database> _open() async {
    final dbDir = await getDatabasesPath();
    final path = join(dbDir, 'notes.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titre TEXT NOT NULL,
            text TEXT NOT NULL
          )
        ''');
      },
    );
  }

  //Insérer une note
  Future<void> ajouterNote(Note note) async {
    final db = await AppDatabase.instance.database;
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Lire les notes
  Future<List<Note>> lireNotes() async {
    final db = await AppDatabase.instance.database;
    final result = await db.query('notes');
    return result.map((map) => Note.fromMap(map)).toList();
  }

  //Mettre à jour la note
  Future<void> misAJourNote(Note note) async {
    final db = await AppDatabase.instance.database;
    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  //Supprimer la note
  Future<void> supprimerNote(int id) async {
    final db = await AppDatabase.instance.database;
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
