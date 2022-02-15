import 'package:derma/src/base/assets.dart';
import 'package:derma/src/base/nav.dart';
import 'package:derma/src/ui/pages/home_page.dart';
import 'package:derma/src/ui/widgets/button_widget.dart';
import 'package:derma/src/utils/const.dart';
import 'package:flutter/material.dart';

completeDialog(BuildContext context) => AlertDialog(

      contentPadding: const EdgeInsets.fromLTRB(29, 19, 22, 31),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Session Complete!'.toUpperCase(),
            style: const TextStyle(
              color: kDescriptionTextColor,
              fontFamily: 'blackbold',
              fontSize: 18,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 22.0,
              bottom: 30,
            ),
            child: Text(
              'Your Derma app session is complete. I must say, your skin is looking fabulous!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kDescriptionTextColor,
                fontSize: 17,
              ),
            ),
          ),
          AppButton(
            title: 'I FEEL GREAT!',
            onPressed: () => AppNavigation.to(context, const HomePage()),
          ),
        ],
      ),
    );
