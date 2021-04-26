import 'package:crowdfund_app/_utils/safe_print.dart';
import 'package:crowdfund_app/ui/dashboard/home/campaign/campaign_form_pages/basic_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateCampaignPage extends StatefulWidget {
  @override
  _CreateCampaignPageState createState() => _CreateCampaignPageState();
}

class _CreateCampaignPageState extends State<CreateCampaignPage> {
  GlobalKey<FormState> _basicFormKey = GlobalKey<FormState>();
  List<GlobalKey<FormState>> keys = <GlobalKey<FormState>>[];

  int currentStep = 0;
  @override
  void initState() {
    super.initState();
    keys.add(_basicFormKey);
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create a campaign",
          style: theme.bodyText1,
        ),
      ),
      body: Stepper(
        currentStep: 0,
        type: StepperType.vertical,
        controlsBuilder: (BuildContext context,
            {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
          switch (currentStep) {
            case 0:
              return Row(
                children: <Widget>[
                  TextButton(
                    onPressed: _basicValidation,
                    child: const Text('NEXT'),
                  ),
                ],
              );
          }
          return Text("Hello");
        },
        steps: [
          Step(
              title: Text("Basic"),
              content: BasicSetupSection(
                formKey: keys[0],
              )),
          Step(title: Text("Funding"), content: Text("Widgets")),
          Step(title: Text("People"), content: Text("Widgets")),
          Step(title: Text("Payment"), content: Text("Widgets")),
        ],
      ),
    );
  }

  void _basicValidation() {
    if (keys[0].currentState!.validate()) {
      safePrint("Validating basic");
    }
  }
}
