import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final currentUser = FirebaseAuth.instance.currentUser;

  void verifyEmail() async {
    if (!currentUser!.emailVerified) {
      currentUser!.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.greenAccent,
          content: Text(
            'Verification mail sent successfully',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      child: Column(
        children: [
          Text(
            'User ID: ${currentUser!.uid}',
            style: TextStyle(fontSize: 18.0),
          ),
          Row(
            children: [
              Text(
                'Email: ${currentUser!.email}',
                style: TextStyle(fontSize: 18.0),
              ),
              currentUser!.emailVerified
                  ? Text(
                      ' Verified',
                      style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                    )
                  : TextButton(
                      onPressed: () {
                        verifyEmail();
                      },
                      child: Text('verify email'),
                    ),
            ],
          ),
          Text(
            'Created: ${currentUser!.metadata.creationTime}',
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
