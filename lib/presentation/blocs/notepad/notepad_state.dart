import 'package:equatable/equatable.dart';
import 'package:task_Management/models/notepad/note_models.dart';

abstract class NotepadState extends Equatable{
  @override
  List<Object> get props => [];
}

class NotepadInitial extends NotepadState {}
class NotepadEmpty extends NotepadState{
  
}
class NotepadLoaded extends NotepadState {
  final List<NoteModels> notes;
  NotepadLoaded(this.notes);
  @override
  List<Object> get props => [notes];
}

