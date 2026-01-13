import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_Management/models/notepad/note_models.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
  });
  final NoteModels note;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).inputDecorationTheme;
    BoxShadow boxShadow(Color color, double offset1) {
      return BoxShadow(
          color: color,
          offset: Offset(offset1, offset1),
          blurRadius: 15,
          spreadRadius: 1);
    }

    Text teks(String teks, int maxline, double fontSize) {
      return Text(
        teks,
        overflow: TextOverflow.ellipsis,
        maxLines: maxline,
        style: GoogleFonts.nunito(
            textStyle: TextStyle(
                fontSize: fontSize,
                color: Theme.of(context).appBarTheme.titleTextStyle?.color)),
      );
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Theme.of(context).cardColor,
      //membuat container didalam card
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).inputDecorationTheme.fillColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              boxShadow(tema.fillColor ?? Colors.grey.shade500, 5),
              boxShadow(tema.focusColor ?? Colors.white, -5)
            ]),
        // membuat padding agar ada gap antara huruf dan card
        padding: const EdgeInsets.all(7),
        //membuat column untuk teks title dan teks body
        child: Column(
          //agar posisi huruf disebelah kiri
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [teks(note.title, 1, 23), teks(note.body, 4, 14)],
        ),
      ),
    );
  }
}
