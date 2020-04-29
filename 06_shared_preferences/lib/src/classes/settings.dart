import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  SharedPreferences _prefs;
  bool get isReady => _prefs != null;
  final _controller = StreamController<Settings>.broadcast();
  Stream<Settings> get stream => _controller.stream;

  void dispose() {
    _controller?.close();
  }

  Future<bool> init() async {
    _controller.add(this);
    _prefs = await SharedPreferences.getInstance();
    _controller.add(this);
    return isReady;
  }

  static const String _isFreshKey = 'is_fresh_app_install';
  bool get isFresh => _prefs?.getBool(_isFreshKey) ?? true;
  set isFresh(bool value) => updateIsFresh(value);
  Future updateIsFresh(bool value) async {
    if (!isReady) await init();
    await _prefs.setBool(_isFreshKey, value);
    _controller.add(this);
  }

  static const String _isDarkModeKey = 'is_dark_theme';
  bool get isDark => _prefs?.getBool(_isDarkModeKey) ?? false;
  set isDark(bool value) => updateIsDark(value);
  Future updateIsDark(bool value) async {
    if (!isReady) await init();
    await _prefs.setBool(_isDarkModeKey, value);
    _controller.add(this);
  }

  static const String _themeModeKey = 'theme_mode';
  ThemeMode get themeMode => ThemeMode
      .values[(_prefs?.getInt(_themeModeKey) ?? ThemeMode.system.index)];
  set themeMode(ThemeMode value) => updateThemeMode(value);
  Future updateThemeMode(ThemeMode value) async {
    if (!isReady) await init();
    await _prefs.setInt(_themeModeKey, value.index);
    _controller.add(this);
  }
}
