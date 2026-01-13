import 'package:flutter/material.dart';
import 'widget/form_teks.dart';
import '../../../core/utils/notepad/fungsi_tombol.dart';
import '../../../core/utils/ukuran_layar.dart';

class CreateNote extends StatelessWidget {
  const CreateNote({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          foregroundColor: Theme.of(context).textTheme.bodySmall?.color,
          title: const Text('Create Note'),
          leading: IconButton(
              onPressed: () {
                leading(context);
              },
              icon: const Icon(Icons.arrow_back))),
      body: SingleChildScrollView(
        child: Container(
          height: screenSize(context).height,
          width: screenSize(context).width,
          color: Theme.of(context).canvasColor,
          child: Column(
            children: [
              FormTeks(
                formcontroller: titleController,
                hintText: "Judul",
                maxLines: 1,
                keyboardType: TextInputType.text,
                fontSize: 25,
              ),
              FormTeks(
                formcontroller: bodyController,
                hintText: "Isi",
                maxLines: null,
                keyboardType: TextInputType.multiline,
                fontSize: 18,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNote(context, titleController, bodyController);},
        heroTag: null,
        child: const Icon(Icons.save),
      ),
    );
  }
}
