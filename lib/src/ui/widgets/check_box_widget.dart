import 'package:derma/src/base/themes.dart';
import 'package:flutter/material.dart';

import 'custom_checkbocx.dart';

class CheckBoxWidget extends StatefulWidget {
  const CheckBoxWidget({
    Key? key,
    required this.checkBoxValue,
    required this.checkBoxValueChanged,
  }) : super(key: key);

  final bool checkBoxValue;
  final Function(bool) checkBoxValueChanged;

  @override
  _CheckBoxWidgetState createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  late bool _value;

  @override
  void initState() {
    _value = widget.checkBoxValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 37.3, left: 35, right: 37),
      child: Row(
        children: [
          CustomCheckbox(
            iconSize: 30,
            isChecked: _value,
            size: 46,
            borderColor:  _value? AppTheme.blueColor:Colors.grey,
            onChange: (value){
              _value = value!;
              setState(() {

              });
              widget.checkBoxValueChanged(_value);
            },
            selectedColor: AppTheme.blueColor,
            selectedIconColor: Colors.white,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Text(
                'Massage micropulses help promote collagen production for nicer skin',
                style: TextStyle(
                  fontSize: 15,
                  color: _value?Theme.of(context).colorScheme.secondary:Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
