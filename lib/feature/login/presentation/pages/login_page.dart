import '../../../../size_config.dart';
import '/config/app_theme.dart';
import '/core/responsive.dart';
import '/util/images.dart';
import 'package:flutter/material.dart';
import '/core/widgets/shared_safe_area_widget.dart';
import '/feature/login/presentation/widgets/login_widget.dart';
import '/util/colors.dart';

class LoginPage extends StatefulWidget {
  static const String route = "login_page";

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        return Future<bool>.value(true);
      },
      child: SharedSafeAreaWidget(
        child: Scaffold(
          backgroundColor: SharedColors.homerBankPrimaryColor,
          resizeToAvoidBottomInset: true,
          body: Responsive(
              mobile: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: ApplicationDefaultPixel.maxWidth,
                    maxHeight: ApplicationDefaultPixel.maxHeight,
                    minWidth: ApplicationDefaultPixel.minWidth,
                    minHeight: ApplicationDefaultPixel.minHeight),
                child: Container(
                  color: SharedColors.homerBankPrimaryColor,
                  alignment: Alignment.center,
                  child: const SingleChildScrollView(
                    child: LoginWidget(),
                  ),
                ),
              ),
              desktop: Row(
                children: [
                  Expanded(
                      child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: const Center(
                      child: SharedImagesPageSplash.homerBankImageLogoSplash,
                    ),
                  )),
                  const Expanded(
                      child: SingleChildScrollView(
                    child: LoginWidget(),
                  ))
                ],
              )),
        ),
      ),
    );
  }
}
