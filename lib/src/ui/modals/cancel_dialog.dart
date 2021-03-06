
import 'package:derma/src/ui/widgets/button_widget.dart';
import 'package:derma/src/utils/const.dart';
import 'package:flutter/material.dart';

Future<bool> cancelDialog(BuildContext context)async {
 return await showDialog(
barrierColor: Colors.black,
   context: context,
    builder: (ctx) => AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(29, 45, 22, 37),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'ARE YOU SURE YOU WANT TO CANCEL THIS SESSION?',
            textAlign: TextAlign.center,
            style: TextStyle(
             fontFamily: 'blackbold',
              fontSize: 17,
              color: kDescriptionTextColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 22.0, bottom: 24),
            child: AppButton(
              title: 'YES, CANCEL NOW!',
              onPressed: () =>
                Navigator.of(context).pop(true),

            ),
          ),
          InkWell(
            child: const Text(
              'No, I will continue the session',
              style: TextStyle(
                color: Color(0xFF29B6EF),
                decoration: TextDecoration.underline,
                fontSize: 17,
              ),
            ),
            onTap:()=> Navigator.of(context).pop(false),
          ),
        ],
      ),
    ),
  )?? false;
}
