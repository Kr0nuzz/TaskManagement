import 'package:flutter/material.dart';
import 'widget/form_teks.dart';
import '../../../core/utils/notepad/fungsi_tombol.dart';
import '../../../core/utils/ukuran_layar.dart';

class EditNote extends StatelessWidget {
  EditNote(
      {super.key, required this.title, required this.body, required this.dex});

  final String title;
  final String body;
  final int dex;

  late final TextEditingController _titlecontroller = TextEditingController(text: title);
  late final TextEditingController _bodycontroller = TextEditingController(text: body);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
            onPressed: () {leading(context);},
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).appBarTheme.titleTextStyle?.color,
            )),
        title: Text(
          'Edit Text',
          style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).appBarTheme.titleTextStyle?.color),
        ),
      ),
      body: Container(
        color: Theme.of(context).canvasColor,
        padding: const EdgeInsets.only(top: 10, left: 5),
        height: screenSize(context).height,
        width: screenSize(context).width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormTeks(
                  formcontroller: _titlecontroller,
                  hintText: "Title",
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  fontSize: 25),
              FormTeks(
                  formcontroller: _bodycontroller,
                  maxLines: null,
                  hintText: "Body",
                  keyboardType: TextInputType.multiline,
                  fontSize: 15),
              const SizedBox(
                  height: 80,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {saveNote(context, _titlecontroller, _bodycontroller, dex);},
        heroTag: null,
        child: const Icon(Icons.save),
      ),
    );
  }
}
