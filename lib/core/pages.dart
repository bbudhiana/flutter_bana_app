/* import '../feature/account/presentasion/pages/account_page.dart';
import '../feature/home/presentasion/pages/home_page.dart'; */

import '/features/balance/presentation/pages/balance_page.dart';
import '/features/history/presentation/pages/history_page.dart';
import '/features/transfer/presentation/pages/transfer_page.dart';

class MainPages {
  final List<dynamic> getpages = <dynamic>[
    const BalancePage(),
    const TransferPage(),
    const HistoryPage()
    //const AccountPage()
  ];
}
