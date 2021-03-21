import 'package:crowdfund_app/constants/app_colors.dart';
import 'package:crowdfund_app/constants/app_config.dart';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// Current index of dot indicator
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: "logo",
            child: Image(
              height: 225,
              width: 225,
              alignment: Alignment.center,
              fit: BoxFit.scaleDown,
              image: AssetImage("assets/app_icon.png"),
            ),
          ),
          SizedBox(
            height: AppConfig.screenHeight! * 0.0541388,
          ),
          introSliderText([
            "Devoted",
            "Support",
            "Patreon"
          ], [
            "Bring the desires of your heart",
            "Support other, Give assistance",
            "Get paid for creating thing"
          ]),
          dotSlider(),
          SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () => goToLoginByEmail(),
            child: loginWidget("Login with Email", "assets/email.png",
                boundaryColor: AppColors.fadeColor,
                backgroundColor: Colors.white,
                imageHeight: 40),
          ),
          SizedBox(
            height: AppConfig.screenHeight! * 0.024874,
          ),
          loginWidget("Login with Google", "assets/google.png",
              boundaryColor: Colors.transparent,
              backgroundColor: AppColors.materialBlueColor,
              textColor: Colors.white,
              imageHeight: 29.12),
          SizedBox(
            height: 21,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/signup");
            },
            child: RichText(
              text: TextSpan(
                  text: "Dont't have an account? ",
                  style: TextStyle(
                      color: AppColors.highlightOneColor, fontSize: 14),
                  children: [
                    TextSpan(
                      text: "Signup",
                      style: TextStyle(
                          color: Color(0xFF196084),
                          fontWeight: FontWeight.bold),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }

  /// Navigate to Login By [email]
  void goToLoginByEmail() {
    Navigator.pushNamed(
      context,
      "/login/email",
    );
  }

  /// The login widget for logging in using email or google.
  Widget loginWidget(String title, String assetIcon,
      {Color boundaryColor = Colors.black,
      Color? backgroundColor,
      Color textColor = Colors.black,
      double? imageHeight}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 26),
      width: 334,
      height: 64,
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: boundaryColor,
          ),
          borderRadius: BorderRadius.circular(32)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 0,
            child: Image(
              height: imageHeight,
              image: AssetImage(assetIcon),
            ),
          ),
          Expanded(
            flex: 5,
            child: Center(
              child: Text(
                title,
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// The slider widget on login screen containg title and subtitle.
  Widget introSliderText(List<String> title, List<String> subTitle) {
    return Container(
      height: 120,
      child: PageView.builder(
        itemCount: title.length,
        onPageChanged: (value) {
          setState(() {
            index = value;
          });
        },
        itemBuilder: (context, index) {
          return Column(
            children: [
              Text(
                title[index],
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              SizedBox(
                height: 17,
              ),
              Text(
                subTitle[index],
                style:
                    TextStyle(color: AppColors.highlightOneColor, fontSize: 16),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget dotSlider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == 0
                ? AppColors.highlightOneColor
                : AppColors.highlightOneColor.withOpacity(0.5),
          ),
        ),
        SizedBox(
          width: AppConfig.screenWidth! * 0.048611,
        ),
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == 1
                  ? AppColors.highlightOneColor
                  : AppColors.highlightOneColor.withOpacity(0.5)),
        ),
        SizedBox(
          width: AppConfig.screenWidth! * 0.048611,
        ),
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == 2
                  ? AppColors.highlightOneColor
                  : AppColors.highlightOneColor.withOpacity(0.5)),
        )
      ],
    );
  }
}
