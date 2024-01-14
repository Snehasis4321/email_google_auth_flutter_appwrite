import 'package:appwrite/models.dart';
import 'package:email_google_auth_flutter_appwrite/controllers/auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late User _currentUser;
  bool isLoading = true;

  @override
  void initState() {
    getUser().then((value) {
      setState(() {
        _currentUser = value!;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text("Welcome ${_currentUser.name} 👋"),
                  SizedBox(
                    height: 10,
                  ),
                  Text("📧Email : ${_currentUser.email}"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "✅Account Verified : ${_currentUser.emailVerification} "),
                  SizedBox(
                    height: 10,
                  ),
                  _currentUser.emailVerification == false
                      ? TextButton(
                          onPressed: () {
                            sendVerificationMail().then((value) {
                              if (value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    "Email Sent",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.green.shade400,
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    "Email not sent.",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red.shade400,
                                ));
                              }
                            });
                          },
                          child: Text("Verify Email"))
                      : SizedBox(),
                  ElevatedButton(
                      onPressed: () {
                        logoutUser();
                        Navigator.pushReplacementNamed(context, "/login");
                      },
                      child: Text("Logout"))
                ],
              )));
  }
}
