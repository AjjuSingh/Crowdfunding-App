import 'package:crowdfund_app/_utils/safe_print.dart';
import 'package:crowdfund_app/widgets/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CampaignDetailStep extends StatefulWidget {
  final GlobalKey<FormState>? formKey;

  const CampaignDetailStep({Key? key, this.formKey}) : super(key: key);
  @override
  _CampaignDetailStepState createState() => _CampaignDetailStepState();
}

class _CampaignDetailStepState extends State<CampaignDetailStep> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _fundController = TextEditingController();

  /// Current date
  late DateTime currentTime;

  @override
  void initState() {
    currentTime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: VTextFormField(
                    inputType: TextInputType.multiline,
                    controller: _dateController,
                    title: "Due Date",
                    enabled: false,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Provide end date for your campaign";
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      await showBarModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: 250,
                              child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.date,
                                  maximumYear: DateTime.now().year + 5,
                                  minimumYear: DateTime.now().year,
                                  onDateTimeChanged: (date) {
                                    setState(() {
                                      _dateController.text = date.toString();
                                    });
                                  }),
                            );
                          });
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            VTextFormField(
              inputType: TextInputType.number,
              controller: _fundController,
              title: "Funding Target",
              hintText: "Enter the amount of fund you have a target",
              prefixText: "\u{20B9}",
              validator: (val) {
                if (val.isEmpty) {
                  return "Provide the amount";
                }
                return null;
              },
            ),
          ],
        ));
  }
}
