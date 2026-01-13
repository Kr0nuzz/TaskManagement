import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:task_Management/presentation/blocs/setting/stary_awake_cubit.dart';
import 'package:task_Management/presentation/screen/contact_person.dart';
import '../../core/utils/ukuran_layar.dart';

class MySetting extends StatefulWidget {
  const MySetting(
      {super.key, required this.onThemeChange, required this.isDarkMode});

  final bool isDarkMode;
  final ValueChanged<bool> onThemeChange;

  @override
  State<MySetting> createState() => _MySettingState();
}

class _MySettingState extends State<MySetting> {
  bool pop = false;

  final List list = ["Dark Mode", "Stay Awake", "Contact Person"];
  final List<IconData?> icon = [
    Icons.dark_mode,
    Icons.screen_lock_portrait,
    Icons.contact_mail
  ];

  final List<void Function(BuildContext)> callback = [
    (BuildContext context) {},
    (BuildContext context) {},
    (BuildContext context) => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MyContact()))
  ];

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final List<Widget?> lead = [
      Switch(
          activeColor: Colors.white,
          inactiveTrackColor: Colors.white,
          activeTrackColor: Theme.of(context).inputDecorationTheme.fillColor,
          inactiveThumbColor:
              Theme.of(context).appBarTheme.titleTextStyle?.color,
          value: widget.isDarkMode,
          onChanged: (nilai) {
            widget.onThemeChange(nilai);
          }),
      BlocBuilder<StayAwakeCubit, bool>(
          builder: (context, ison) {
            return Switch(
                activeTrackColor:
                    Theme.of(context).inputDecorationTheme.fillColor,
                activeColor:
                    Theme.of(context).appBarTheme.titleTextStyle?.color,
                inactiveTrackColor:
                    Theme.of(context).inputDecorationTheme.focusColor,
                inactiveThumbColor:
                    Theme.of(context).appBarTheme.titleTextStyle?.color,
                value: ison,
                onChanged: (value) async {
                  context.read<StayAwakeCubit>().toogle(value);
                });
          }),
      null
    ];
    return Container(
      color: Theme.of(context).canvasColor,
      width: screenSize(context).width,
      height: screenSize(context).height,
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: list.length,
          itemBuilder: (BuildContext contex, int index) {
            return ListTile(
              title: Text(list[index]),
              leading: Icon(icon[index]),
              trailing: lead[index],
              onTap: () => callback[index](context),
            );
          }),
    );
  }
}
