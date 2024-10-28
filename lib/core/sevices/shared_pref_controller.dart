// import 'package:exchange/features/auth/data/models/employee.dart';
import 'package:exchange/features/auth/data/models/employee.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys {
  loggedIn,
  idEmployee,
  nameEmployee,
  emailEmployee,
  pathImage,
  phoneEmployee,
  typeEmployee,
  isActive,
  lastLoggedIn,
  lastLoggedOut,
  token,
  fcmToken
}

class SharedPrefController {
  SharedPrefController._();

  late SharedPreferences _sharedPreferences;

  static SharedPrefController? _instance;

  factory SharedPrefController() {
    return _instance ??= SharedPrefController._();
  }

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
  //
  Future<void> save(DataEmployee dataEmployee) async {
    await _sharedPreferences.setBool(PrefKeys.loggedIn.name, true);
    await _sharedPreferences.setString(PrefKeys.fcmToken.name, "334343434344");
    await _sharedPreferences.setInt(PrefKeys.idEmployee.name, dataEmployee.id);
    await _sharedPreferences.setString(PrefKeys.nameEmployee.name, dataEmployee.name);
    await _sharedPreferences.setString(PrefKeys.emailEmployee.name, dataEmployee.email);
    await _sharedPreferences.setString(PrefKeys.pathImage.name, dataEmployee.image);
    await _sharedPreferences.setString(PrefKeys.phoneEmployee.name, dataEmployee.phone);
    await _sharedPreferences.setString(PrefKeys.typeEmployee.name, dataEmployee.type);

    // تحويل `isActive` من int إلى bool قبل التخزين
    await _sharedPreferences.setBool(PrefKeys.isActive.name, dataEmployee.isActive == 1);

    await _sharedPreferences.setString(PrefKeys.lastLoggedIn.name, dataEmployee.lastLogin);
    await _sharedPreferences.setString(PrefKeys.lastLoggedOut.name, dataEmployee.lastLogout);
    await _sharedPreferences.setString(PrefKeys.token.name, "Bearer ${dataEmployee.token}");
  }

  T? getValue<T>(String key) {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.get(key) as T?;
    }
    return null;
  }

  Future<void> setValue<T>(String key, dynamic value) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    }
  }

  Future<bool> removeValueFor(String key) async {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.remove(key);
    }
    return false;
  }

  Future<bool> clear() async {
    return _sharedPreferences.clear();
  }
}
