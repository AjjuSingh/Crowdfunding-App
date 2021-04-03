import 'package:crowdfund_app/commands/app/setup_user_account_command.dart';
import 'package:crowdfund_app/constants/constants.dart';
import 'package:crowdfund_app/models/response/post_response_model.dart';
import 'package:crowdfund_app/routing/app_navigator.dart';
import 'package:crowdfund_app/ui/dashboard/dashboard_page.dart';
import 'package:crowdfund_app/widgets/styled_widgets.dart';
import 'package:flutter/material.dart';

class SetupProfilePage extends StatefulWidget {
  @override
  _SetupProfilePageState createState() => _SetupProfilePageState();
}

class _SetupProfilePageState extends State<SetupProfilePage> {
  /// Text editing controllers
  late TextEditingController _genderController;
  late TextEditingController _cityController;
  late TextEditingController _roleController;
  late TextEditingController _socialLinkController;
  GlobalKey<FormState> _form = GlobalKey();

  bool isLoading = false;

  double male = 100;
  double female = 100;

  @override
  void initState() {
    super.initState();
    _genderController = TextEditingController();
    _cityController = TextEditingController();
    _roleController = TextEditingController();
    _socialLinkController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Profile setup", style: Theme.of(context).textTheme.headline6),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPadding),
        child: Form(
          key: _form,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 40,
                ),
              ),
              SliverToBoxAdapter(
                child: _genderSelectorWidget(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
              SliverToBoxAdapter(
                child: VTextFormField(
                    validator: (String val) {
                      if (val.isEmpty) {
                        return "Provide your current city name";
                      }
                      return null;
                    },
                    controller: _cityController,
                    title: "Where do you live?",
                    inputType: TextInputType.emailAddress),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
              SliverToBoxAdapter(
                child: VTextFormField(
                  controller: _roleController,
                  title: "I'm a developer, data scientist ...",
                  inputType: TextInputType.text,
                  validator: (String val) {
                    if (val.isEmpty) {
                      return "How you describe yourself in IT world!";
                    }
                    return null;
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
              SliverToBoxAdapter(
                child: VTextFormField(
                  controller: _socialLinkController,
                  title: "GitHub link",
                  inputType: TextInputType.text,
                  validator: (String val) {
                    if (val.isEmpty) {
                      return "Provide your github link";
                    }
                    return null;
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 18,
                ),
              ),
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () {
                    _validateForm();
                  },
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

  /// Validate the form to setup basic details
  void _validateForm() {
    setState(() {
      isLoading = true;
    });
    if (_form.currentState!.validate()) {
      print(_genderController.text);
      print(_cityController.text);

      SetupUserAccountCommand().run(
          gender: _genderController.text,
          city: _cityController.text,
          user_role: _roleController.text,
          social_links: {
            "github": _socialLinkController.text
          }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.toString()),
        ));
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Created profile 🤩"),
          duration: Duration(seconds: 2),
        ));
        AppNavigator.pushReplacementtAndRemoveUntil(context, DashboardPage());
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  Widget _genderSelectorWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              "Male",
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
            ),
            SizedBox(
              height: 18,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  male = 120;
                  female = 100;
                  _genderController.text = "Male";
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 220),
                height: male,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(
                    "assets/male.gif",
                  ),
                ),
              ),
            )
          ],
        ),
        Column(
          children: [
            Text(
              "Female",
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
            ),
            SizedBox(
              height: 18,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  female = 120;
                  male = 100;
                  _genderController.text = "Female";
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 220),
                height: female,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(
                    "assets/female.gif",
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
