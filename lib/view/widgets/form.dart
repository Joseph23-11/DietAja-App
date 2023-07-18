import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../shared/theme.dart';

class CustomFormField extends StatefulWidget {
  final String title;
  final bool obscureText;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final bool isShowTitle;
  final Function(String)? onFieldSubmitted;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;

  const CustomFormField({
    Key? key,
    required this.title,
    this.obscureText = false,
    this.controller,
    this.isShowTitle = true,
    this.onFieldSubmitted,
    this.onChange,
    required this.inputType,
    required this.validator,
    this.suffixIcon,
    this.focusNode,
    this.inputFormatters,
  }) : super(key: key);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  late bool isPasswordVisible;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    isPasswordVisible = !widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isShowTitle)
          Text(
            widget.title,
            style: blackTextStyle.copyWith(
              fontWeight: medium,
            ),
          ),
        if (widget.isShowTitle) SizedBox(height: 8),
        TextFormField(
          obscureText: widget.obscureText && !isPasswordVisible,
          controller: widget.controller,
          keyboardType: widget.inputType,
          onChanged: widget.onChange,
          validator: widget.validator,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: !widget.isShowTitle ? widget.title : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: purpleColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: greyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: purpleColor),
            ),
            contentPadding: const EdgeInsets.all(12),
            suffixIcon: widget.obscureText
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    child: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: isPasswordVisible ? purpleColor : greyColor,
                    ),
                  )
                : null,
          ),
          cursorColor: purpleColor,
          onFieldSubmitted: widget.onFieldSubmitted,
          inputFormatters: widget.inputFormatters,
        ),
      ],
    );
  }
}
