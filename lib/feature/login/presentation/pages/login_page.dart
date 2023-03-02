import 'package:flutter_bana_app/feature/authentication/domain/usecase/log_in.dart';

import '../../../authentication/domain/repositories/auth_repository.dart';

import '/feature/login/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../size_config.dart';
import '/config/app_theme.dart';
import '/core/responsive.dart';
import '/util/images.dart';
import 'package:flutter/material.dart';
import '/core/widgets/shared_safe_area_widget.dart';
import '/feature/login/presentation/widgets/login_widget.dart';
import '/util/colors.dart';

class LoginPage extends StatefulWidget {
  //static const String route = "login_page";

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SharedSafeAreaWidget(
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
                child: SingleChildScrollView(
                  child: BlocProvider(
                    create: (context) {
                      return LoginBloc(
                        authRepository:
                            RepositoryProvider.of<AuthRepository>(context),
                      );
                      //return LoginBloc(RepositoryProvider.of<LogIn>(context));
                    },
                    child: const LoginWidget(),
                    //child: const Text('test'),
                  ),
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
                  //child: LoginWidget(),
                  child: Text('Not Available'),
                ))
              ],
            )),
      ),
    );
  }
}
