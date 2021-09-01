import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SimpleTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String errorText;
  final String label;
  final String initialValue;
  final FormFieldSetter<String> onSaved;
  final FormFieldSetter<String> onChanged;
  final bool showHeader;
  final bool expand;
  final bool readOnly;
  final int maxLines;
  final int maxLength;
  final Function validationError;
  final Function onTap;
  final TextAlign textAlign;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType textInputType;
  final bool obSecure;
  final Widget suffixIcon;

  const SimpleTextField({
    Key key,
    @required this.onSaved,
    this.onChanged,
    this.hintText,
    this.textAlign,
    this.errorText,
    this.initialValue,
    this.controller,
    this.inputFormatters,
    this.showHeader = true,
    this.expand = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.validationError,
    this.textInputType,
    this.obSecure = false,
    this.suffixIcon,
    this.maxLength,
    this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      obscureText: obSecure,
      controller: controller,
      enabled: onSaved != null,
      onChanged: onChanged,
      validator: validationError,
      onSaved: onSaved,
      inputFormatters: inputFormatters,
      maxLines: expand ? null : maxLines,
      keyboardType: textInputType,
      maxLength: maxLength,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
      initialValue: initialValue,
      textAlign: textAlign ?? TextAlign.start,
      readOnly: readOnly,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        labelText: label,
      ),
    );
  }
}
