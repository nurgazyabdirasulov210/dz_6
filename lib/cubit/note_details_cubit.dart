import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/notes_repository.dart';
import 'note_details_state.dart';

class NoteDetailsCubit extends Cubit<NoteDetailsState> {
  final NotesRepository repository;
  final int noteId;

  NoteDetailsCubit(this.repository, this.noteId)
      : super(const NoteDetailsLoading());

  Future<void> loadNote() async {
    emit(const NoteDetailsLoading());
    try {
      final note = await repository.getNoteById(noteId);
      if (note == null) {
        emit(const NoteDetailsError('Заметка не найдена'));
        return;
      }
      emit(NoteDetailsLoaded(note));
    } catch (e) {
      emit(const NoteDetailsError('Не удалось загрузить заметку'));
    }
  }
}
