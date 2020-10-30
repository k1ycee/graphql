import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFields extends StatefulWidget {
  final String hint;
  final double fontSize;
  final FontWeight fontWeight;
  final Widget prefix;
  final double styleFontSize;
  final TextInputType textInputType;
  final TextEditingController controller;
  final TextInputAction inputAction;
  final FocusNode focusNode;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> onChanged;
  final Function editingComplete;
  final Widget suffix;
  final bool obscure;
  final bool enabled;
  final InputBorder underlineBorder;
  final InputBorder errorBorder;

  const TextFields(
      {Key key,
      @required this.hint,
      this.fontSize,
      this.fontWeight,
      this.prefix,
      this.styleFontSize,
      this.textInputType,
      @required this.controller,
      this.inputAction,
      this.focusNode,
      this.validator,
      this.onSubmitted,
      this.onChanged,
      this.suffix,
      this.editingComplete,
      this.obscure = false,
      this.underlineBorder,
      this.enabled = true,
      this.errorBorder})
      : super(key: key);

  @override
  _TextFieldsState createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  bool isPasswordVisible;

  @override
  void initState() {
    super.initState();
    isPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !isPasswordVisible && widget.obscure,
      onEditingComplete: widget.editingComplete,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      validator: widget.validator,
      focusNode: widget.focusNode,
      controller: widget.controller,
      style: GoogleFonts.poppins(
        fontSize: widget.fontSize,
        color: Colors.greenAccent[700],
      ),
      keyboardType: widget.textInputType,
      textInputAction: widget.inputAction,
      decoration: InputDecoration(
        errorBorder: widget.errorBorder,
        enabled: widget.enabled,
        prefixIconConstraints: BoxConstraints(maxHeight: 20),
        prefixIcon: widget.prefix,
        suffix: widget.suffix,
        fillColor: Colors.white,
        isDense: true,
        labelText: widget.hint,
        alignLabelWithHint: true,
        enabledBorder: widget.underlineBorder,
        focusedBorder: widget.underlineBorder,
        contentPadding: EdgeInsets.only(bottom: 12.0),
        labelStyle: GoogleFonts.poppins(
          color: Colors.greenAccent[700],
          fontSize: widget.styleFontSize,
          fontWeight: widget.fontWeight,
        ),
        suffixIcon: widget.obscure ? IconButton(
          icon:
              Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
          color: isPasswordVisible ? Colors.grey[800] : Colors.greenAccent,
        ) : null,
      ),
    );
  }
}