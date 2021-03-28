import 'package:crowdfund_app/commands/app/authentication_user_command.dart';
import 'package:crowdfund_app/constants/app_colors.dart';
import 'package:crowdfund_app/constants/app_config.dart';
import 'package:crowdfund_app/routing/app_navigator.dart';
import 'package:crowdfund_app/ui/signup/setup_profile_page.dart';
import 'package:crowdfund_app/widgets/mixins/loading_state_mixin.dart';
import 'package:crowdfund_app/widgets/styled_load_spinner.dart';
import 'package:crowdfund_app/widgets/text_form_field.dart';
import 'package:crowdfund_app/widgets/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:crowdfund_app/extension_methods.dart';

class EmailLoginPage extends StatefulWidget {
  @override
  _EmailLoginPageState createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  IconData? onPasswordVisibleIcon = Icons.visibility_off_rounded;
  bool passwordVisible = true;

  /// Global key for form
  GlobalKey<FormState> _formState = GlobalKey();

  // //////////////////////////////////////////////////
  // Handling error texts
  String _errorText = "";
  String get errorText => _errorText;
  set errorText(String errorText) => setState(() => _errorText = errorText);
  // /////////////////////////////////////////////////////

  ///////////////////////////////////////////////////////////////////////////
  /// Controller for text form handling
  TextEditingController? emailController;
  TextEditingController? passwordController;

  bool isLoading = false;
  ///////////////////////////////////////////////////////////////////////////
  /// Form validator
  void validateForm() async {
    errorText = "";
    if (_formState.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      await AuthenticationUserCommand()
          .run(
              email: emailController!.text,
              password: passwordController!.text,
              createNew: false)
          .then((value) {
        if (value.isRight()) {
          AppNavigator.pushReplacement(context, SetupProfilePage());
        } else {
          value.leftMap((l) {
            errorText = l.message!;
          });
        }
      });

      setState(() {
        isLoading = false;
      });
    }
  }

  //////////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // body: Stack(
      //   children: [welcomeWidget(context), logoWidget(), emailPasswordWidget()],
      // ),
      body: emailPasswordWidget(),
    );
  }

  Align emailPasswordWidget() {
    return Align(
      alignment: Alignment.center,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: AppConfig.screenHeight! * 0.23,
              child: Stack(
                children: [
                  welcomeWidget(context),
                  logoWidget(),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(kPadding * 2),
              child: Form(
                key: _formState,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        height: 10,
                      ),
                      if (_errorText.isNotEmpty) ...[
                        Center(
                            child: UiText(errorText,
                                style: TextStyle(color: Colors.red.shade800))),
                      ],
                      SizedBox(
                        height: 46,
                      ),
                      VTextFormField(
                        title: "Email",
                        inputType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "Email is required";
                          } else if (!val.isValidEmail()) {
                            return "Enter valid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      VTextFormField(
                          title: "Password",
                          inputType: TextInputType.text,
                          suffixIcon: onPasswordVisibleIcon,
                          validator: (String val) {
                            if (val.isEmpty) {
                              return "Password is required";
                            }
                            if (val.length < 4) {
                              return "Password must be greater than 4 characters";
                            }
                            return null;
                          },
                          onTapSuffixIcon: () {
                            if (passwordVisible == false)
                              setState(() {
                                passwordVisible = !passwordVisible;
                                onPasswordVisibleIcon =
                                    Icons.visibility_off_rounded;
                              });
                            else {
                              setState(() {
                                passwordVisible = !passwordVisible;
                                onPasswordVisibleIcon =
                                    Icons.visibility_rounded;
                              });
                            }
                          },
                          controller: passwordController,
                          isObscureText: passwordVisible),
                      SizedBox(
                        height: 18,
                      ),
                      // Submit Button
                      isLoading
                          ? Center(child: StyledLoadSpinner())
                          : GestureDetector(
                              onTap: validateForm,
                              child: Container(
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
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Forget password?",
                        style: TextStyle(
                            fontSize: 14, color: AppColors.materialBlueColor),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
            height: 200,
            width: 200,
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
                style: Theme.of(context).textTheme.headline4,
                children: [
                  TextSpan(
                    text: "\nSign in to your account",
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ]),
          )
        ],
      ),
    );
  }
}
