import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app_router.dart';
import '../cubit/note_details_cubit.dart';
import '../cubit/note_details_state.dart';
import '../cubit/notes_cubit.dart';
import '../data/notes_repository.dart';
import '../models/note.dart';
import '../widgets/delete_dialog.dart';

@RoutePage()
class NoteDetailsPage extends StatelessWidget {
  final String noteId;

  const NoteDetailsPage({super.key, required this.noteId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NoteDetailsCubit(context.read<NotesRepository>(), noteId)..loadNote(),
      child: const NoteDetailsView(),
    );
  }
}

class NoteDetailsView extends StatelessWidget {
  const NoteDetailsView({super.key});

  Future<void> openEdit(BuildContext context, Note note) async {
    final cubit = context.read<NoteDetailsCubit>();
    await context.router.push(EditNoteRoute(note: note));
    if (!cubit.isClosed) {
      cubit.loadNote();
    }
  }

  Future<void> deleteNote(BuildContext context, Note note) async {
    final confirmed = await showDeleteDialog(context);
    if (!confirmed || !context.mounted) {
      return;
    }
    final messenger = ScaffoldMessenger.of(context);
    final router = context.router;
    await context.read<NotesCubit>().deleteNote(note.id);
    messenger.showSnackBar(
      const SnackBar(content: Text('Заметка удалена')),
    );
    router.maybePop();
  }

  Widget body(BuildContext context, NoteDetailsState state) {
    if (state is NoteDetailsLoaded) {
      final note = state.note;
      return Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title.isEmpty ? 'Без названия' : note.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    note.text.isEmpty ? 'Текст не добавлен' : note.text,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    if (state is NoteDetailsError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(state.message),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                context.read<NoteDetailsCubit>().loadNote();
              },
              child: const Text('Повторить'),
            ),
          ],
        ),
      );
    }
    return const Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteDetailsCubit, NoteDetailsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Заметка'),
            actions: [
              if (state is NoteDetailsLoaded) ...[
                IconButton(
                  onPressed: () {
                    openEdit(context, state.note);
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    deleteNote(context, state.note);
                  },
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ],
          ),
          body: body(context, state),
        );
      },
    );
  }
}
