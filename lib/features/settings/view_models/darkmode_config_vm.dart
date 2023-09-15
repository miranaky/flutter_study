import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/features/settings/models/darkmode_config_model.dart';
import 'package:thread_clone/features/settings/repos/darkmode_config_repo.dart';

class DarkModeConfigViewModel extends Notifier<DarkModeConfigModel> {
  final DarkModeConfigRepository _repository;

  DarkModeConfigViewModel(this._repository);

  void setDarkMode(bool value) {
    _repository.setDarkMode(value);
    state = DarkModeConfigModel(isDarkMode: value);
  }

  @override
  DarkModeConfigModel build() {
    //initial state
    return DarkModeConfigModel(
      isDarkMode: _repository.isDarkMode(),
    );
  }
}

final darkModeConfigViewModelProvider =
    NotifierProvider<DarkModeConfigViewModel, DarkModeConfigModel>(
  () => throw UnimplementedError(),
);
