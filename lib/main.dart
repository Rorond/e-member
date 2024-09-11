import 'package:emembers/flutter_flow/flutter_flow_theme.dart';
import 'package:emembers/flutter_flow/internationalization.dart';
import 'package:emembers/flutter_flow/nav/nav.dart';
import 'package:emembers/navbar.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:emembers/data/classes/auth.dart';
import 'package:emembers/ui/signin/login_widget.dart';
import 'package:emembers/ui/signin/otp_page_widget.dart';

void mainDelegate() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterFlowTheme.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  final AuthModel _auth = new AuthModel();
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    _auth.loadSettings();
    super.initState();
    _appStateNotifier = AppStateNotifier();
    _router = createRouter(_appStateNotifier);
    try {
      final context = navigatorKey.currentContext;
      _auth.loadSettings();
    } catch (e) {
      print("Error Loading Settings: $e");
    }
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AuthModel>(
      model: _auth,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: ScopedModelDescendant<AuthModel>(
          builder: (context, child, model) {
            var checkUser = model.user.userId != 0;
            if (checkUser) {
              int optChecking = model.user.evCodeStatus == ""
                  ? 0
                  : int.parse(model.user.evCodeStatus);
              if (optChecking == 1) {
                return MainScreen(
                    auth: _auth, user: _auth.user); // Use MainScreen here
              } else {
                return OtpPage(user: _auth.user);
              }
            }
            return LoginWidget(username: '');
          },
        ),
        routes: <String, WidgetBuilder>{
          "/homepage": (BuildContext context) =>
              MainScreen(auth: _auth, user: _auth.user), // Use MainScreen here
        },
      ),
    );
  }
}
