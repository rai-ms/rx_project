import 'package:flutter/material.dart';
import 'package:rx_project/core/base/theme_base/theme_base.dart';
import 'package:rx_project/core/utils/app_colors.dart';

class BlueWhiteTheme extends AppCustomTheme {
  const BlueWhiteTheme() : super(Brightness.light);

  @override
  ColorScheme get colorScheme => ColorScheme.light(
    primary: AppColors.blueColor,
    onPrimary: AppColors.romanSilver,
    onSurface: AppColors.greyColor.withValues(alpha: 0.1),
    surface: AppColors.antiFlashWhite.withValues(alpha: 0.9),
    secondary: AppColors.darkGunMetal,
    onSecondary: AppColors.whiteColor,
    primaryContainer: AppColors.lightGrey,
    onPrimaryContainer: AppColors.antiFlashWhite,
    errorContainer: AppColors.kuCrimson,
    onErrorContainer: AppColors.darkBlueColor,
    inversePrimary: AppColors.darkRedColor,
    tertiary: AppColors.blackColor,
    surfaceTint: AppColors.lightGunMetal,
  );

  @override
  ThemeData getTheme() => ThemeData(
    scaffoldBackgroundColor: colorScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.onSurface,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: colorScheme.secondary,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(color: colorScheme.primary),
    ),
    brightness: brightness,
    visualDensity: VisualDensity.standard,
    colorScheme: colorScheme,
    textTheme: textTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
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
            return colorScheme.surface;
          }
          return colorScheme.primary;
        }),
        surfaceTintColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.surface;
          }
          return colorScheme.primary;
        }),
      ),
    ),
  );

  @override
  TextTheme textTheme() => const TextTheme();
}
