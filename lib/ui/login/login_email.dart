import 'package:crowdfund_app/constants/app_colors.dart';
import 'package:crowdfund_app/constants/app_config.dart';
import 'package:flutter/material.dart';

class EmailLoginPage extends StatefulWidget {
  @override
  _EmailLoginPageState createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [welcomeWidget(context), logoWidget(), emailPasswordWidget()],
      ),
    );
  }

  IconData? onPasswordVisibleIcon = Icons.visibility_off_rounded;
  bool passwordVisible = true;

  Align emailPasswordWidget() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: AppConfig.screenHeight! * 0.6,
        width: 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "email",
              child: Center(
                child: Material(
                  borderRadius: BorderRadius.circular(100),
                  elevation: 20,
                  shadowColor: Color(0x161F54C3),
                  child: Image(
                    alignment: Alignment.center,
                    fit: BoxFit.scaleDown,
                    height: 80,
                    width: 80,
                    image: AssetImage("assets/email.png"),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 46,
            ),
            inputFieldWidget(
                title: "Email", inputType: TextInputType.emailAddress),
            SizedBox(
              height: 16,
            ),
            inputFieldWidget(
                title: "Password",
                inputType: TextInputType.text,
                suffixIcon: onPasswordVisibleIcon,
                onTapSuffixIcon: () {
                  if (passwordVisible == false)
                    setState(() {
                      passwordVisible = !passwordVisible;
                      onPasswordVisibleIcon = Icons.visibility_off_rounded;
                    });
                  else {
                    setState(() {
                      passwordVisible = !passwordVisible;
                      onPasswordVisibleIcon = Icons.visibility_rounded;
                    });
                  }
                },
                isObscureText: passwordVisible),
            SizedBox(
              height: 18,
            ),
            Container(
                height: 52,
                width: 300,
                decoration: BoxDecoration(
                    color: AppColors.materialBlueColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 4),
                          color: Color(0x151F54C3),
                          blurRadius: 20)
                    ]),
                child: Center(
                    child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ))),
            SizedBox(
              height: 25,
            ),
            Text(
              "Forget password?",
              style:
                  TextStyle(fontSize: 14, color: AppColors.materialBlueColor),
            )
          ],
        ),
      ),
    );
  }

  Container inputFieldWidget(
      {String? title,
      TextInputType? inputType,
      VoidCallback? onTapSuffixIcon,
      bool isObscureText = false,
      IconData? suffixIcon}) {
    return Container(
      height: 52,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 6), color: Color(0x151F54C3), blurRadius: 20)
          ]),
      child: TextFormField(
        obscureText: isObscureText,
        keyboardType: inputType,
        decoration: InputDecoration(
            suffixIcon:
                InkWell(onTap: onTapSuffixIcon, child: Icon(suffixIcon)),
            labelText: title,
            labelStyle: TextStyle(color: AppColors.black),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            )),
      ),
    );
  }

  /// Logo widget which gives hero animation while navigating
  /// It's at the topright corner
  Positioned logoWidget() {
    return Positioned(
      top: -50,
      right: -115,
      child: Hero(
        tag: "logo",
        child: Material(
          borderRadius: BorderRadius.circular(100),
          elevation: 20,
          shadowColor: Color(0x161F54C3),
          child: Image(
            alignment: Alignment.center,
            fit: BoxFit.scaleDown,
            image: AssetImage("assets/app_icon.png"),
          ),
        ),
      ),
    );
  }

  /// Welcome text widget
  Positioned welcomeWidget(BuildContext context) {
    return Positioned(
      top: 50,
      left: 10,
      child: Row(
        children: [
          RichText(
            text: TextSpan(
                text: "Welcome back!",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: "\nSign in to your account",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16),
                  )
                ]),
          )
        ],
      ),
    );
  }
}
