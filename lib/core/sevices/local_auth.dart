import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class LocalAuth {
  static final _auth = LocalAuthentication();

  static Future<bool> _canAuthenticate() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  static Future<bool> authenticate() async {
    try {
      if (!await _canAuthenticate()) return false;

      return await _auth.authenticate(
        localizedReason: 'Please authenticate to access this feature',
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      // Handling specific errors if needed
      print("An error occurred: ${e.message}");
      return false;
    } catch (e) {
      print("An unknown error occurred: $e");
      return false;
    }
  }
}
