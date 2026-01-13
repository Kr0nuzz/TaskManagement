import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_Management/core/utils/cek_penyimpanan.dart';
import 'package:task_Management/models/notepad/note_models.dart';
import 'package:task_Management/presentation/blocs/visibletoggle/visible_bloc.dart';
import 'package:task_Management/presentation/blocs/visibletoggle/visible_state.dart';
import 'package:task_Management/presentation/screen/notepad/notepad.dart';
import 'package:task_Management/presentation/screen/setting.dart';
import 'package:task_Management/presentation/screen/timer/timer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/theme.dart';
import '../../core/utils/ukuran_layar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//pilihan pada tombol navigation bar
class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool _isDarkMode = false;
  int _selectedIndex = 0;
  int _previousIndex = 0;
  late AnimationController _controller;
  final _mybox = Hive.box<NoteModels>('notesbox');

  @override
  void initState() {
    super.initState();
    cekPenyimpanan(context);
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = screenSize(context).width;
    final iconHeightSize = screenSize(context).height * 0.1;
    double iconHeightSize2 = iconHeightSize < 66 ? 70 : iconHeightSize * 1;
    final screen = [
      const MyNotepad(),
       const MyTimer(),
      MySetting(
        isDarkMode: _isDarkMode,
        onThemeChange: (bool isDarkMode) {
          setState(() {
            _isDarkMode = isDarkMode;
          });
        },
      )
    ];
    return MaterialApp(
      theme: _isDarkMode ? AppTheme.darktheme : AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Task Management",
            textAlign: TextAlign.center,
            style: GoogleFonts.alatsi(),
          ),
        ),
        body: ValueListenableBuilder(
            valueListenable: _mybox.listenable(),
            builder: (context, Box box, _) {
              return Stack(children: [
                Container(
                    color: Theme.of(context).canvasColor,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      // untuk menambahkan effek slide ease in out saat navbar ditekan
                      alignment: _selectedIndex == 0
                          ? const Alignment(0, 0)
                          : _selectedIndex == 1
                              ? const Alignment(-0.5, 0)
                              : const Alignment(0.5, 0),
                      curve: Curves.easeInOut,
                      child: Stack(
                        children: [
                          //fungsi perpindahan slide berikutnya ketika tombol ditekan
                          _selectedIndex < _previousIndex
                              ? screen[_selectedIndex]
                                  .animate(controller: _controller)
                                  .move(
                                      begin: Offset(
                                          sizeScreen > 1000
                                              ? -2000
                                              : sizeScreen > 600
                                                  ? -900
                                                  : -599,
                                          0),
                                      end: const Offset(0, 0),
                                      curve: Curves.easeInOut,
                                      duration: const Duration(seconds: 1))
                              : _selectedIndex > _previousIndex
                                  ? screen[_selectedIndex]
                                      .animate(controller: _controller)
                                      .move(
                                          begin: Offset(
                                              sizeScreen > 1000
                                                  ? 2000
                                                  : sizeScreen > 600
                                                      ? 900
                                                      : 599,
                                              0),
                                          end: const Offset(0, 0),
                                          curve: Curves.easeInOut,
                                          duration: const Duration(seconds: 1))
                                  : screen[_selectedIndex],
                          //fungsi perpindahan slide sebelumnya ketika tombol ditekan
                          _selectedIndex < _previousIndex
                              ? screen[_previousIndex]
                                  .animate(controller: _controller)
                                  .move(
                                      begin: const Offset(0, 0),
                                      end: Offset(
                                          sizeScreen > 1000
                                              ? 2000
                                              : sizeScreen > 600
                                                  ? 900
                                                  : 599,
                                          0),
                                      curve: Curves.easeInOut,
                                      duration: const Duration(seconds: 1))
                              : _selectedIndex > _previousIndex
                                  ? screen[_previousIndex]
                                      .animate(controller: _controller)
                                      .move(
                                          begin: const Offset(0, 0),
                                          end: Offset(
                                              sizeScreen > 1000
                                                  ? -2000
                                                  : sizeScreen > 600
                                                      ? -900
                                                      : -599,
                                              0),
                                          curve: Curves.easeInOut,
                                          duration: const Duration(seconds: 1))
                                  : screen[_selectedIndex]
                        ],
                      ),
                    )),
                Positioned(
                  bottom: 0,
                  width: MediaQuery.of(context).size.width,
                  height: iconHeightSize2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      child: BlocBuilder<BottomNavCubit, VisibleState>(
                        builder: (context, state) {
                          return Visibility(
                            visible: state.visible,
                            child: GNav(tabBackgroundColor: Theme.of(context).hoverColor,
                                gap: 5,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                tabs: [
                                  GButton(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .appBarTheme
                                            .titleTextStyle
                                            ?.color),
                                    style: GnavStyle.google,
                                    icon: Icons.note,
                                    iconSize: 20,
                                    text: 'Notepad',
                                  ),
                                  GButton(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .appBarTheme
                                            .titleTextStyle
                                            ?.color),
                                    icon: Icons.timer,
                                    iconSize: 20,
                                    text: 'Pomodoro',
                                  ),
                                  GButton(
                                    iconSize: 20,
                                    icon: Icons.settings,
                                    text: 'Setting',
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .appBarTheme
                                            .titleTextStyle
                                            ?.color),
                                  ),
                                ],
                                selectedIndex: _selectedIndex,
                                //memberikan fungsi saat tombol ditekan
                                onTabChange: (index) {
                                  //fungsi saat tombol ditekan
                                  setState(() {
                                    _previousIndex = _selectedIndex;
                                    _selectedIndex = index;
                                    _controller.reset();
                                    _controller.forward();
                                  });
                                }),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ]);
            }),
        //membuat navigation bar menggunakan Gnav
      ),
    );
  }

}
