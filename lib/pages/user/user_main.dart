import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_app/pages/login.dart';
import 'dashboard.dart';
import 'profile.dart';
import 'change_password.dart';

class UserMain extends StatefulWidget {
  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int _selectedIndex = 0;

  final storage = FlutterSecureStorage();

  static List<Widget> _widgetOptions = [
    Dashboard(),
    Profile(),
    ChangePassword(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Welcome User'),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await storage.delete(key: 'uid');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false);
              },
              child: Text('Logout'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Change Password',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.redAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
