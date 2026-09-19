import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/notes_cubit.dart';
import '../models/note.dart';

Future<bool> showNoteDialog(BuildContext context, [Note? note]) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return NoteDialog(note: note);
    },
  );
  return result == true;
}

class NoteDialog extends StatefulWidget {
  final Note? note;

  const NoteDialog({super.key, this.note});

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  late TextEditingController titleController;
  late TextEditingController textController;
  late NotesCubit notesCubit;
  String? errorText;

  bool get isEditing => widget.note != null;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note?.title ?? '');
    textController = TextEditingController(text: widget.note?.text ?? '');
    debugPrint('NoteDialog initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    notesCubit = context.read<NotesCubit>();
    debugPrint('NoteDialog didChangeDependencies');
  }

  @override
  void deactivate() {
    debugPrint('NoteDialog deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    titleController.dispose();
    textController.dispose();
    debugPrint('NoteDialog dispose');
    super.dispose();
  }

  Future<void> save() async {
    final title = titleController.text.trim();
    final text = textController.text.trim();

    if (title.isEmpty && text.isEmpty) {
      setState(() {
        errorText = 'Заметка пустая';
      });
      return;
    }

    final navigator = Navigator.of(context);

    if (isEditing) {
      await notesCubit.updateNote(widget.note!.copyWith(title: title, text: text));
    } else {
      await notesCubit.addNote(title, text);
    }

    navigator.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEditing ? 'Редактирование' : 'Новая заметка'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              autofocus: true,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Заголовок',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: textController,
              minLines: 3,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: 'Текст',
                errorText: errorText,
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: save,
          child: const Text('Сохранить'),
        ),
      ],
    );
  }
}
