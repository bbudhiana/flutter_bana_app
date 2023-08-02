import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '/features/login/presentation/bloc/login/login_bloc.dart';
import '/features/login/presentation/models/models.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';
import '../../../home/presentasion/pages/home_main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          //if (state.status.isSubmissionFailure) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.responseMessage),
                  backgroundColor: const Color.fromARGB(255, 211, 45, 23),
                ),
              );
            //} else if (state.status.isSubmissionSuccess) {
          } else if (state.status.isSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.responseMessage),
                  backgroundColor: Colors.green,
                ),
              );
            Navigator.pushReplacementNamed(context, HomeMain.routeString);
          }
        },
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 10)),
            SharedImagesPageLogin.homerBankImageLogoTitle,
            const Padding(padding: EdgeInsets.only(top: 20)),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 14),
              height: 368,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: const [
                  _EmailInput(),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  _PasswordInput(),
                  Padding(padding: EdgeInsets.only(top: 24)),
                  _LoginButton(),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 24)),
          ],
        ));
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                //"Username",
                l10n.username,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  //color: state.name.invalid
                  color: state.name.isValid ? SharedColors.homerBankDangerColor : Colors.black,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 8)),
            Material(
              elevation: 2.0,
              shadowColor: Colors.grey,
              borderRadius: BorderRadius.circular(8.0),
              child: TextField(
                key: const Key('loginForm_NameInput_textField'),
                onChanged: (name) => context.read<LoginBloc>().add(LoginNameChanged(name)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: SharedColors.homerBankWhiteColor,
                  hintText: "alice or bob",
                  hintStyle: const TextStyle(color: SharedColors.homerBankGreyColor, fontSize: 14, fontWeight: FontWeight.w400),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    //borderSide: state.name.invalid
                    borderSide: state.name.isNotValid ? const BorderSide(color: SharedColors.homerBankDangerColor, width: 2.0) : BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    //borderSide: state.name.invalid
                    borderSide: state.name.isNotValid
                        ? const BorderSide(color: SharedColors.homerBankDangerColor, width: 2.0)
                        : const BorderSide(color: SharedColors.homerBankWhiteColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: SharedColors.homerBankPrimaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  // errorText:
                  //     state.email.invalid ? _getErrorEmail(state.email.error) : null,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                //state.name.invalid ? _getErrorName(state.name.error) : '',
                state.name.isNotValid ? _getErrorName(state.name.error) : '',
                style: TextStyle(
                  fontSize: 10,
                  //color: state.name.invalid
                  color: state.name.isNotValid ? SharedColors.homerBankDangerColor : Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _getErrorName(NameValidationError? err) {
    switch (err) {
      case NameValidationError.empty:
        return "user can\'t be empty";
      default:
        return "";
    }
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password || previous.visibility != current.visibility,
      builder: (context, state) {
        return Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                //"Password",
                l10n.password,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  //color: state.password.invalid
                  color: state.password.isNotValid ? SharedColors.homerBankDangerColor : Colors.black,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 8)),
            Material(
              elevation: 2.0, // Set here what you wish!
              shadowColor: Colors.grey,
              borderRadius: BorderRadius.circular(8.0),
              child: TextField(
                key: const Key('loginForm_passwordInput_textField'),
                onChanged: (password) => context.read<LoginBloc>().add(LoginPasswordChanged(password)),
                obscureText: !state.visibility,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white70,
                  hintText: "alice123 or bob123",
                  hintStyle: const TextStyle(color: SharedColors.homerBankGreyColor, fontSize: 14),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    //borderSide: state.password.invalid
                    borderSide: state.password.isNotValid ? const BorderSide(color: SharedColors.homerBankDangerColor, width: 2.0) : BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    //borderSide: state.password.invalid
                    borderSide: state.password.isNotValid
                        ? const BorderSide(color: SharedColors.homerBankDangerColor, width: 2.0)
                        : const BorderSide(color: SharedColors.homerBankWhiteColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: SharedColors.homerBankPrimaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  suffixIcon: InkWell(
                    onTap: () => context.read<LoginBloc>().add(VisibilityPasswordChanged(!state.visibility)),
                    child: Icon(state.visibility == true ? Icons.visibility_off : Icons.visibility),
                  ),
                  // errorText: state.password.invalid
                  //     ? _getErrorPassword(state.password.error)
                  //     : null,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                //state.password.invalid
                state.password.isNotValid ? _getErrorPassword(state.password.error) : '',
                style: TextStyle(
                  fontSize: 10,
                  //color: state.password.invalid
                  color: state.password.isNotValid ? SharedColors.homerBankDangerColor : Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _getErrorPassword(PasswordValidationError? err) {
    switch (err) {
      case PasswordValidationError.empty:
        return "password can\'t be empty";
      case PasswordValidationError.invalid:
        return "password invalid";
      default:
        return "";
    }
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        //return state.status.isSubmissionInProgress
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_buttonLogin_raisedButton'),
                //onPressed: state.status.isValidated
                onPressed: state.isValid
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                        FocusScope.of(context).unfocus();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                  backgroundColor: SharedColors.homerBankPrimaryColor,
                  textStyle: const TextStyle(fontSize: 15),
                ),
                //child: const Text('Login'),
                child: Text(l10n.login),
              );
      },
    );
  }
}
