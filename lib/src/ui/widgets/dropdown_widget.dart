import 'package:derma/src/base/themes.dart';
import 'package:flutter/material.dart';

import '../../utils/const.dart';
import 'popup_menu_widget.dart' as popup;
class MyDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T selected;
  final ValueChanged<T> onChanged;

  const MyDropdown({required Key key, required this.items, required this.selected, required this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return popup. PopupMenuButton(

        onSelected: onChanged,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),

        itemBuilder: (context) {
          return items
              .map(
                (value) => popup.PopupMenuItem(
          height: 50,
              value: value,
              child: Center(child: Text(value.toString(),style: kDropDownTextStyle,)),
            ),
          )
              .toList();
        },
        offset: const Offset(0, 58),
        child: Container(
          height: 58,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppTheme.pinkColor),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          clipBehavior: Clip.antiAlias,
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: selected != null?Text('  $selected',style: kDropDownTextStyle,textAlign: TextAlign.center,):
                    Text('  Select Therapy Type'.toUpperCase(),style: kDropDownTextStyle,textAlign: TextAlign.center,),
                  ),
                  const Expanded(
                      flex: 1,
                      child: Icon(Icons.arrow_drop_down_outlined, color: AppTheme.pinkColor,size: 25,)),
                ],
              ),
            ),
          ),
        ));
  }
}

