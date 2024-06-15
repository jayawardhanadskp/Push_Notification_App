import 'package:authentication_app/model/user.dart';
import 'package:authentication_app/services/firebase_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/send_notification_screen.dart';

class UserWidget extends StatefulWidget {
  final UserModel model;
  const UserWidget({super.key, required this.model});

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Text(
              'Name: ${widget.model.name}'
            ),

            Text('Platform: ${widget.model.platform}'),

            Text('Created At: ${widget.model.createdAt}'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SendNotificationScreen(token: widget.model.token)));
              },
              child: Text('Send Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
