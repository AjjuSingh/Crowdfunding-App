import 'dart:async';

import 'package:crowdfund_app/commands/app/bootstrap_command.dart';
import 'package:crowdfund_app/constants/app_colors.dart';
import 'package:crowdfund_app/constants/app_config.dart';
import 'package:crowdfund_app/models/app_model.dart';
import 'package:crowdfund_app/routing/app_router.dart';
import 'package:crowdfund_app/services/auth_user_service.dart';
import 'package:crowdfund_app/themes.dart';
import 'package:crowdfund_app/ui/login/login_email.dart';
import 'package:crowdfund_app/ui/login/login_screen.dart';
import 'package:crowdfund_app/ui/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'routing/app_route_parser.dart';
import 'ui/signup/activate_screen.dart';
import 'ui/test_widget.dart';

void main() {
  // Call this first to make sure that we can mkae other system level calls safely
  WidgetsFlutterBinding.ensureInitialized();

  // Status bar style on android
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle());

  // Create core model and services
  Authentication authentication = AuthenticationFactory.create();
  AppModel appModel = AppModel(authentication);
  runApp(MultiProvider(providers: [
    // Authentication service
    Provider.value(value: authentication),
    ChangeNotifierProvider.value(value: appModel)
  ], child: _AppBootStrapper()));
}

class _AppBootStrapper extends StatefulWidget {
  @override
  __AppBootStrapperState createState() => __AppBootStrapperState();
}

class __AppBootStrapperState extends State<_AppBootStrapper> {
  late AppRouterDelegate router;
  RouteInformationParser parser = AppRouteParser();
  @override
  void initState() {
    router = AppRouterDelegate(
        context.read<AppModel>(), context.read<Authentication>());
    scheduleMicrotask(() {
      BootStrapCommand().run(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Define also [navigatorKey]
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: ThemeMode.light,
      home: SplashScreen(),
      routes: {
        "/login": (context) => LoginScreen(),
        "/login/email": (context) => EmailLoginPage(),
        "/signup": (context) => SignUpPage(),
        "/activate": (context) => ActivateAccountPage(),

        /// Testing widget
        "/whoareyou": (context) => WhoAreYou()
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      print(context.read<AppModel>().isSignedIn);
      context.read<AppModel>().currentUser != null
          ? Navigator.of(context).pushReplacement(PageRouteBuilder(
              pageBuilder: (context, _, __) => WhoAreYou(),
              transitionDuration: Duration(milliseconds: 1500)))
          : Navigator.of(context).pushReplacement(PageRouteBuilder(
              pageBuilder: (context, _, __) => LoginScreen(),
              transitionDuration: Duration(milliseconds: 1500)));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Get the screen height of device
    AppConfig.screenHeight = MediaQuery.of(context).size.height;
    AppConfig.screenWidth = MediaQuery.of(context).size.width;

    print("${AppConfig.screenHeight}");
    print("${AppConfig.screenWidth}");

    return Material(
      child: Hero(
        tag: "logo",
        child: Image(
          alignment: Alignment.center,
          fit: BoxFit.scaleDown,
          image: AssetImage("assets/app_icon.png"),
        ),
      ),
    );
  }
}

class CustomPageRoute extends MaterialPageRoute {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  CustomPageRoute({builder}) : super(builder: builder);
}
