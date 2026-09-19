import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int id;
  final String title;
  final String text;

  const Note({required this.id, required this.title, required this.text});

  Note copyWith({String? title, String? text}) {
    return Note(
      id: id,
      title: title ?? this.title,
      text: text ?? this.text,
    );
  }

  @override
  List<Object> get props => [id, title, text];
}
