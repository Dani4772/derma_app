import 'package:derma/src/base/themes.dart';
import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.only(bottom: 20, left: 35, right: 37),
      child: Row(
        children: [
          Transform.scale(
            scale: 2.5,
            child: Checkbox(
              side: BorderSide(color: _value? AppTheme.blueColor:AppTheme.pinkColor,width: 0.5),
              value: _value,
              onChanged: (value) {
                setState(() {
                  _value = value!;
                });
                widget.checkBoxValueChanged(_value);
              },
            ),
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
