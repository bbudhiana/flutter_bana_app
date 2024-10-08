import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/presentation/bloc/authentication_bloc.dart';
import '/features/authentication/presentation/cubit/auth_cubit.dart';
import '../../../../utils/colors.dart';

class PopupMenuWidget extends StatefulWidget {
  const PopupMenuWidget({super.key});

  @override
  State<PopupMenuWidget> createState() => _PopupMenuWidgetState();
}

class _PopupMenuWidgetState extends State<PopupMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_vert,
        color: SharedColors.homerBankPrimaryColor,
      ),
      offset: const Offset(0, 0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(0.0),
        ),
      ),
      itemBuilder: (_) => <PopupMenuEntry>[
        const PopupMenuItem(
            value: 1,
            child: ListTile(
              title: Text('Edit Profile'),
            )),
        const PopupMenuItem(
            value: 2,
            child: ListTile(
              title: Text('Settings'),
            )),
        const PopupMenuItem(
            value: 3,
            child: ListTile(
              title: Text('Privacy Policy'),
            )),
        const PopupMenuItem(
            value: 4,
            child: ListTile(
              title: Text('Term of use'),
            )),
        const PopupMenuItem(
            value: 5,
            child: ListTile(
              title: Text('Logout'),
            )),
      ],
      onSelected: (value) {
        switch (value) {
          case 1:
          case 2:
          case 3:
          case 4:
          case 5:
            _logOut(context);
            break;
          default:
        }
      },
    );
  }
}

void _logOut(BuildContext context) {
  context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
  //context.read<AuthCubit>().logOutRequest(); //shortcut
  //BlocProvider.of<AuthCubit>(context).logOutRequest(); //Official
}

class TooltipShape extends ShapeBorder {
  const TooltipShape();

  final BorderSide _side = BorderSide.none;
  final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

    path.moveTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0);
    path.lineTo(rrect.width - 30, 0);
    path.lineTo(rrect.width - 20, -10);
    path.lineTo(rrect.width - 10, 0);
    path.quadraticBezierTo(rrect.width, 0, rrect.width, 10);
    path.lineTo(rrect.width, rrect.height - 10);
    path.quadraticBezierTo(rrect.width, rrect.height, rrect.width - 10, rrect.height);
    path.lineTo(10, rrect.height);
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 10);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
      );
}
