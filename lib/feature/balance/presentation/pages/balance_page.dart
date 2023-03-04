import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/feature/authentication/presentation/cubit/auth_cubit.dart';
import '../../../../size_config.dart';
import '../../../authentication/presentation/bloc/authentication_bloc.dart';
import '../../../home/presentasion/pages/components/home_header.dart';
import '../../../home/presentasion/pages/components/info_balance.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenWidth(20)),
            const HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(30)),
            const InfoBalance(),
            SizedBox(height: getProportionateScreenWidth(30)),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Builder(
                    builder: (context) {
                      //context.select((AuthenticationBloc bloc) => bloc.state.user.id) will trigger updates if the user id changes
                      final userId = context.select(
                        //(AuthenticationBloc bloc) => bloc.state.user.name,
                        (AuthCubit cubit) => cubit.state.user.name,
                      );
                      return Text('UserID: $userId');
                    },
                  ),
                  ElevatedButton(
                    /* child: const Text('Logout'),
                    onPressed: () {
                      context
                          .read<AuthenticationBloc>()
                          .add(AuthenticationLogoutRequested());
                    }, */
                    child: const Text('Logout'),
                    onPressed: () {
                      context.read<AuthCubit>().logOutRequest();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
