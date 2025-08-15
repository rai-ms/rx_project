import 'package:flutter/material.dart';
import 'package:rx_project/core/base/theme_base/theme_base.dart'
    show AppCustomTheme;
import 'package:rx_project/core/utils/app_colors.dart' show AppColors;

class DarkBlueTheme extends AppCustomTheme {
  const DarkBlueTheme() : super(Brightness.dark);

  @override
  ColorScheme get colorScheme => ColorScheme.dark(
    primary: AppColors.darkGunMetal,
    onPrimary: AppColors.romanSilver,
    surface: AppColors.darkGunMetal.withValues(alpha: 0.2),
    secondary: AppColors.whiteColor,
    primaryContainer: AppColors.blueColor.withValues(alpha: 0.1),
    errorContainer: AppColors.kuCrimson,
    onErrorContainer: AppColors.maroon,
    surfaceTint: AppColors.whiteColor,
  );

  @override
  ThemeData getTheme() => ThemeData(
    scaffoldBackgroundColor: colorScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primary,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: colorScheme.secondary,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      iconTheme: const IconThemeData(color: AppColors.whiteColor),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          strokeAlign: 0.5,
          color: colorScheme.surface,
          style: BorderStyle.solid,
        ),
      ),
    ),
    brightness: brightness,
    colorScheme: colorScheme,
    primaryColor: colorScheme.primary,
    visualDensity: VisualDensity.standard,
    textTheme: textTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
        padding: EdgeInsets.zero,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: AppColors.greyColor.withValues(alpha: 0.9),
          width: 1,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
        padding: EdgeInsets.zero,
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return colorScheme.onSurface;
      }),
      visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
    ),
    dividerTheme: DividerThemeData(
      thickness: 23,
      space: 23,
      color: AppColors.greyColor.withValues(alpha: 0.5),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.tertiary;
          }
          return colorScheme.tertiary;
        }),
        surfaceTintColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.tertiary;
          }
          return colorScheme.tertiary;
        }),
      ),
    ),
  );

  @override
  TextTheme textTheme() => const TextTheme();
}
