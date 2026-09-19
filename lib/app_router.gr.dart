// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [EditNotePage]
class EditNoteRoute extends PageRouteInfo<EditNoteRouteArgs> {
  EditNoteRoute({Key? key, Note? note, List<PageRouteInfo>? children})
      : super(
          EditNoteRoute.name,
          args: EditNoteRouteArgs(key: key, note: note),
          initialChildren: children,
        );

  static const String name = 'EditNoteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditNoteRouteArgs>(
        orElse: () => const EditNoteRouteArgs(),
      );
      return EditNotePage(key: args.key, note: args.note);
    },
  );
}

class EditNoteRouteArgs {
  const EditNoteRouteArgs({this.key, this.note});

  final Key? key;

  final Note? note;

  @override
  String toString() {
    return 'EditNoteRouteArgs{key: $key, note: $note}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditNoteRouteArgs) return false;
    return key == other.key && note == other.note;
  }

  @override
  int get hashCode => key.hashCode ^ note.hashCode;
}

/// generated route for
/// [NoteDetailsPage]
class NoteDetailsRoute extends PageRouteInfo<NoteDetailsRouteArgs> {
  NoteDetailsRoute({
    Key? key,
    required String noteId,
    List<PageRouteInfo>? children,
  }) : super(
          NoteDetailsRoute.name,
          args: NoteDetailsRouteArgs(key: key, noteId: noteId),
          initialChildren: children,
        );

  static const String name = 'NoteDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NoteDetailsRouteArgs>();
      return NoteDetailsPage(key: args.key, noteId: args.noteId);
    },
  );
}

class NoteDetailsRouteArgs {
  const NoteDetailsRouteArgs({this.key, required this.noteId});

  final Key? key;

  final String noteId;

  @override
  String toString() {
    return 'NoteDetailsRouteArgs{key: $key, noteId: $noteId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NoteDetailsRouteArgs) return false;
    return key == other.key && noteId == other.noteId;
  }

  @override
  int get hashCode => key.hashCode ^ noteId.hashCode;
}

/// generated route for
/// [NotesPage]
class NotesRoute extends PageRouteInfo<void> {
  const NotesRoute({List<PageRouteInfo>? children})
      : super(NotesRoute.name, initialChildren: children);

  static const String name = 'NotesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NotesPage();
    },
  );
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsPage();
    },
  );
}
