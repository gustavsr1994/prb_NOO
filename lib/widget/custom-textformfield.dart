import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomTextFormField extends StatefulWidget {
  final String validator;
  final TextEditingController controller;
  final String hintText;
  final MaskTextInputFormatter formatter;
  final TextInputType keyboardType;
  const CustomTextFormField({Key key, this.validator, this.controller, this.hintText, this.formatter, this.keyboardType}) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    final focus = FocusNode();
    return Container(
        child: Expanded(
          child: TextFormField(
            inputFormatters: [
              widget.formatter,
            ],
            textCapitalization: TextCapitalization.words,
            focusNode: focus,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return widget.validator;
              }
              return null;
            },
            textAlign: TextAlign.center,
            controller: widget.controller,
            keyboardType: TextInputType.text,
            autofocus: false,
            decoration: InputDecoration(
              isDense: true,
              hintText: widget.hintText,
              filled: true,
              contentPadding: EdgeInsets.all(5),
            ),
          ),
        )
    );
  }
}
