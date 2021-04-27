import 'package:crowdfund_app/widgets/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicSetupSection extends StatefulWidget {
  final GlobalKey<FormState>? formKey;

  const BasicSetupSection({Key? key, this.formKey}) : super(key: key);
  @override
  _BasicSetupSectionState createState() => _BasicSetupSectionState();
}

class _BasicSetupSectionState extends State<BasicSetupSection> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
            VTextFormField(
              inputType: TextInputType.multiline,
              controller: _titleController,
              title: "Title",
              validator: (val) {
                if (val.isEmpty) {
                  return "Provide title for your project";
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            VTextFormField(
              inputType: TextInputType.multiline,
              controller: _descriptionController,
              title: "Description",
              maxLine: 5,
              validator: (val) {
                if (val.isEmpty) {
                  return "Provide title for your project";
                }
                return null;
              },
            ),
          ],
        ));
  }
}
