import 'package:flutter/material.dart';
import 'package:rx_project/core/base/base_service/base_service.dart'
    show BaseService;
import 'package:rx_project/core/services/internet_service/internet_service.dart'
    show InternetService;
import 'package:rx_project/core/services/language_service/language_service.dart'
    show AppLanguageService;
import 'package:rx_project/core/services/theme_service/theme_service.dart'
    show ThemeService;
import 'package:rx_project/core/utils/app_enum.dart' show AppTheme;
import '../../base/logger/app_logger_impl.dart' show log;

class MyAppListenerModel {
  final AppTheme theme;
  final String locale;

  MyAppListenerModel({this.theme = AppTheme.system, this.locale = "en"});

  MyAppListenerModel copyWith(
    AppTheme? theme,
    String? locale,
    bool? isNetAvailable,
  ) {
    return MyAppListenerModel(
      theme: theme ?? this.theme,
      locale: locale ?? this.locale,
    );
  }
}

class MyAppListener extends BaseService<void, void> {
  MyAppListenerModel myAppListenerModel = MyAppListenerModel();

  static MyAppListener service = MyAppListener();

  static ValueNotifier<MyAppListenerModel> myAppListener =
      ValueNotifier<MyAppListenerModel>(MyAppListenerModel());

  @override
  void init({void param}) {
    log.d("MyAppListener Initialized");
    addThemeListener();
    addNetListener();
    addLocaleListener();
  }

  update({AppTheme? theme, String? locale, bool? isNetAvailable}) {
    myAppListenerModel = myAppListenerModel.copyWith(
      theme,
      locale,
      isNetAvailable,
    );
    myAppListener.value = myAppListenerModel;
  }

  void addThemeListener() {
    var theme = ThemeService.themeListener;
    update(theme: theme.value);
  }

  void addNetListener() {
    var netValue = InternetService.service.netListener;
    update(isNetAvailable: netValue.value);
  }

  void addLocaleListener() {
    var locale = AppLanguageService.services.languageChange;
    update(locale: locale.value.languageCode);
  }
}
