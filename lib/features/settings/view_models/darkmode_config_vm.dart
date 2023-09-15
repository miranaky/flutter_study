import 'package:flutter/material.dart';
import 'package:thread_clone/features/settings/models/darkmode_config_model.dart';
import 'package:thread_clone/features/settings/repos/darkmode_config_repo.dart';

class DarkModeConfigViewModel extends ChangeNotifier {
  final DarkModeConfigRepository _repository;

  late final DarkModeConfigModel _model = DarkModeConfigModel(
    isDarkMode: _repository.isDarkMode(),
  );

  DarkModeConfigViewModel(this._repository);

  bool get isDarkMode => _model.isDarkMode;

  void setDarkMode(bool value) {
    _repository.setDarkMode(value);
    _model.isDarkMode = value;
    notifyListeners();
  }
}
