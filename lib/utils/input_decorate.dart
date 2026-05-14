import "package:flutter/material.dart";
import "../theme.dart";

InputDecoration buildInputDecoration({
  required String labelText,
  required String hintText,
  double borderRadius = 12,
  Color borderColor = AppTheme.secondaryColor,
  Color focusedBorderColor = AppTheme.primaryColor,
}) {
  return InputDecoration(
    labelText: labelText,
    hintText: hintText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: borderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: focusedBorderColor, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: borderColor),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  );
}
