import 'package:ajithkumar_interview/constants/appColors.dart';
import 'package:flutter/material.dart';

class CustomDropDownButtonFormField extends StatelessWidget {
  final List<String>? dropDownList;
  final String? hintText;
  final double? height;
  final double? width;

  const CustomDropDownButtonFormField(
      {super.key, this.dropDownList, this.hintText, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: width ?? 200,
      child: DropdownButtonFormField(
        isExpanded: true,
        decoration: InputDecoration(
          border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: AppColors.lightWhite,
        ),
        hint: Text(hintText ?? ''),
        items: dropDownList?.map((e) {
              return DropdownMenuItem(value: e, child: Text(e));
            }).toList() ??
            [],
        onChanged: (value) {},
      ),
    );
  }
}
