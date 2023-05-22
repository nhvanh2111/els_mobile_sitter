import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCheckBox extends StatefulWidget {
  final bool isChecked;
  final double size;
  final double iconSize;
  final Color selectedColor;
  final Color selectedIconColor;

  CustomCheckBox(
      {required this.isChecked,
      required this.size,
      required this.iconSize,
      required this.selectedColor,
      required this.selectedIconColor});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        setState(() {
          _isSelected = !_isSelected;
        })
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: _isSelected ? widget.selectedColor : Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          border: _isSelected
              ? null
              : Border.all(
                  color: Colors.grey,
                  width: 2.0,
                ),
        ),
        width: widget.size,
        height: widget.size,
        child: _isSelected
            ? Icon(
                Icons.check,
                color: widget.selectedIconColor,
              )
            : null,
      ),
    );
  }
}
// Checkbox(
//   checkColor: Colors.white,
//   fillColor: MaterialStateProperty.resolveWith(getColor),
//   value: isChecked,
//   onChanged: (bool? value) {
//     // setState(() {
//     //   isChecked = value!;
//     // });
//   },
// ),

// bool isChecked = false;

// Color getColor(Set<MaterialState> states) {
//   const Set<MaterialState> interactiveStates = <MaterialState>{
//     MaterialState.pressed,
//     MaterialState.hovered,
//     MaterialState.focused,
//   };
//   if (states.any(interactiveStates.contains)) {
//     return Colors.blue;
//   }
//   return Colors.red;
// }
