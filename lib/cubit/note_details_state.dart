import 'package:equatable/equatable.dart';
import '../models/note.dart';

abstract class NoteDetailsState extends Equatable {
  const NoteDetailsState();

  @override
  List<Object> get props => [];
}

class NoteDetailsLoading extends NoteDetailsState {
  const NoteDetailsLoading();
}

class NoteDetailsLoaded extends NoteDetailsState {
  final Note note;

  const NoteDetailsLoaded(this.note);

  @override
  List<Object> get props => [note];
}

class NoteDetailsError extends NoteDetailsState {
  final String message;

  const NoteDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
