import 'package:flutter/material.dart';
import 'package:stedom/utils/app_config.dart';
import 'package:stedom/utils/colors.dart';

class CustomTextField extends StatefulWidget {
  final IconData? fieldIcon;
  final FocusNode? nextFocus;
  final FocusNode currentFocus;
  final Function fieldValidator;
  final String fieldHintText;
  final TextInputAction fieldTextInputAction;
  final TextEditingController fieldController;

  const CustomTextField({
    Key? key,
    required this.fieldController,
    required this.fieldValidator,
    required this.currentFocus,
    required this.fieldHintText,
    required this.fieldTextInputAction,
    this.nextFocus,
    this.fieldIcon,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
    widget.currentFocus.addListener(_onOnFocusNodeEvent);
  }

  _onOnFocusNodeEvent() {
    setState(() {});
  }

  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return TextFormField(
      focusNode: widget.currentFocus,
      controller: widget.fieldController,
      textInputAction: widget.fieldTextInputAction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
        filled: true,
        hintText: widget.fieldHintText,
        suffixIcon: Icon(
          widget.fieldIcon,
          color: greyPrimary,
        ),
        errorStyle: const TextStyle(
          fontSize: 11.0,
        ),
        focusColor: greyDateBackground,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
            color: greyDateBackground,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
            color: greyDateBackground,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
            color: greyDateBackground,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        focusedErrorBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          color: greyPrimary,
          fontSize: 11,
        ),
      ),
      cursorColor: blackPrimary,
      keyboardType: TextInputType.text,
      style: const TextStyle(color: blackPrimary),
      validator: (value) => widget.fieldValidator(value!),
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(widget.nextFocus);
      },
    );
  }
}
