import 'package:flutter_project/features/setting/models/mode_model.dart';
import 'package:flutter_project/features/setting/repos/setting_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModeViewModel extends Notifier<ModeModel> {
  final SettingRepository _settingRepository;

  ModeViewModel(this._settingRepository);

  void setDarkMode(bool isDarkMode) {
    _settingRepository.setDarkMode(isDarkMode);
    state = ModeModel(
      isDarkMode: isDarkMode,
    );
  }

  @override
  ModeModel build() {
    return ModeModel(
      isDarkMode: _settingRepository.getDarkMode(),
    );
  }
}

final modeViewModelProvider = NotifierProvider<ModeViewModel, ModeModel>(
  () => throw UnimplementedError(),
);
