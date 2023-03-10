import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../../../gen/assets.gen.dart';
import '/config/app_theme.dart';
import '/core/responsive.dart';
import '/core/widgets/shared_safe_area_widget.dart';
import '/features/login/presentation/bloc/login/login_bloc.dart';
import '/features/login/presentation/widgets/login_widget.dart';
import '../../../../core/language.dart';
import '../../../../size_config.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';
import '../../../language/presentation/bloc/language_bloc.dart';

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
  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.chooseLanguage,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16.0),
              BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, state) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: Language.values.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          // # 1
                          // Trigger the ChangeLanguage event
                          context.read<LanguageBloc>().add(
                                ChangeLanguage(
                                  selectedLanguage: Language.values[index],
                                ),
                              );
                          Future.delayed(const Duration(milliseconds: 300))
                              .then((value) => Navigator.of(context).pop());
                        },
                        leading: ClipOval(
                          child: Language.values[index].image.image(
                            height: 32.0,
                            width: 32.0,
                          ),
                        ),
                        title: Text(Language.values[index].text),
                        trailing:
                            Language.values[index] == state.selectedLanguage
                                ? const Icon(
                                    Icons.check_circle_rounded,
                                    color: SharedColors.homerBankPrimaryColor,
                                  )
                                : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: Language.values[index] == state.selectedLanguage
                              ? const BorderSide(
                                  color: SharedColors.homerBankPrimaryColor,
                                  width: 1.5)
                              : BorderSide(color: Colors.grey[300]!),
                        ),
                        tileColor:
                            Language.values[index] == state.selectedLanguage
                                ? SharedColors.homerBankPrimaryColor
                                    .withOpacity(0.05)
                                : null,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16.0);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SharedSafeAreaWidget(
      child: Scaffold(
        backgroundColor: SharedColors.homerBankPrimaryColor,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: false,
          title: Assets.images.homerBank.image(height: 32.0),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: OutlinedButton(
                onPressed: () =>
                    showLanguageBottomSheet(context), // #2 Function call
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(8.0),
                  foregroundColor: SharedColors.homerBankGreyColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Row(
                  children: [
                    ClipOval(
                      child: BlocBuilder<LanguageBloc, LanguageState>(
                        builder: (context, state) {
                          return state.selectedLanguage.image.image();
                        },
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: SharedColors.darkPurple,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
                      /* return LoginBloc(
                        authRepository:
                            RepositoryProvider.of<AuthRepository>(context),
                      ); */
                      //return LoginBloc(RepositoryProvider.of<LogIn>(context));
                      return GetIt.I<LoginBloc>();
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
