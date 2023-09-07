import 'dart:async';

class LicenseRepository {
  Future<bool> getLicense() async {
    await Future.delayed(const Duration(milliseconds: 800));

    return true;
  }
}
