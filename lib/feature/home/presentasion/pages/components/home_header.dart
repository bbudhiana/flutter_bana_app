import 'package:flutter/material.dart';

import '../../../../../size_config.dart';
import 'icon_button_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SerchField(),
          IconBtnWithCounter(
            svgScr: "assets/icons/Cart Icon.svg",
            numOfItems: 0,
            press: () {},
          ),
          IconBtnWithCounter(
            svgScr: "assets/icons/Bell.svg",
            numOfItems: 3,
            press: () {},
          ),
        ],
      ),
    );
  }
}
