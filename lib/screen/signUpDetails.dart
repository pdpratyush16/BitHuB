import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:study_material_app/Animation/FadeAnimation.dart';
import 'package:study_material_app/database/signupPageDatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_material_app/screen/FrontPage.dart';

class SignupPageDetails extends StatefulWidget {
  static const String id = 'registerScreenDetails';

  @override
  _SignupPageDetailsState createState() => _SignupPageDetailsState();
}

class _SignupPageDetailsState extends State<SignupPageDetails> {
  String branchVal, yearVal, rollNoVal, semesterVal;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.fill),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-1.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: FadeAnimation(
                        1.3,
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-2.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: FadeAnimation(
                        1.5,
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/clock.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: FadeAnimation(
                        1.6,
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      1.8,
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 30.0,
                              offset: Offset(0, 10),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Roll No",
                                  hintText: "10XXX",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  labelStyle: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                onChanged: (value) {
                                  rollNoVal = value;
                                },
                              ),
                            ), // Roll No...
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                focusColor: Color.fromRGBO(143, 148, 251, 1),
                                items: branchDropdownList,
                                onChanged: (String value) {
                                  setState(() {
                                    branchVal = value;
                                  });
                                },
                                hint: Text(
                                  'Branch',
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                                value: branchVal,
                              ),
                            ), // Branch...
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                focusColor: Color.fromRGBO(143, 148, 251, 1),
                                items: yearDropdownList,
                                onChanged: (String value) {
                                  setState(() {
                                    yearVal = value;
                                  });
                                },
                                hint: Text(
                                  'Year',
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                                value: yearVal,
                              ),
                            ), // Year...
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                items: semDropdownList,
                                onChanged: (String value) {
                                  setState(() {
                                    semesterVal = value;
                                  });
                                },
                                hint: Text(
                                  'Semester',
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                                value: semesterVal,
                              ),
                            ), // Semester...
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    FadeAnimation(
                      2,
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff8f94fb),
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            _firestore.collection('UserDatabase').add({
                              'Branch': branchVal,
                              'Email': loggedInUser.email,
                              'RollNo': rollNoVal,
                              'Semester': semesterVal,
                              'Year': yearVal,
                            });
                            Navigator.pushNamed(context, FrontPage.id);
                          },
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
