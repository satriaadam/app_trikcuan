import 'package:flutter/material.dart';
import 'package:trikcuan_app/widget/button.dart';

dialogConfirmation({
  BuildContext context, 
  String message, 
  String textConfirm, 
  String textCancel, 
  Widget nextPage, 
  VoidCallback callback
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        child: Container(
          height: 250,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlineButtonPrimary(
                      text: textCancel ?? "Cancel",
                      padding: 12,
                      fontSize: 14,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: RaisedButtonPrimary(
                      text: textConfirm ?? "OK",
                      padding: 12,
                      fontSize: 16,
                      onPressed: nextPage != null ? () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => nextPage),
                        );
                      } : callback
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  );
}