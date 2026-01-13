import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_Management/models/notepad/note_models.dart';
import 'notepad_event.dart';
import 'notepad_state.dart';

class NotepadBloc extends Bloc<NotepadEvent, NotepadState> {
  final Box<NoteModels> notebox;
  NotepadBloc(this.notebox) : super(NotepadInitial()) {
    on<LoadNote>((event, emit) {
      final notes = notebox.values.toList();
      if (notebox.isNotEmpty) {
        emit(NotepadLoaded(notes));
      } else if(notebox.isEmpty){
        emit(NotepadEmpty());
      }
    });

    on<AddNote>((event, emit) {
      notebox.add(event.note);
      add(LoadNote());
    });
    on<UpdateNote>((event, emit) {
      notebox.putAt(event.index, event.note);
      add(LoadNote());
    });
    on<DeleteNote>((event, emit) async {
      await notebox.deleteAt(event.dex);
      add(LoadNote());
    });
  }
}
