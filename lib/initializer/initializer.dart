import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:task_Management/models/notepad/note_models.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Initializer {
  Future<void> initialize()async{
  WidgetsFlutterBinding.ensureInitialized();
  WakelockPlus.enable();
  MobileAds.instance.initialize();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelsAdapter());
  if (!Hive.isBoxOpen('notesbox')) {
    await Hive.openBox<NoteModels>('notesbox');
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
}