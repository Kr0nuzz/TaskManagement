import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> cekPenyimpanan(BuildContext context) async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    AlertDialog(
        title: const Text("Access Denied"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'))
        ],
      );
  }
}