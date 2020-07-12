import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final hintText;
  final txtInputType;
  final onChanged;
  final initialValue;

  CustomInputField(
      {this.hintText, this.txtInputType, this.onChanged, this.initialValue});

  @override
  State<StatefulWidget> createState() => _CustomInputField();
}

class _CustomInputField extends State<CustomInputField> {
  TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller =
        TextEditingController(text: widget.initialValue?.toString() ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: widget.onChanged,
      keyboardType: widget.txtInputType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
