import 'package:flutter/material.dart';
import '../../../core/utils/notepad/fungsi_tombol.dart';
import '../../../core/utils/ukuran_layar.dart';

class NoteView extends StatelessWidget {
  const NoteView(
      {super.key, required this.title, required this.body, required this.dex});

  final String title;
  final String body;
  final int dex;
  @override
  Widget build(BuildContext context) {
    const String titleAppbar = 'Read Text';
    const double titleFontsize = 25;
    const double bodyFontsize = 18;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            leading(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
              onPressed: () {editNote(context, title, body, dex);},
              icon: const Icon(Icons.edit))
        ],
        title: const Text(titleAppbar),
      ),
      body: Container(
        height: screenSize(context).height,
        color: Theme.of(context).canvasColor,
        padding: const EdgeInsets.only(top: 10, left: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: titleFontsize),
              ),
              Text(
                body,
                style: const TextStyle(fontSize: bodyFontsize),
              ),
              SizedBox(
                width: screenSize(context).width,
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
