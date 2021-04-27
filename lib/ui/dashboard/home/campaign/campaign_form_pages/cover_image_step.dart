import 'package:crowdfund_app/constants/app_size.dart';
import 'package:crowdfund_app/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class CoverImageStep extends StatefulWidget {
  final GlobalKey<FormState>? formKey;

  const CoverImageStep({Key? key, this.formKey}) : super(key: key);
  @override
  _CoverImageStepState createState() => _CoverImageStepState();
}

class _CoverImageStepState extends State<CoverImageStep> {
  final TextEditingController _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: EdgeInsets.only(top: kPadding),
        child: VTextFormField(
            title: "Cover Image URL",
            inputType: TextInputType.url,
            controller: _imageController,
            validator: (val) {
              if (val.isEmpty) return "Provide cover image link";
              return null;
            }),
      ),
    );
  }
}
