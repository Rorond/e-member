// ignore_for_file: overridden_fields, annotate_overrides

import 'package:emembers/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';
SharedPreferences? _prefs;
// first empty state
Color blackColor = Color(0xff0000000);

TextStyle AppTittle1 = GoogleFonts.quicksand(
    fontSize: 15, fontWeight: FontWeight.bold, color: blackColor);

TextStyle AppTittle = GoogleFonts.quicksand(
    fontSize: 15, fontWeight: FontWeight.w600, color: blackColor);

TextStyle MenuApps = GoogleFonts.quicksand(
    fontSize: 13, fontWeight: FontWeight.bold, color: blackColor);

TextStyle ListTittleProfile = GoogleFonts.quicksand(
    fontSize: 16, fontWeight: FontWeight.w600, color: blackColor);

TextStyle clubname = GoogleFonts.quicksand(
    fontSize: 20, fontWeight: FontWeight.bold, color: blackColor);

TextStyle memberText = GoogleFonts.quicksand(
    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);

TextStyle memberTextdate = GoogleFonts.quicksand(
    fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white);

TextStyle productname = GoogleFonts.quicksand(
    fontSize: 16, fontWeight: FontWeight.bold, color: blackColor);

TextStyle LogOutText = GoogleFonts.quicksand(
    fontSize: 14, fontWeight: FontWeight.bold, color: blackColor);

TextStyle AmountText = GoogleFonts.quicksand(
    fontSize: 24, fontWeight: FontWeight.bold, color: blackColor);

TextStyle ButtonTextColor = GoogleFonts.quicksand(
    fontSize: 14, fontWeight: FontWeight.bold, color: primaryColor);

TextStyle bodyText = GoogleFonts.quicksand(fontSize: 14);

TextStyle bodyText1 = GoogleFonts.quicksand(fontSize: 12);

TextStyle searchText = GoogleFonts.quicksand(
  fontSize: 16,
  color: Colors.grey,
);

TextStyle PointText = GoogleFonts.quicksand(
    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue);

abstract class FlutterFlowTheme {
  static FlutterFlowTheme of(BuildContext context) {
    return LightModeTheme();
  }

  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;
  late Color bGatas;

  late Color hintText;
  late Color customColor2;

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  String get displayLargeFamily => typography.displayLargeFamily;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  TextStyle get bodySmall => typography.bodySmall;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFFE20613);
  late Color secondary = const Color(0xFF39D2C0);
  late Color tertiary = const Color(0xFFEE8B60);
  late Color alternate = const Color(0xFFE0E3E7);
  late Color primaryText = const Color(0xFF14181B);
  late Color secondaryText = const Color(0x80000000);
  late Color primaryBackground = const Color(0xFFFFFFFF);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color accent1 = const Color(0x4C4B39EF);
  late Color accent2 = const Color(0x4D39D2C0);
  late Color accent3 = const Color(0x4DEE8B60);
  late Color accent4 = const Color(0xCCFFFFFF);
  late Color success = const Color(0xFF249689);
  late Color warning = const Color(0xFFF27418);
  late Color error = const Color(0xFFFF5963);
  late Color info = const Color(0xFFFFFFFF);
  late Color bGatas = const Color(0xFFFFE9E9);

  late Color hintText = Color(0xFFBFBFBF);
  late Color customColor2 = Color(0xFF9F8FF9);
}

class DarkModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFFE20613);
  late Color secondary = const Color(0xFF39D2C0);
  late Color tertiary = const Color(0xFFEE8B60);
  late Color alternate = const Color(0xFFE0E3E7);
  late Color primaryText = const Color(0xFF14181B);
  late Color secondaryText = const Color(0x80000000);
  late Color primaryBackground = const Color(0xFFFcFcFc);
  late Color secondaryBackground = const Color(0xFFebebeb);
  late Color accent1 = const Color(0x4C4B39EF);
  late Color accent2 = const Color(0x4D39D2C0);
  late Color accent3 = const Color(0x4DEE8B60);
  late Color accent4 = const Color(0xCCFFFFFF);
  late Color success = const Color(0xFF249689);
  late Color warning = const Color(0xFFF27418);
  late Color error = const Color(0xFFFF5963);
  late Color info = const Color(0xFFFFFFFF);
  late Color bGatas = const Color(0xFFFFE9E9);

  late Color hintText = Color(0xFFBFBFBF);
  late Color customColor2 = Color(0xFF9F8FF9);
}

abstract class Typography {
  String get displayLargeFamily;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  TextStyle get bodySmall;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Quicksand';
  TextStyle get displayLarge => GoogleFonts.getFont(
        'Quicksand',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 64.0,
      );
  String get displayMediumFamily => 'Quicksand';
  TextStyle get displayMedium => GoogleFonts.getFont(
        'Quicksand',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 44.0,
      );
  String get displaySmallFamily => 'Quicksand';
  TextStyle get displaySmall => GoogleFonts.getFont(
        'Quicksand',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 36.0,
      );
  String get headlineLargeFamily => 'Quicksand';
  TextStyle get headlineLarge => GoogleFonts.getFont(
        'Quicksand',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 32.0,
      );
  String get headlineMediumFamily => 'Quicksand';
  TextStyle get headlineMedium => GoogleFonts.getFont(
        'Quicksand',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 24.0,
      );
  String get headlineSmallFamily => 'Quicksand';
  TextStyle get headlineSmall => GoogleFonts.getFont(
        'Quicksand',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 24.0,
      );
  String get titleLargeFamily => 'Quicksand';
  TextStyle get titleLarge => GoogleFonts.getFont(
        'Quicksand',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );
  String get titleMediumFamily => 'Quicksand';
  TextStyle get titleMedium => GoogleFonts.getFont(
        'Quicksand',
        color: theme.info,
        fontWeight: FontWeight.normal,
        fontSize: 18.0,
      );
  String get titleSmallFamily => 'Quicksand';
  TextStyle get titleSmall => GoogleFonts.getFont(
        'Quicksand',
        color: theme.info,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  String get labelLargeFamily => 'Quicksand';
  TextStyle get labelLarge => GoogleFonts.getFont(
        'Quicksand',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
  String get labelMediumFamily => 'Quicksand';
  TextStyle get labelMedium => GoogleFonts.getFont(
        'Quicksand',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
  String get labelSmallFamily => 'Quicksand';
  TextStyle get labelSmall => GoogleFonts.getFont(
        'Quicksand',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
  String get bodyLargeFamily => 'Quicksand';
  TextStyle get bodyLarge => GoogleFonts.getFont(
        'Quicksand',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
  String get bodyMediumFamily => 'Quicksand';
  TextStyle get bodyMedium => GoogleFonts.getFont(
        'Quicksand',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
  String get bodySmallFamily => 'Quicksand';
  TextStyle get bodySmall => GoogleFonts.getFont(
        'Quicksand',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}
