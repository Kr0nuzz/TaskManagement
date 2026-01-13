import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_Management/core/utils/notepad/fungsi_tombol.dart';
import 'package:task_Management/presentation/blocs/notepad/notepad_bloc.dart';
import 'package:task_Management/presentation/blocs/notepad/notepad_state.dart';
import 'package:task_Management/presentation/screen/notepad/widget/center_notepad.dart';
import 'package:task_Management/presentation/screen/notepad/widget/customactionbutton.dart';
import 'package:task_Management/presentation/screen/notepad/widget/gridview_notepad.dart';

class MyNotepad extends StatelessWidget {
  const MyNotepad({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Container(
        padding: const EdgeInsets.only(left: 0, right: 0, bottom: 20),
        child: BlocBuilder<NotepadBloc, NotepadState>(
          builder: (context, state) {
              if (state is NotepadLoaded) {
                return GridviewNotepad(state.notes);
              } else if (state is NotepadEmpty){
                return const CenterNotepad();
              }else {
                return const Center(child: Text('Error'));
              }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          actionButton(context);
        },
        // mencegah error karena ada lebih dari 1 floating action button
        heroTag: null,
        backgroundColor: Theme.of(context).inputDecorationTheme.fillColor,
        child: Icon(Icons.add,
            color: Theme.of(context).appBarTheme.titleTextStyle?.color),
      ),
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(),
    );
  }
}
