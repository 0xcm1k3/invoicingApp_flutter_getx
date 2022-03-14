// ignore_for_file: camel_case_types

import 'package:fatura_app/constants/colors.dart';
import 'package:fatura_app/env/dimensions.dart';
import 'package:fatura_app/screens/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OptionView_eng extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String? optionalText;
  final Widget? leading;
  final bool showArrow;
  final bool isComplete;
  final Function() onTap;
  const OptionView_eng({
    required this.title,
    required this.onTap,
    this.subTitle,
    this.optionalText,
    this.leading,
    this.showArrow = true,
    this.isComplete = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (!showArrow || isComplete) ? null : onTap,
      splashColor: AppColors.kPrimaryLight,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: Dimensions.calcH(8), horizontal: Dimensions.calcW(8)),
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.calcH(5), horizontal: Dimensions.calcW(8)),
        height: Dimensions.calcH(100),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (leading != null)
                ? Container(
                    margin: EdgeInsets.only(
                      right: Dimensions.calcW(15),
                    ),
                    padding: EdgeInsets.all(Dimensions.calcH(10)),
                    width: 55,
                    child: leading,
                  )
                : const Text(""),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            text: title,
                            align: TextAlign.left,
                            fontSize: Dimensions.calcH(19),
                            weight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.calcH(5),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            text: subTitle ?? "",
                            align: TextAlign.left,
                            fontSize: Dimensions.calcH(17),
                            weight: FontWeight.w600,
                            color: Colors.grey.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            text: optionalText ?? "",
                            align: TextAlign.left,
                            fontSize: Dimensions.calcH(17),
                            weight: FontWeight.w600,
                            color: Colors.grey.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            (showArrow)
                ? Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(
                        "assets/icons/arrow_right.svg",
                        height: 30,
                      ),
                    ),
                  )
                : const Text(""),
            (isComplete && !showArrow)
                ? Expanded(
                    child: SvgPicture.asset(
                      "assets/icons/success_circle.svg",
                      height: 30,
                      color: Colors.green[600],
                    ),
                  )
                : const Text(""),
          ],
        ),
      ),
    );
  }
}
