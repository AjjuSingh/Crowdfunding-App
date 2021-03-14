import 'package:crowdfund_app/constants/app_colors.dart';
import 'package:crowdfund_app/constants/app_config.dart';
import 'package:crowdfund_app/ui/login/login_email.dart';
import 'package:crowdfund_app/ui/login/login_screen.dart';
import 'package:crowdfund_app/ui/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // Call this first to make sure that we can mkae other system level calls safely
  WidgetsFlutterBinding.ensureInitialized();

  // Status bar style on android
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle());

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Material app
    /// Define also [navigatorKey]
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, primaryColor: AppColors.black),
      home: SplashScreen(),
      routes: {
        "/login": (context) => LoginScreen(),
        "/login/email": (context) => EmailLoginPage(),
        "/signup": (context) => SignUpPage()
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
      Navigator.of(context).pushReplacement(PageRouteBuilder(
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
