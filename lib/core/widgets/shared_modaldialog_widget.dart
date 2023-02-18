import '/util/colors.dart';
import 'package:flutter/material.dart';

class SharedModalDialog {
  static SharedModalDialog? utility;

  static SharedModalDialog? getInstance() {
    utility ??= SharedModalDialog();
    return utility;
  }

  showAlertDialog(BuildContext context, String alertTitle, String alertMessage,
      Image alertImage, dynamic alertRoute) {
    Widget okButton = ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, alertRoute);
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width, 50),
        backgroundColor: SharedColors.homerBankPrimaryColor,
        textStyle: const TextStyle(fontSize: 15),
      ),
      child: const Text('OK'),
    );

    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.0))),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            SizedBox(
              height: 124,
              width: 124,
              child: alertImage,
            ),
            const Padding(padding: EdgeInsets.only(top: 23)),
            Text(
              alertTitle,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(top: 12)),
            Text(
              alertMessage,
              style: const TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: okButton,
        )
      ],
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
