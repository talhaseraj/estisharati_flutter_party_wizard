import 'package:flutter/material.dart';

import 'package:party_wizard/utils/app_colors.dart';

class CustomInputField extends StatefulWidget {
  final IconData icon;
  final String hint;
  final bool obsecure;
  final validator;

  final TextEditingController controller;
  final Function onChanged;
  const CustomInputField({
    required this.validator,
    required this.onChanged,
    required this.controller,
    super.key,
    required this.icon,
    required this.hint,
    required this.obsecure,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _passVis = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        onChanged: (text) {
          widget.onChanged();
        },
        obscureText: widget.obsecure ? _passVis : false,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: widget.hint,
          hintStyle: TextStyle(color: AppColors.hintColor),
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: AppColors.c_fff8f3,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              widget.icon,
              color: AppColors.primaryColor,
            ),
          ),
          suffixIcon: widget.obsecure
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _passVis = !_passVis;
                    });
                  },
                  icon: Icon(_passVis
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined))
              : const SizedBox.shrink(),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.c_eeeeee, width: 2),
            borderRadius: BorderRadius.circular(14),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 5),
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
