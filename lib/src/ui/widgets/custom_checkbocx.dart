import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final Function onChange;
  final bool isChecked;
  final double size;
  final double iconSize;
  final Color selectedColor;
  final Color selectedIconColor;
  final Color borderColor;

  CustomCheckbox(
      {required this.isChecked,
        required this.onChange,
        required this.size,
        required this.iconSize,
        required this.selectedColor,
        required this.selectedIconColor,
        required this.borderColor,
        });

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onChange(_isSelected);
        });
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.all(4),
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
            color: _isSelected
                ? widget.selectedColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: widget.borderColor,
              width: 1.5,
            )),
        width: widget.size ,
        height: widget.size ,
        padding: const EdgeInsets.fromLTRB(11.3, 14, 10.1, 11),
        child: _isSelected
            ? Image.asset('assets/tick.png',)
            : null,
      ),
    );
  }
}