import 'package:flutter/material.dart';

class SCircularProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: CircularProgressIndicator(),
    );
  }
}

class SCircularProgressWithBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: SizedBox(
                height: 30,
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              color: Colors.black87,
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
        Align(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
