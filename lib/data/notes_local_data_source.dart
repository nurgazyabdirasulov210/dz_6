import 'package:drift/drift.dart';
import '../models/note.dart';
import 'app_database.dart';

class NotesLocalDataSource {
  final AppDatabase db;

  NotesLocalDataSource(this.db);

  Note toNote(NoteEntity entity) {
    return Note(id: entity.id, title: entity.title, text: entity.content);
  }

  Future<List<Note>> getNotes() async {
    final query = db.select(db.notes)
      ..orderBy([(t) => OrderingTerm.desc(t.id)]);
    final rows = await query.get();
    return rows.map((e) => toNote(e)).toList();
  }

  Future<Note?> getNoteById(int id) async {
    final query = db.select(db.notes)..where((t) => t.id.equals(id));
    final row = await query.getSingleOrNull();
    if (row == null) {
      return null;
    }
    return toNote(row);
  }

  Future<void> addNote(String title, String text) async {
    await db.into(db.notes).insert(
          NotesCompanion.insert(title: title, content: text),
        );
  }

  Future<void> updateNote(Note note) async {
    final query = db.update(db.notes)..where((t) => t.id.equals(note.id));
    await query.write(
      NotesCompanion(
        title: Value(note.title),
        content: Value(note.text),
      ),
    );
  }

  Future<void> deleteNote(int id) async {
    final query = db.delete(db.notes)..where((t) => t.id.equals(id));
    await query.go();
  }
}
