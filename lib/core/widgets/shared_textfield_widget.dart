import '/core/validation/firstname.dart';
import '/core/validation/lastname.dart';
import '/core/validation/username.dart';
import '/util/colors.dart';
import 'package:flutter/material.dart';

/* import '../../feature/login/presentation/models/models.dart';
import '../../feature/register/presentasion/bloc/register_bloc.dart'; */

// enum ValidatorType { email, password, string, number }

class SharedTextFieldWidget<T> extends StatelessWidget {
  final String label;
  final String? hintText;
  final bool? invalid;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function(String value)? onChanged;
  final TextEditingController? controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final T? validatorType;

  const SharedTextFieldWidget({
    super.key,
    this.invalid = false,
    required this.label,
    this.hintText,
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.textInputAction = TextInputAction.done,
    this.obscureText = false,
    this.suffixIcon,
    this.validatorType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              /* color: invalid! || validatorType == ComparePassword.invalid
                  ? SharedColors.homerBankDangerColor
                  : Colors.black, */
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 8)),
        Material(
          elevation: 2.0,
          shadowColor: Colors.grey,
          borderRadius: BorderRadius.circular(8.0),
          child: TextFormField(
            obscureText: obscureText!,
            controller: controller,
            onChanged: (value) => onChanged!(value),
            decoration: InputDecoration(
                filled: true,
                fillColor: SharedColors.homerBankWhiteColor,
                hintText: hintText,
                hintStyle: const TextStyle(
                    color: SharedColors.homerBankGreyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                border: OutlineInputBorder(
                  /* borderSide:
                      invalid! || validatorType == ComparePassword.invalid
                          ? const BorderSide(
                              color: SharedColors.homerBankDangerColor, width: 2.0)
                          : BorderSide.none, */
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  /* borderSide:
                      invalid! || validatorType == ComparePassword.invalid
                          ? const BorderSide(
                              color: SharedColors.homerBankDangerColor, width: 2.0)
                          : const BorderSide(
                              color: SharedColors.homerBankWhiteColor, width: 1.0), */
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: SharedColors.homerBankPrimaryColor, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: suffixIcon
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
          /* child: invalid! || validatorType == ComparePassword.invalid
              ? Text(
                  _validatorMsg(validatorType),
                  style: TextStyle(
                    fontSize: 10,
                    color: invalid! || validatorType == ComparePassword.invalid
                        ? SharedColors.homerBankDangerColor
                        : Colors.green,
                  ),
                )
              : null, */
        ),
      ],
    );
  }

  String _validatorMsg(validatorType) {
    switch (validatorType) {
      /* case ComparePassword.invalid:
        return "Password do not match"; */
      case UsernameValidationError.empty:
        return "user name can't be empty";
      case FirstnameValidationError.empty:
        return "First name can't be empty";
      case LastnameValidationError.empty:
        return "Last name can't be empty";
      /* case EmailValidationError.empty:
        return "Email can't be empty";
      case EmailValidationError.invalid:
        return "Email format is invalid";
      case PasswordValidationError.empty:
        return "Password can't be empty";
      case PasswordValidationError.invalid:
        return "Password policy is not valid"; */

      default:
        return '';
    }
  }
}
