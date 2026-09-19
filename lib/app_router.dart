import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'models/note.dart';
import 'pages/edit_note_page.dart';
import 'pages/note_details_page.dart';
import 'pages/notes_page.dart';
import 'pages/settings_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: NotesRoute.page, initial: true),
        AutoRoute(page: EditNoteRoute.page),
        AutoRoute(page: NoteDetailsRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ];
}
