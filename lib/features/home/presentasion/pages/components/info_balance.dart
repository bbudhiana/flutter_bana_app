import 'package:flutter/material.dart';
import 'package:flutter_bana_app/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../size_config.dart';
import '../../../../authentication/presentation/cubit/auth_cubit.dart';
import '../../../../authentication/presentation/bloc/authentication_bloc.dart';

class InfoBalance extends StatelessWidget {
  const InfoBalance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
      child: Builder(builder: (context) {
        final userName = context.select(
          //(AuthCubit cubit) => cubit.state.user.name,
          (AuthenticationBloc bloc) => bloc.state.user.name,
        );
        final userAmount = context.select(
          //(AuthCubit cubit) => cubit.state.user.amount,
          (AuthenticationBloc bloc) => bloc.state.user.amount,
        );
        return Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text.rich(
              TextSpan(
                text: "${l10n.welcomeHome} $userName\n",
                style: const TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    text: "${l10n.yourDepositeToday} :",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenWidth(30)),
            Center(
              child: Text.rich(
                TextSpan(
                  style: const TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      text: "$userAmount",
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
