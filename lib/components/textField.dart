import 'package:flutter/material.dart';

class TextFieldForm extends StatelessWidget {
  final textController;
  final labelText;
  final hintText;
  final keyType;

  const TextFieldForm(
      {Key key,
      this.textController,
      this.labelText,
      this.hintText,
      this.keyType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.only(bottom: 10),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff007aff),
          ),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffdddddd),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffdddddd),
          ),
        ),
        labelText: labelText,
        hintText: hintText,
      ),
      keyboardType: keyType,
    );
  }
}
