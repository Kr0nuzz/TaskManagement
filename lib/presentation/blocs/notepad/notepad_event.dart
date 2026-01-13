import 'package:equatable/equatable.dart';
import 'package:task_Management/models/notepad/note_models.dart';

abstract class NotepadEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadNote extends NotepadEvent {}
class AddNote extends NotepadEvent {
  final NoteModels note;
  AddNote({required this.note});
}

class DeleteNote extends NotepadEvent {
  final int dex;
  DeleteNote({required this.dex});
}

class UpdateNote extends NotepadEvent {
  final int index;
  final NoteModels note;
  UpdateNote(this.note,  this.index);
}

