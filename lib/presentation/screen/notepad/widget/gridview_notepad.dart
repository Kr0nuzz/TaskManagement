import 'package:flutter/material.dart';
import 'package:task_Management/models/notepad/note_models.dart';
import 'package:task_Management/presentation/blocs/notepad/notepad_bloc.dart';
import 'package:task_Management/presentation/blocs/notepad/notepad_event.dart';
import '../note_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/visibletoggle/visible_bloc.dart';
import '../../../../core/utils/ukuran_layar.dart';
import 'note_card.dart';

class GridviewNotepad extends StatelessWidget{
  final List<NoteModels> note;
  GridviewNotepad(this.note);

  @override
  Widget build(BuildContext context){
    int rangeOfGrid = 2;
    double devicewidth = screenSize(context).width;
    return GridView.builder(
                gridDelegate:
                    //memberikan batas pada grid sesuai yang diberikan (crossAxisCount)
                    SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: devicewidth > 1200
                            ? rangeOfGrid + 2
                            : devicewidth > 700
                                ? rangeOfGrid + 1
                                : 2),
                itemCount: note.length,
                itemBuilder: (context, index) {
                  final notes = note[index];
                  final title = notes.title;
                  final body = notes.body;
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 7, bottom: 7),
                    //membuat widget card
                    child: InkWell(
                      onTap: () {
                        context.read<BottomNavCubit>().hide();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NoteView(
                                title: title, body: body, dex: index)));
                      },
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Delete This Note?'),
                                content:
                                    Text('Catatan ${notes.title} akan dihapus'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('No')),
                                  TextButton(
                                      onPressed: () {
                                        context
                                            .read<NotepadBloc>()
                                            .add(DeleteNote(dex: index));
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Yes'))
                                ],
                              );
                            });
                      },
                      child: NoteCard(
                        note: notes,
                      ),
                    ),
                  );
                },
              );
  }
}