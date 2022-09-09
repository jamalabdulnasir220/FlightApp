import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dimensions/dimensions.dart';

class AppTextField extends StatelessWidget {
  // final TextEditingController textController;
  final onChanged;
  final String hintText;
  final IconData icon;
  const AppTextField(
      {Key? key,
      required this.onChanged,
      // required this.textController,
      required this.hintText,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimensions.height20, right: Dimensions.height20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 7,
                offset: Offset(0, 10),
                color: Colors.grey.withOpacity(0.2))
          ]),
      child: TextField(
        keyboardType: hintText.startsWith("e")
            ? TextInputType.emailAddress
            : TextInputType.visiblePassword,
        onChanged: onChanged,
        // controller: textController,
        decoration: InputDecoration(
          // hint Text
          hintText: hintText,
          // prefix icon
          prefixIcon: Icon(
            icon,
            color: Colors.blueGrey,
          ),
          //focused border
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              borderSide: BorderSide(width: 1.0, color: Colors.white)),
          // enabled border
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              borderSide: BorderSide(width: 1.0, color: Colors.white)),
          // border
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
          ),
        ),
      ),
    );
  }
}
