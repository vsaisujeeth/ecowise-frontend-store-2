import 'package:ecowise_vendor_v2/Utils/constants.dart';
import 'package:flutter/material.dart';

Widget loadingButton(
    BuildContext context, VoidCallback onPressed, Widget child) {
  return Material(
    elevation: 3,
    borderRadius: BorderRadius.circular(15),
    child: GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme().primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        //width: SizeConfig.widthPercent*0.7,
        height: 50,
        width: SizeConfig.widthPercent * 80,
        child: Center(child: child),
      ),
    ),
  );
}

Widget iconButton(
    BuildContext context, VoidCallback onPressed, Widget child, Icon icon) {
  return Material(
    elevation: 3,
    borderRadius: BorderRadius.circular(15),
    child: GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme().primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        //width: SizeConfig.widthPercent*0.7,
        height: 50,
        width: SizeConfig.widthPercent * 80,
        child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                SizedBox(
                  width: 8,
                ),
                child
              ],
            )),
      ),
    ),
  );
}
