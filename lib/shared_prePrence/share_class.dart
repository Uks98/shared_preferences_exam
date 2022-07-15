
import 'package:shared_preferences/shared_preferences.dart';

class SharedClass{
  static SharedPreferences? _pref;

  Future<String> getSharedIdAndPw({required String key})async{
    _pref = await SharedPreferences.getInstance();
    _pref?.getString(key) ?? "";
    return _pref?.getString(key) ?? "";
  }

  Future<Future<bool>?> setShared({String? key,String? text})async{
    _pref = await SharedPreferences.getInstance();
    return  _pref?.setString(key!,text!);
  }
}