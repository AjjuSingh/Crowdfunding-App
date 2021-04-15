import 'package:crowdfund_app/commands/app/authentication_user_command.dart';
import 'package:crowdfund_app/constants/app_colors.dart';
import 'package:crowdfund_app/constants/app_config.dart';
import 'package:crowdfund_app/extension_methods.dart';
import 'package:crowdfund_app/widgets/styled_load_spinner.dart';
import 'package:crowdfund_app/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

/// todo: Change it to Sliver view to  make it scrollable
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

  bool passwordVisible = true;
  // Global key for form
  GlobalKey<FormState> _formState = GlobalKey();

  // TextEditing Controllers
  TextEditingController? _emailCtrl = TextEditingController();
  TextEditingController? _passCtrl = TextEditingController();
  TextEditingController? _confirmPassCtrl = TextEditingController();

  bool isLoading = false;

  Align emailPasswordWidget() {
    return Align(
      alignment: Alignment.center,
      child: Form(
        key: _formState,
        child: Container(
          height: AppConfig.screenHeight! * 0.6,
          width: AppConfig.screenWidth! * 0.8,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 80,
                ),
              ),
              SliverToBoxAdapter(
                child: VTextFormField(
                    validator: (String val) {
                      if (!val.isValidEmail()) {
                        return "Enter valid email";
                      }
                      return null;
                    },
                    controller: _emailCtrl,
                    title: "Email",
                    inputType: TextInputType.emailAddress),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
              SliverToBoxAdapter(
                child: VTextFormField(
                    controller: _passCtrl,
                    title: "Password",
                    inputType: TextInputType.text,
                    validator: (String val) {
                      if (val.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                    isObscureText: passwordVisible),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
              SliverToBoxAdapter(
                child: VTextFormField(
                    controller: _confirmPassCtrl,
                    title: "Confirm Password",
                    inputType: TextInputType.text,
                    validator: (val) {
                      if (val != _passCtrl!.text) {
                        return "Password doesn't match";
                      }
                      return null;
                    },
                    isObscureText: passwordVisible),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 18,
                ),
              ),
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: _validateForm,
                  child: isLoading
                      ? Center(child: StyledLoadSpinner())
                      : Container(
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
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 25,
                ),
              ),
            ],
          ),
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
                style: Theme.of(context).textTheme.headline4,
                children: [
                  TextSpan(
                      text: "\nCreate new account",
                      style: Theme.of(context).textTheme.bodyText2)
                ]),
          )
        ],
      ),
    );
  }

  /// Form validator
  void _validateForm() async {
    if (_formState.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      AuthenticationUserCommand()
          .run(
              email: _emailCtrl!.text,
              password: _passCtrl!.text,
              createNew: true)
          .then((value) {
        if (value.isRight()) {
          setState(() {
            isLoading = false;
            print(isLoading);
          });
          Navigator.pushReplacementNamed(context, "/activate",
              arguments: [_emailCtrl!.text]);
        } else {
          setState(() {
            isLoading = false;
            print(isLoading);
          });
          value.leftMap((l) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(l.message!))));
        }
      });
    }
  }
}
