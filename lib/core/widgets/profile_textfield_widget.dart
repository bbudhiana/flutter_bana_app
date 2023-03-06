import '/core/validation/firstname.dart';
import '/core/validation/lastname.dart';
import '/core/validation/username.dart';
import '../../utils/colors.dart';
import 'package:flutter/material.dart';

/* import '../../feature/login/presentation/models/models.dart';
import '../../feature/register/presentasion/bloc/register_bloc.dart'; */

class ProfileTextFieldWidget<T> extends StatelessWidget {
  final bool? readonly;
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
  final TextAlign textAlign;

  const ProfileTextFieldWidget(
      {super.key,
      this.readonly = false,
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
      this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        label.isNotEmpty
            ? Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    /* color: invalid! || validatorType == ComparePassword.invalid
                        ? SharedColors.bahasoDangerColor
                        : Colors.black, */
                  ),
                ),
              )
            : const SizedBox(),
        Material(
          shadowColor: Colors.grey,
          child: TextFormField(
            textAlign: textAlign,
            readOnly: readonly!,
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
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: SharedColors.homerBankPrimaryColor, width: 2.0),
                ),
                suffixIcon: suffixIcon),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          /* child: invalid! || validatorType == ComparePassword.invalid
              ? Text(
                  _validatorMsg(validatorType),
                  style: TextStyle(
                    fontSize: 10,
                    color: invalid! || validatorType == ComparePassword.invalid
                        ? SharedColors.bahasoDangerColor
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
      case UsernameValidationError.invalid:
        return "user name must be in lowwer case";
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
