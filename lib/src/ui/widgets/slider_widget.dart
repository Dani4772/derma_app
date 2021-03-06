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
            bottom: 15,
            left: 35,
            right: 37,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Duration'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                ),
              ),
              Text(
                '$_value:00',
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'SegoeBold',
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
            bottom: 20,
          ),
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 7, left: 1),
                child: Divider(
                  color: AppTheme.pinkColor,
                  height: 0.5,
                  thickness: 1,
                ),
              ),
              Slider(

                value: _value.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _value = value.toInt();
                  });
                  widget.sliderValueChanged(_value);
                },
                min: 1,
                max: 45,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
