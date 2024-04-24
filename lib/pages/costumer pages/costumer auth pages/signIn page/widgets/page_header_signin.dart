import 'package:bunya_app/helper/colors.dart';
import 'package:bunya_app/helper/extintion.dart';
import 'package:bunya_app/helper/sized.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageHeaderSignIn extends StatelessWidget {
  const PageHeaderSignIn({
    super.key,
    required this.bottomText,
    required this.height,
    this.showImage = true,
    this.canGoBack = false,
    this.showActionButton,
    this.onActionTap,
    this.actionButtonIcon,
  });
  final String bottomText;
  final double height;
  final bool? showImage;
  final bool? canGoBack;
  final bool? showActionButton;
  final Icon? actionButtonIcon;
  final Function()? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(),
      height: height,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(60),
          ),
          gradient: LinearGradient(
              colors: [whiteBrown, freewhiteBrown],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20.0, bottom: 10, left: 16, right: 16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              gapH20,
              Image.asset(
                'assets/images/bunya_logo.png',
                height: context.getHeight() / 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  showActionButton ?? false
                      ? IconButton(
                          onPressed: onActionTap, icon: actionButtonIcon!)
                      : sizedBoxEmpty,
                  (canGoBack!)
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                              onPressed: () {
                                context.popNav();
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: whiteColor,
                              )),
                        )
                      : sizedBoxEmpty,
                ],
              ),
              // (showImage!) ? gapH15 : sizedBoxEmpty,
              // (showImage!) ? Image.asset(
              //   'assets/images/splashscreenlogo.png',
              //   width: 120,
              // ) : sizedBoxEmpty,
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  bottomText,
                  style: const TextStyle(
                      // color: blackColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              )
            ]),
      ),
    );
  }
}
