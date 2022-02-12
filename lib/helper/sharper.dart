import 'package:shared_preferences/shared_preferences.dart';

Future<bool> bul({required String name}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("me", name);
}
