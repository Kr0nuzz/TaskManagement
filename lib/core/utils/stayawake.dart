import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';


class Stayawake {
  static Future<bool> getValue() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool('stayAwake') ?? false;
  }

  static Future<void> setValue(bool value) async{
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('stayAwake', value);

    if (value){
      WakelockPlus.enable();
    }else{
      WakelockPlus.disable();
    }
  }
}