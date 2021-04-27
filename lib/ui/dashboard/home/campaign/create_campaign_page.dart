import 'package:crowdfund_app/_utils/safe_print.dart';
import 'package:crowdfund_app/ui/dashboard/home/campaign/campaign_form_pages/basic_section_step.dart';
import 'package:crowdfund_app/ui/dashboard/home/campaign/campaign_form_pages/campaign_detail_step.dart';
import 'package:crowdfund_app/ui/dashboard/home/campaign/campaign_form_pages/cover_image_step.dart';
import 'package:crowdfund_app/widgets/styled_app_bar.dart';
import 'package:flutter/material.dart';

class CreateCampaignPage extends StatefulWidget {
  @override
  _CreateCampaignPageState createState() => _CreateCampaignPageState();
}

class _CreateCampaignPageState extends State<CreateCampaignPage> {
  GlobalKey<FormState> _basicFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _coverImageKey = GlobalKey<FormState>();
  GlobalKey<FormState> _campaignDetailKey = GlobalKey<FormState>();
  List<GlobalKey<FormState>> keys = <GlobalKey<FormState>>[];
  List<Step> steps = [];

  int currentStep = 0;
  bool complete = false;

  @override
  void initState() {
    super.initState();
    keys.addAll([_basicFormKey, _coverImageKey, _campaignDetailKey]);
    steps = [
      Step(
          title: Text("Basic Information"),
          content: BasicSetupSection(
            formKey: keys[0],
          )),
      Step(
          title: Text("Cover Image"),
          content: CoverImageStep(
            formKey: keys[1],
          )),
      Step(
          title: Text("Campaign Details"),
          content: CampaignDetailStep(
            formKey: keys[2],
          )),
    ];
  }

  next() {
    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() {
      currentStep = step;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: VAppBar(
        title: "Create a campaign",
      ),
      body: Stepper(
        currentStep: currentStep,
        type: StepperType.vertical,
        onStepContinue: next,
        onStepCancel: cancel,
        onStepTapped: (step) => goTo(step),
        controlsBuilder: (BuildContext context,
            {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
          switch (currentStep) {
            case 0:
              return Row(
                children: <Widget>[
                  TextButton(
                    onPressed: () => _basicValidation(onStepContinue),
                    child: const Text('NEXT'),
                  ),
                ],
              );
            case 1:
              return Row(
                children: <Widget>[
                  TextButton(
                    onPressed: () => _coverImageValidation(onStepContinue),
                    child: const Text('NEXT'),
                  ),
                  TextButton(
                    onPressed: onStepCancel,
                    child: const Text('BACK'),
                  ),
                ],
              );
          }
          return Row(
            children: <Widget>[
              TextButton(
                onPressed: () => _coverImageValidation(onStepContinue),
                child: const Text('SUBMIT'),
              ),
              TextButton(
                onPressed: onStepCancel,
                child: const Text('BACK'),
              ),
            ],
          );
        },
        steps: steps,
      ),
    );
  }

  void _basicValidation(VoidCallback? onStepContinue) {
    if (keys[0].currentState!.validate()) {
      print("Validating basic");
      onStepContinue!();
    }
  }

  void _coverImageValidation(VoidCallback? onStepContinue) {
    if (keys[1].currentState!.validate()) {
      safePrint("Validate");
      onStepContinue!();
    }
  }
}
