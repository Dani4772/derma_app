import 'package:derma/src/base/themes.dart';
import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({
    Key? key,
    required this.sliderValue,
    required this.sliderValueChanged,
  }) : super(key: key);

  final int sliderValue;
  final Function(int) sliderValueChanged;

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.sliderValue;
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = AppTheme.pinkColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 20.5,
            left: 35,
            right: 37,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Duration'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 18,
                  color: primaryColor,
                ),
              ),
              Text(
                '$_value:00',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 35,
            right: 37,
            bottom: 32.5,
          ),
          child: Slider(
            value: _value.toDouble(),
            onChanged: (value) {
              setState(() {
                _value = value.toInt();
              });
              widget.sliderValueChanged(_value);
            },
            min: 0,
            max: 15,
          ),
        ),
      ],
    );
  }
}
