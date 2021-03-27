import 'package:crowdfund_app/commands/app/activate_user_account_command.dart';
import 'package:crowdfund_app/constants/constants.dart';
import 'package:crowdfund_app/routing/app_navigator.dart';
import 'package:crowdfund_app/ui/signup/setup_profile_page.dart';
import 'package:crowdfund_app/widgets/styled_load_spinner.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ActivateAccountPage extends StatefulWidget {
  static const routeName = "/signup";

  ActivateAccountPage({Key? key}) : super(key: key);

  @override
  _ActivateAccountPageState createState() => _ActivateAccountPageState();
}

class _ActivateAccountPageState extends State<ActivateAccountPage> {
  /// Code text controller
  late TextEditingController _otpController;

  bool isLoading = false;

  String currentText = "";
  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  List<String> args = <String>[];

  @override
  Widget build(BuildContext context) {
    // Get arguments from previous screen

    args = ModalRoute.of(context)!.settings.arguments as List<String>;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Verify Account",
              style: Theme.of(context).textTheme.headline6,
            ),
            automaticallyImplyLeading: false,
          ),
          bottomSheet: Container(
            height: AppConfig.screenHeight! * 0.1,
            width: AppConfig.screenWidth!,
            child: isLoading
                ? Center(child: StyledLoadSpinner())
                : TextButton(
                    onPressed: _verifyOtp,
                    child: Text("Verify and create account"),
                  ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Code is sent to ${args[0]}"),
              SizedBox(
                height: kSpacing1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kPadding * 5),
                child: Container(
                  height: AppConfig.screenHeight! * 0.15,
                  child: PinCodeTextField(
                    validator: (val) {
                      if (val!.length < 6) {
                        return "Enter complete pin";
                      }
                      return null;
                    },
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      activeColor: kPrimaryColor,
                      selectedFillColor: Colors.white,
                      shape: PinCodeFieldShape.underline,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      inactiveColor: kWarninngColor,
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: Duration(milliseconds: 300),

                    //errorAnimationController: errorController,
                    controller: _otpController,
                    onCompleted: (v) {},
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      return true;
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _otpController.dispose();
  }

  void _verifyOtp() async {
    setState(() {
      isLoading = true;
    });

    bool success = await ActivateUserCommand()
        .run(email: args[0], otp: _otpController.text);

    setState(() {
      isLoading = false;
    });
    if (success) {
      AppNavigator.push(context, SetupProfilePage());
      return;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Invalid code")));

    return;
  }
}
