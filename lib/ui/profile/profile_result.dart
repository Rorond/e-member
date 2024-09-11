import 'package:flutter/material.dart';
import 'package:emembers/data/models/user.dart';

class ProfileResult extends StatelessWidget {
  final User user;

  const ProfileResult({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Update'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Profile updated successfully!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // kembali ke halaman sebelumnya
              },
              child: Text('Back to Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
