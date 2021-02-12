import 'package:crowdfund_app/style/app_config.dart';
import 'package:crowdfund_app/ui/login/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget with WidgetsBindingObserver {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return CustomPageRoute(builder: (context) => LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Material app
    /// Define also [navigatorKey]
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: SplashScreen(),
      routes: {"/login": (context) => LoginScreen()},
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
      Navigator.of(context).push(PageRouteBuilder(
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
