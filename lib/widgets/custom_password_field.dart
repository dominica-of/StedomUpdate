import 'package:flutter/material.dart';
import 'package:stedom/utils/app_config.dart';
import 'package:stedom/utils/colors.dart';
import 'package:stedom/utils/constants.dart';

class CustomPasswordField extends StatefulWidget {
  final IconData fieldIcon;
  final FocusNode? nextFocus;
  final FocusNode currentFocus;
  final Function fieldValidator;
  final String fieldHintText;
  final TextInputAction fieldTextInputAction;
  final TextEditingController fieldController;

  const CustomPasswordField({
    Key? key,
    required this.fieldIcon,
    required this.fieldController,
    required this.fieldValidator,
    required this.currentFocus,
    required this.fieldHintText,
    required this.fieldTextInputAction,
    this.nextFocus,
  }) : super(key: key);

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    widget.currentFocus.addListener(_onOnFocusNodeEvent);
  }

  _onOnFocusNodeEvent() {
    setState(() {});
  }

  void _toggleObscurity() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
        suffixIcon: IconButton(
          icon: _obscureText == true
              ? const Icon(
                  Icons.visibility_outlined,
                  color: greyPrimary,
                )
              : const Icon(
                  Icons.visibility_off_outlined,
                  color: greyPrimary,
                ),
          onPressed: _toggleObscurity,
        ),
        filled: true,
        hintText: widget.fieldHintText,
        errorStyle: const TextStyle(
          fontSize: 11.0,
        ),
        focusColor: greyDateBackground,
        border: const OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
            color: greyDateBackground,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
            color: greyDateBackground,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(
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
          color: blackPrimary,
        ),
      ),
      cursorColor: primaryColor,
      keyboardType: TextInputType.text,
      style: const TextStyle(color: blackPrimary),
      validator: (value) => widget.fieldValidator(value!),
      obscureText: _obscureText,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(widget.nextFocus);
      },
    );
  }
}
