// note_helper.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_Management/models/notepad/note_models.dart';
import 'package:task_Management/presentation/blocs/notepad/notepad_bloc.dart';
import 'package:task_Management/presentation/blocs/notepad/notepad_event.dart';
import '../../../presentation/blocs/visibletoggle/visible_bloc.dart';
import '../../../presentation/screen/notepad/edit_note.dart';
import '../../../presentation/screen/notepad/crate_note.dart';
import '../../../presentation/screen/notepad/note_view.dart';
import '../../../presentation/widget/snackbar.dart';

void createNote(BuildContext context, TextEditingController titleController,
    TextEditingController bodyController) {
  
          if(titleController.text.trim().isEmpty || bodyController.text.trim().isEmpty){
            AppSnackBar.show(context, title: "Info", message: "Pelase fill the Title & Body", type: SnackType.warning,elevation: 0);
            return;
          }

  final newNote = NoteModels(
    title: titleController.text,
    body: bodyController.text,
  );

  // Mengirim event ke NotepadBloc
  context.read<NotepadBloc>().add(AddNote(note: newNote));
  // Kembali ke layar sebelumnya setelah menyimpan catatan
  Navigator.of(context).pop();
  context.read<BottomNavCubit>().show();
}

void leading(BuildContext context) {
  context.read<BottomNavCubit>().show();
  //untuk kembali ke menu sebelumnya tanpa menghapus slide sebelumnya
  Navigator.of(context).pop();
}

void editNote(BuildContext context, String title, String body, int dex) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => EditNote(title: title, body: body, dex: dex)));
}

void actionButton(BuildContext context) {
  context.read<BottomNavCubit>().hide();
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const CreateNote()));
}

void saveNote(BuildContext context, TextEditingController titlecontroller, TextEditingController bodycontroller, int dex){
  
          final upnote = NoteModels(
            title: titlecontroller.text,
            body: bodycontroller.text,
          );
          context.read<NotepadBloc>().add(UpdateNote(upnote, dex));
          context.read<BottomNavCubit>().show();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => NoteView(
                    title: titlecontroller.text,
                    body: bodycontroller.text,
                    dex: dex,
                  )));
        
}

