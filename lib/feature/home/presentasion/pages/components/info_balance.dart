import 'package:flutter/material.dart';
import 'package:flutter_bana_app/util/colors.dart';

import '../../../../../size_config.dart';

class InfoBalance extends StatelessWidget {
  const InfoBalance({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenWidth(15),
      ),
      width: double.infinity,
      height: getProportionateScreenHeight(250),
      decoration: BoxDecoration(
        color: SharedColors.homerBankPrimaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text.rich(
            TextSpan(
              text: "Welcome home\n",
              style: TextStyle(color: Colors.white),
              children: [
                TextSpan(
                  text: "Your Deposite Today:",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenWidth(30)),
          const Center(
            child: Text.rich(
              TextSpan(
                style: TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    text: "1000",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
