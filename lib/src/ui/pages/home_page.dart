import 'package:derma/src/base/assets.dart';
import 'package:derma/src/base/nav.dart';
import 'package:derma/src/base/themes.dart';
import 'package:derma/src/ui/pages/loading_session_page.dart';
import 'package:derma/src/ui/widgets/button_widget.dart';
import 'package:derma/src/ui/widgets/check_box_widget.dart';
import 'package:derma/src/ui/widgets/dropdown_widget.dart';
import 'package:derma/src/ui/widgets/slider_widget.dart';
import 'package:derma/src/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, String> _treatments = {
    'Combination Therapy'.toUpperCase():
        'Red Light Therapy (650NM) combined with Blue Light Therapy (430NM) defies aging, acne and most other skin problems by promoting a full range of skin health benefits.',
    'Anti-aging Therapy'.toUpperCase():
        'Red Light Therapy (650NM) reduces the appearance of wrinkles, increases collagen and elastin production and boosts blood circulation to smooth your skin and defy aging.',
    'Acne Therapy'.toUpperCase():
        'Blue Light Therapy (430NM) is an advanced, painless acne treatment that improves skin texture, minimizes enlarged oil glands and reduces the appearance of acne scars.',
  };

  String? _selectedTreatment;
  int _sliderValue = 15;
  bool _vibrationEnabled = false;
  void launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

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
            height: 30,
            width: 133,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 218,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.black,

                //   image: DecorationImage(
                //   image: AssetImage('assets/video.png',),
                //     fit: BoxFit.cover
                // )
              ),
              child: Container(
                height: 89,
                width: 89,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  size: 70,
                  color: primaryColor,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(35, 44, 37, 18),
            //   child: DropdownButtonFormField<String>(
            //     value: _selectedTreatment,
            //     decoration: InputDecoration(
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //         borderSide: const BorderSide(
            //           width: 1,
            //           color: primaryColor,
            //         ),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //         borderSide: const BorderSide(
            //           width: 1,
            //           color: primaryColor,
            //         ),
            //       ),
            //     ),
            //     items: _treatments
            //         .map((therapyType, therapyDescription) {
            //       return MapEntry(
            //         therapyType,
            //         DropdownMenuItem<String>(
            //           value: therapyType,
            //           child: Center(
            //             child: Text(
            //               therapyType,
            //               style: kDropDownTextStyle,
            //             ),
            //           ),
            //         ),
            //       );
            //     })
            //         .values
            //         .toList(),
            //     iconSize: 25,
            //     iconDisabledColor: primaryColor,
            //     iconEnabledColor: primaryColor,
            //     hint: const Center(
            //       child:  Text(
            //         'SELECT TREATMENT TYPE',
            //         style: kDropDownTextStyle,
            //         // style: TextStyle(color: AppTheme.pinkColor),
            //       ),
            //     ),
            //     isExpanded: true,
            //     onChanged: (newValue) {
            //       setState(() {
            //         _selectedTreatment = newValue!;
            //       });
            //     },
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.fromLTRB(35, 44, 37, 18),
              child: MyDropdown(

                key: UniqueKey(),
                items: _treatments
                    .map((therapyType, therapyDescription) {
                      return MapEntry(
                        therapyType, therapyType,
                      );
                    })
                    .values
                    .toList(),
                selected: _selectedTreatment,
                onChanged: (newValue) {
                  setState(() {
                    _selectedTreatment = newValue.toString();
                  });
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
            if (_selectedTreatment == null)
              Image.asset(
                'assets/thearpy.png',
                scale: 2.5,
              ),
            if (_selectedTreatment != null) ...[
              const Text(
                'DESCRIPTION OF TREATMENT',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'blackbold',
                  color: kDescriptionTextColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 35.0,
                  right: 37,
                  top: 15,
                  bottom: 20,
                ),
                child: Text(
                  _treatments[_selectedTreatment]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: kDescriptionTextColor,
                    fontSize: 15,
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 15.0),
              //   child: RichText(
              //     text:  TextSpan(
              //      // text: 'Learn More at ',
              //       style: const TextStyle(
              //         fontSize: 16,
              //         color: kDescriptionTextColor,
              //       ),
              //       children: [
              //         TextSpan(
              //           text: 'DermaApp.io',
              //           recognizer: TapGestureRecognizer()
              //             ..onTap = () => launchURL(
              //               'http://dermaapp.io/',
              //             ),
              //
              //           style: const TextStyle(
              //             color: kDescriptionTextColor,
              //             decoration: TextDecoration.underline,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
            // const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: _selectedTreatment != null
          ? Padding(
              padding: EdgeInsets.fromLTRB(35, 0, 37, _padding.bottom + 10),
              child: AppButton(
                title: '',
                child: Row(children: [
                  Text(
                    'Start'.toUpperCase(),
                    style: const TextStyle(
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
            )
          : const SizedBox(),
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
