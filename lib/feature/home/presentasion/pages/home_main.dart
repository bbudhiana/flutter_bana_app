import 'package:flutter/material.dart';

import '/core/pages.dart';
import '/core/widgets/shared_safe_area_widget.dart';
import '/feature/home/presentasion/widgets/popup_widget.dart';
import '/util/colors.dart';
import '/util/images.dart';

class HomeMain extends StatefulWidget {
  static const String route = "home_main";

  const HomeMain({Key? key}) : super(key: key);

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final MainPages mainPages = MainPages();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future<bool>.value(true);
      },
      child: SharedSafeAreaWidget(
        child: Scaffold(
          backgroundColor: SharedColors.homerBankWhiteColor,
          appBar: _selectedIndex != 0
              ? null
              : AppBar(
                  toolbarHeight: 59,
                  backgroundColor: SharedColors.homerBankWhiteColor,
                  leading: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: SharedImagesHome.logoText,
                  ),
                  leadingWidth: 100,
                  actions: const [PopupMenuWidget()],
                ),
          resizeToAvoidBottomInset: true,
          body: mainPages.getpages.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: SharedImagesBottomNavigation.homeOff,
                  activeIcon: SharedImagesBottomNavigation.homeOn,
                  label: 'Home',
                  tooltip: ''),
              BottomNavigationBarItem(
                  icon: SharedImagesBottomNavigation.transactionOff,
                  activeIcon: SharedImagesBottomNavigation.transactionOn,
                  label: 'Transfer',
                  tooltip: ''),
              BottomNavigationBarItem(
                  icon: SharedImagesBottomNavigation.historyOff,
                  activeIcon: SharedImagesBottomNavigation.historyOn,
                  label: 'History',
                  tooltip: ''),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: SharedColors.homerBankPrimaryColor,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
