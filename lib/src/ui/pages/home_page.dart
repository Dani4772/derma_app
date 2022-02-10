import 'package:derma/src/base/assets.dart';
import 'package:derma/src/base/nav.dart';
import 'package:derma/src/base/themes.dart';
import 'package:derma/src/ui/pages/session_page.dart';
import 'package:derma/src/ui/widgets/button_widget.dart';
import 'package:derma/src/ui/widgets/check_box_widget.dart';
import 'package:derma/src/ui/widgets/slider_widget.dart';
import 'package:derma/src/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loading_session_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final Map<String, String> _treatments = {
    'Combination Therapy':
    'Red Light Therapy (650NM) combined with Blue Light Therapy (430NM) defies aging, acne and most other skin problems by promoting a full range of skin health benefits',
    'Aging Therapy':
    'Red Light Therapy (650NM) reduces the appearance of wrinkles, increases collagen and elastin production and boosts blood circulation to smooth your skin and defy aging.',
    'Acne Therapy':
    'Blue Light Therapy (430NM) is an advanced, painless acne treatment that improves skin texture, minimizes enlarged oil glands and reduces the appearance of acne scars.',
  };
  String? _selectedTreatment;
  int _sliderValue = 1;
  bool _vibrationEnabled = false;
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    const primaryColor = AppTheme.pinkColor;
    final _padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0 + _padding.top),
        child: Container(
          padding: EdgeInsets.only(
            bottom: 28,
            top: 32 + _padding.top,
          ),
          color: Colors.white,
          child: Image.asset(
            Assets.logo,
            height: 40,
            width: 153,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 218,
              width: double.infinity,
              color: Colors.black,
              alignment: Alignment.center,
              child: Container(
                height: 89,
                width: 89,
                // alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff707070),
                ),
                // padding: const EdgeInsets.fromLTRB(33, 22.5, 23, 20.5),
                child: const Icon(
                  Icons.play_arrow,
                  size: 70,
                  color: primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 37, 37, 18),
              child: DropdownButtonFormField<String>(
                value: _selectedTreatment,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: primaryColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: primaryColor,
                    ),
                  ),
                ),
                items: _treatments
                    .map((therapyType, therapyDescription) {
                  return MapEntry(
                    therapyType,
                    DropdownMenuItem<String>(
                      value: therapyType,
                      child: Center(
                        child: Text(
                          therapyType,
                          style: kDropDownTextStyle,
                        ),
                      ),
                    ),
                  );
                })
                    .values
                    .toList(),
                iconSize: 25,
                iconDisabledColor: primaryColor,
                iconEnabledColor: primaryColor,
                hint: const Center(
                  child: Text(
                    'SELECT TREATMENT TYPE',
                    style: kDropDownTextStyle,
                  ),
                ),
                isExpanded: true,
                onChanged: (newValue) {
                  setState(() {
                    _selectedTreatment = newValue!;
                  });
                  debugPrint(_selectedTreatment);
                },
              ),
            ),
            SliderWidget(
              sliderValue: _sliderValue,
              sliderValueChanged: (value) {
                _sliderValue = value;
              },
            ),
            CheckBoxWidget(
              checkBoxValue: _vibrationEnabled,
              checkBoxValueChanged: (value) {
                _vibrationEnabled = value;
              },
            ),
            //
            if (_selectedTreatment != null) ...[
              Text(
                'Description of Treatment'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'SegoeBold',
                  color: kDescriptionTextColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 35.0,
                  right: 37,
                  top: 22,
                  bottom: 22,
                ),
                child: Text(
                  _treatments[_selectedTreatment]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: kDescriptionTextColor,
                    fontSize: 17,
                  ),
                ),
              ),
              RichText(
                text: const TextSpan(
                  text: 'Learn More at ',
                  style: TextStyle(
                    fontSize: 18,
                    color: kDescriptionTextColor,
                  ),
                  children: [
                    TextSpan(
                      text: 'DermaApp.io',
                      style: TextStyle(
                        color: kDescriptionTextColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.only(
                bottom: 40,
                left: 36,
                right: 36,
                top: 27,
              ),
              child: AppButton(
                title: '',
                child: Row(children: [
                  Text(
                    'Start'.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    CupertinoIcons.chevron_forward,
                    size: 18,
                  ),
                ], mainAxisAlignment: MainAxisAlignment.center),
                onPressed: _startAction,
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _startAction() {
    if (_selectedTreatment == null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select Therapy Type')),
      );
      return;
    }
    AppNavigation.to(
      context,
      LoadingSession(
        time: _sliderValue * 60,
        vibrationEnabled: _vibrationEnabled,
        treatmentType: _selectedTreatment!,
      ),
    );
  }
}

















