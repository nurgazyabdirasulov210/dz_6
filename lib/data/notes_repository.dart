import '../models/note.dart';
import 'notes_local_data_source.dart';

class NotesRepository {
  final NotesLocalDataSource localDataSource;

  NotesRepository(this.localDataSource);

  Future<List<Note>> getNotes() async {
    return await localDataSource.getNotes();
  }

  Future<Note?> getNoteById(int id) async {
    return await localDataSource.getNoteById(id);
  }

  Future<void> addNote(String title, String text) async {
    await localDataSource.addNote(title, text);
  }

  Future<void> updateNote(Note note) async {
    await localDataSource.updateNote(note);
  }

  Future<void> deleteNote(int id) async {
    await localDataSource.deleteNote(id);
  }
}
