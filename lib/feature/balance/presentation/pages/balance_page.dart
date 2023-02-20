import 'package:flutter/material.dart';

import '../../../../size_config.dart';
import '../../../home/presentasion/pages/components/home_header.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text('test')
            //SizedBox(height: getProportionateScreenWidth(20)),
            //const HomeHeader(),
            //SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
