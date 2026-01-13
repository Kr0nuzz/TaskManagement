import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_Management/core/utils/stayawake.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class StayAwakeCubit extends Cubit<bool> {
  StayAwakeCubit() : super(false);

  Future<void> load() async {
    final pref = await SharedPreferences.getInstance();
    final value = pref.getBool('stayAwake') ?? false;
    emit(value);
    _apply(value);
  }

  Future<void> toogle(bool value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool("stayAwake", value);
    emit(value);
    _apply(value);
  }

  void _apply(bool enable){
    if (enable){
      WakelockPlus.enable();
    }else{
      WakelockPlus.disable();
    }
  }
}
