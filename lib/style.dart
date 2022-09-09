import 'package:flutter/material.dart';

InputDecoration dropDownDecoration({String hintText = ""}) => InputDecoration(
      contentPadding: EdgeInsets.all(6),
      errorStyle: TextStyle(
        color: Colors.redAccent,
      ),
      hintStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black54,
      ),
      hintText: hintText,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.blue,
          width: 2,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.blue,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      // suffixIcon: suffixIcon,
      // prefixIcon: showPrefixIcon
      //     ? Padding(
      //         child: IconTheme(
      //           data: IconThemeData(color: prefixIconColor),
      //           child: prefixIcon!,
      //         ),
      //         padding: EdgeInsets.only(
      //           left: prefixIconPaddingLeft,
      //           right: prefixIconPaddingRight,
      //           top: prefixIconPaddingTop,
      //           bottom: prefixIconPaddingBottom,
      //         ),
      //       )
      //     : null,
    );
