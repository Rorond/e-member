import 'package:flutter/material.dart';
import 'package:emembers/data/classes/dateutils.dart';

enum AlertAction { cancel, discard, disagree, agree }

enum Environment { DEV, STAGING, PROD }

class Constants {
  static Map<String, dynamic> _config = Map();

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.debugConstants;
        break;
      case Environment.STAGING:
        _config = _Config.qaConstants;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
    }
  }

  static get apiGateway {
    return _config[_Config.API_GATEWAY];
  }

  static get apiLoyalty {
    return _config[_Config.API_GATEWAY];
  }

  static get apiContent {
    return _config[_Config.API_CONTENT];
  }

  static get apiImage {
    return _config[_Config.API_IMAGE];
  }

  static get whereIAM {
    return _config[_Config.WHERE_AM_I];
  }
}

class _Config {
  static const API_GATEWAY = "API_GATEWAY";
  static const API_CONTENT = "API_CONTENT";
  static const API_IMAGE = "API_IMAGE";
  static const WHERE_AM_I = "WHERE_AM_I";
  static const API_LOYALTY = "API_LOYALTY";

  static Map<String, dynamic> debugConstants = {
    API_GATEWAY: "https://api-emembers.sinarmasland.com/api/DEV",
    API_CONTENT: "https://api-emembers.sinarmasland.com/api/content",
    API_IMAGE: "https://api-emembers.sinarmasland.com/image",
    API_LOYALTY: "https://api-emembers.sinarmasland.com/api/DEV",
    WHERE_AM_I: "local",
  };

  static Map<String, dynamic> qaConstants = {
    API_GATEWAY: "http://10.201.1.92:8000/api",
    API_CONTENT: "http://10.201.1.91",
    API_IMAGE: "http://10.201.1.92:8000/image",
    API_LOYALTY: "http://10.202.1.92:8000/api",
    WHERE_AM_I: "staging",
  };

  static Map<String, dynamic> prodConstants = {
    API_GATEWAY: "https://api-emembers.sinarmasland.com/api",
    API_CONTENT: "https://api-emembers.sinarmasland.com/api/content",
    API_IMAGE: "https://api-emembers.sinarmasland.com/image",
    API_LOYALTY: "https://loyalty.sinarmasland.com/api",
    WHERE_AM_I: "prod"
  };
}

const bool devMode = false;

// class AppRoute {
//   static final String home = '/';
//   static final String categories = '/categories';
//   static final String jobs = '/jobs';
//   static final String details = '/details';
//   static final String complete = '/complete';
// }

// class AppTheme {
//   AppTheme._();

//   static const double textScaleFactor = 1.0;
//   static const Color primaryColor = Color.fromARGB(255, 254, 65, 77);
//   static const Color notWhite = Color(0xFFEDF0F2);
//   static const Color nearlyWhite = Color(0xFFFEFEFE);
//   static const Color white = Color(0xFFFFFFFF);
//   static const Color nearlyBlack = Color(0xFF213333);
//   static const Color grey = Color(0xFF3A5160);
//   static const Color dark_grey = Color(0xFF313A44);

//   static const Color darkText = Color(0xFF253840);
//   static const Color darkerText = Color(0xFF17262A);
//   static const Color lightText = Color(0xFF4A6572);
//   static const Color deactivatedText = Color(0xFF767676);
//   static const Color dismissibleBackground = Color(0xFF364A54);
//   static const Color chipBackground = Color(0xFFEEF1F3);
//   static const Color spacer = Color(0xFFF2F2F2);
//   static const String fontName = 'Metropolis';

//   // static const TextTheme textTheme = TextTheme(
//   //   // display1: display1,
//   //   // headline: headline,
//   //   // title: title,
//   //   // subtitle: subtitle,
//   //   // body2: body2,
//   //   // body1: body1,
//   //   caption: caption,
//   // );

//   static var textFormFieldRegular = TextStyle(
//       fontSize: 16,
//       fontFamily: "Metropolis",
//       color: Colors.black,
//       fontWeight: FontWeight.w400);

//   static var textFormFieldLight =
//       textFormFieldRegular.copyWith(fontWeight: FontWeight.w200);

//   static var textFormFieldMedium =
//       textFormFieldRegular.copyWith(fontWeight: FontWeight.w500);

//   static var textFormFieldSemiBold =
//       textFormFieldRegular.copyWith(fontWeight: FontWeight.w600);

//   static var textFormFieldBold =
//       textFormFieldRegular.copyWith(fontWeight: FontWeight.w700);

//   static var textFormFieldBlack =
//       textFormFieldRegular.copyWith(fontWeight: FontWeight.w900);

// }

class AppSizes {
  static const int splashScreenTitleFontSize = 48;
  static const int titleFontSize = 34;
  static const double sidePadding = 15;
  static const double widgetSidePadding = 20;
  static const double buttonRadius = 25;
  static const double imageRadius = 8;
  static const double linePadding = 4;
  static const double widgetBorderRadius = 34;
  static const double textFieldRadius = 4.0;
  static const EdgeInsets bottomSheetPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 10);
  static const app_bar_size = 56.0;
  static const app_bar_expanded_size = 180.0;
  static const tile_width = 148.0;
  static const tile_height = 276.0;
}

class AppColors {
  static const red = Color(0xFFDB3022);
  static const black = Color(0xFF222222);
  static const lightGray = Color(0xFF9B9B9B);
  static const darkGray = Color(0xFF979797);
  static const white = Color(0xFFFFFFFF);
  static const orange = Color(0xFFFFBA49);
  static const gold = Color(0xFFFFD700);
  static const background = Color(0xFFF4F4F4);
  static const backgroundLight = Color(0xFFF9F9F9);
  static const transparent = Color(0x00000000);
  static const success = Color(0xFF2AA952);
  static const green = Color(0xFF2AA952);

  static const double textScaleFactor = 1.0;
  static const Color primaryColor = Color(0xFFA4161A);
  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);
  static Color primaryBackground = const Color(0xFFFcFcFc);
  static Color secondaryBackground = const Color(0xFFebebeb);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Metropolis';
}

class AppTexts {
  static var textFormFieldRegular = TextStyle(
      fontSize: 16,
      fontFamily: "Nunito",
      color: AppColors.nearlyBlack,
      fontWeight: FontWeight.w600);

  static var textFormFieldLight =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w200);

  static var textFormFieldMedium =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w500);

  static var textFormFieldSemiBold =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w600);

  static var textFormFieldBold =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w700);

  static var textFormFieldBlack =
      textFormFieldRegular.copyWith(fontWeight: FontWeight.w900);
  static var textFormFieldH_3 = TextStyle(
      fontSize: 18.0,
      fontFamily: "Nunito",
      color: Colors.black,
      fontWeight: FontWeight.w600);
}

class AppConsts {
  static const page_size = 20;
}

class BaseUrlParams {
  static String baseUrlParams(String userId) {
    return "?Localization=" +
        DateUtility.getUTCString() +
        "&UserId=" +
        userId.toString();
  }
}
