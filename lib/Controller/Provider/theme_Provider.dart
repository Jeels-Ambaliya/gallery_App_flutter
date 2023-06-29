import 'package:flutter/cupertino.dart';
import 'package:gallery_app/Modal/theme_Modal.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeModal themeModal = ThemeModal(isDark: false);

  void changeTheme() {
    themeModal.isDark = !themeModal.isDark;
    notifyListeners();
  }
}
