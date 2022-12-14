import 'package:flutter/material.dart';

class WidgetComponent {
  static TextButton flatButton({
    required Widget buttons,
    required Color colors,
    VoidCallback? onPressed,
  }) =>
      TextButton(
        child: buttons,
        // color: colors,
        onPressed: onPressed,
      );
  static TextFormField formField({
    String? hints,
    required String label,
    Widget? suffix,
    required Widget prefix,
    required InputBorder borders,
    bool secure: false,
    bool autocorrent: true,
    Icon? icon,
    bool enables = true,
    TextInputType? inputType,
    required TextEditingController controllers,
    FormFieldValidator? valids,
  }) =>
      TextFormField(
        enabled: enables,
        validator: valids,
        obscureText: secure,
        keyboardType: inputType,
        autocorrect: autocorrent,
        controller: controllers,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          border: borders,
          icon: icon,
          labelText: label,
          hintText: hints,
          suffixIcon: suffix,
          prefixIcon: prefix,
        ),
      );

  static RawMaterialButton buttons(
    String label, {
    double? size,
    required double elevas,
    required double radius,
    bool loading = false,
    required Color coloring,
    required Color textColor,
    required FontWeight bolds,
    required EdgeInsetsGeometry padding,
    VoidCallback? onPressed,
  }) =>
      RawMaterialButton(
          elevation: elevas,
          padding: padding,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          fillColor: coloring,
          child: loading
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  label,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: bolds,
                      fontSize: size,
                      fontFamily: "Gilroy-Regular"),
                ),
          onPressed: onPressed);

  static ListTile listiles(
    String titles, {
    required IconData leads,
    required IconData icons,
    VoidCallback? onPressed,
  }) =>
      ListTile(
        leading: Icon(leads),
        title: Text(
          titles,
          style: TextStyle(fontFamily: "Gilroy-Regular"),
        ),
        onTap: onPressed,
        trailing: IconButton(icon: Icon(icons), onPressed: onPressed),
      );
}
