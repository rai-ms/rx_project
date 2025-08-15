import 'package:flutter/material.dart';
import 'package:rx_project/core/base/base_service/base_service.dart'
    show BaseService;
import 'package:rx_project/core/services/my_app_listener/my_app_listener.dart'
    show MyAppListener;
import 'package:rx_project/core/services/storage_service/hive_storage/hive_constants.dart'
    show HiveConstants;
import 'package:rx_project/core/services/storage_service/hive_storage/storage_service.dart'
    show StorageService;
import 'package:rx_project/core/themes/blue_white_theme.dart'
    show DarkBlueTheme;
import 'package:rx_project/core/themes/dark_gun_metal_theme.dart'
    show BlueWhiteTheme;
import 'package:rx_project/core/themes/dark_theme.dart' show AppDarkTheme;
import 'package:rx_project/core/themes/light_theme.dart' show AppLightTheme;
import 'package:rx_project/core/utils/app_enum.dart' show AppTheme;
import 'package:rx_project/core/utils/app_type_def.dart' show FVoid;
import '../../base/logger/app_logger_impl.dart';

/// [ThemeService] class is responsible to provide and update the [Theme] in the app
@protected
@immutable
class ThemeService extends BaseService<void, AppTheme> {
  /// [themeListener] is the variable which have the theme value
  /// Overriding the value of [themeListener] react to the changes of theme in the app
  static ValueNotifier<AppTheme> themeListener = ValueNotifier<AppTheme>(
    AppTheme.darkBlue,
  );

  /// [themeService] singleton Object of theme class
  static ThemeService themeService = ThemeService();

  @override
  void init({AppTheme? param}) {
    log.d("ThemeService Initialized");
  }

  /// [getThemeType] should call before get theme to update the theme data
  static void getThemeType(BuildContext context) {
    String? theme = StorageService.service.getCore(key: HiveConstants.themeKey);
    AppTheme appTheme = AppTheme.getTheme(theme);

    if (appTheme == AppTheme.system) {
      final brightness = MediaQuery.platformBrightnessOf(context);
      brightness == Brightness.dark
          ? themeListener.value = AppTheme.dark
          : themeListener.value = AppTheme.light;
    } else {
      themeListener.value = appTheme;
    }
  }

  /// [updateTheme] should call to update the theme
  FVoid updateTheme(AppTheme theme) async {
    themeListener.value = theme;
    MyAppListener.service.addThemeListener();
    await StorageService.service.setCore(
      key: HiveConstants.themeKey,
      value: theme.getThemeVal(),
    );
  }

  /// [getTheme] is return in main, to provide the [ThemeData]
  static ThemeData getTheme(BuildContext context) {
    getThemeType(context);
    switch (themeListener.value) {
      case AppTheme.darkBlue:
        return const BlueWhiteTheme().getTheme();
      case AppTheme.lightRed:
        return const DarkBlueTheme().getTheme();
      case AppTheme.light:
        return const AppLightTheme().getTheme();
      case AppTheme.dark:
        return const AppDarkTheme().getTheme();
      default:
        final brightness = MediaQuery.platformBrightnessOf(context);
        return brightness == Brightness.dark
            ? const DarkBlueTheme().getTheme()
            : const BlueWhiteTheme().getTheme();
    }
  }
}
