import 'package:crowdfund_app/constants/app_colors.dart';
import 'package:crowdfund_app/constants/app_config.dart';
import 'package:crowdfund_app/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
        width: AppConfig.screenWidth! * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            VTextFormField(
                title: "Username", inputType: TextInputType.emailAddress),
            SizedBox(
              height: 16,
            ),
            VTextFormField(
                title: "Email", inputType: TextInputType.emailAddress),
            SizedBox(
              height: 16,
            ),
            VTextFormField(
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
                text: "Sign Up",
                style: Theme.of(context).textTheme.headline3,
                children: [
                  TextSpan(
                    text: "\nCreate new account",
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
