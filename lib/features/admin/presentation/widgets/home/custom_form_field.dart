import 'package:flutter/material.dart';
import 'package:rx_project/features/admin/domain/enums/form_fields_enum.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final FormFieldType field;
  final TextInputType? keyboardType;
  final int? maxLines;
  final String? initialValue;
  final TextEditingController? controller;
  final ValueChanged<String?>? onSaved;
  final FormFieldValidator<String>? validator;
  final bool enabled;

  const CustomFormField({
    super.key,
    required this.label,
    required this.field,
    this.keyboardType,
    this.maxLines = 1,
    this.initialValue,
    this.controller,
    this.onSaved,
    this.validator,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      enabled: enabled,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if (field == FormFieldType.email && !value.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;
      },
      initialValue: initialValue,
      onSaved: onSaved,
    );
  }
}
