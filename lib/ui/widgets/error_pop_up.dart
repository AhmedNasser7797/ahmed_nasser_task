import 'package:flutter/cupertino.dart' hide FontWeight;
import 'package:flutter/material.dart' hide FontWeight;

class ErrorPopUp extends StatelessWidget {
  final String message;
  final String title;
  final Orientation orientation;
  final Function function;

  ErrorPopUp(
      {@required this.message, this.title, this.orientation, this.function});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title ?? "Error!"),
      content: Column(
        children: <Widget>[
          SizedBox(height: 24.0),
          Text(
            message,
            style: TextStyle(
              fontSize: 16.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 36.0),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: () => function ?? Navigator.of(context).pop(),
            child: Text("Ok"),
            textColor: Colors.white,
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
