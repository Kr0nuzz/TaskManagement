import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_Management/initializer/initializer.dart';
import 'package:task_Management/models/notepad/note_models.dart';
import 'package:task_Management/presentation/blocs/notepad/notepad_bloc.dart';
import 'package:task_Management/presentation/blocs/notepad/notepad_event.dart';
import 'package:task_Management/presentation/blocs/setting/stary_awake_cubit.dart';
import 'package:task_Management/presentation/blocs/timer/timer_bloc.dart';
import 'package:task_Management/presentation/blocs/visibletoggle/visible_bloc.dart';
import 'package:task_Management/presentation/screen/splash_screen.dart';
import 'package:task_Management/core/services/local_notification_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationServices.init();
  

  final init = Initializer();
  await init.initialize();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final notebox = Hive.box<NoteModels>('notesbox');
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TimerBloc()
          ),
          BlocProvider(create: (context) {
            return NotepadBloc(notebox)..add(LoadNote());
          }),
          BlocProvider(create: (context) => BottomNavCubit()),
          BlocProvider(create: (_) => StayAwakeCubit()..load())
        ],
        child: const MaterialApp(
            debugShowCheckedModeBanner: false, home: SplashScreen()));
  }
}
