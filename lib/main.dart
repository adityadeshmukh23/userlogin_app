//importing the required packages as required
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//actually main fn is entry point in appliction
void main() {
  runApp(MyApp());
}
// my app is stateless widget,and it returns material app widget which is root of widget tree 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserDetailsInputPage(),
    );
  }
}
//this is responsible to take input from the user so that it can be shown further.
class UserDetailsInputPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //this is basically the interface that is being set default
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            TextField(
              controller: rollNoController,
              decoration: InputDecoration(
                labelText: 'Roll No',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.format_list_numbered),
              ),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            SizedBox(height: 70),
            ElevatedButton(
              onPressed: () {
                _navigateToUserDetails(context);
              },
              //button is created so that we can access the info provided
              child: Text('Show Details'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 175, 168, 76),
                textStyle: TextStyle(fontSize: 18),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
// this is responsible for generating the information that was given by user after clicking on show details.
  void _navigateToUserDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailsPage(
          name: nameController.text,
          email: emailController.text,
          rollNo: rollNoController.text,
          phoneNumber: phoneController.text,
        ),
      ),
    ).then((value) {
      if (value != null && value is String) {
        _showLogoutDialog(context, value);
      }
    });
  }
// this feature deals with the logout message which has to be displayed on app after clicking on logout button
  void _showLogoutDialog(BuildContext context, String username) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Oops $username has logged out !!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
// this displays the name,email,roolno and phone no that we stored above 
class UserDetailsPage extends StatelessWidget {
  final String name;
  final String email;
  final String rollNo;
  final String phoneNumber;

  UserDetailsPage({
    required this.name,
    required this.email,
    required this.rollNo,
    required this.phoneNumber,
  });
// additionally i had used goglefonts to create or generate fonts in stylish way , to improve ui at some extent (this i have read from here https://pub.dev/packages/google_fonts)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Container(
        color: Colors.blueGrey[100],
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Name: $name', style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Email: $email', style: GoogleFonts.lato(fontSize: 20)),
            Text('Roll No: $rollNo', style: GoogleFonts.lato(fontSize: 20)),
            Text('Phone Number: $phoneNumber', style: GoogleFonts.lato(fontSize: 20)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, name);
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
