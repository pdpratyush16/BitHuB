import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:study_material_app/Animation/CustomWidgets.dart';
import 'package:study_material_app/Animation/FadeAnimation.dart';
import 'package:study_material_app/screen/aboutUs.dart';
import 'package:study_material_app/screen/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_material_app/screen/updateDetails.dart';
import '../Animation/CustomWidgets.dart';

class ProfilePage extends StatefulWidget {
  static const String id = 'profileScreen';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String branch, semester, name, rollNo, email;

  Future<void> _getUserDetails() async {
    String uid = FirebaseAuth.instance.currentUser.uid;
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('UserDatabase').doc(uid).get();

    if (doc.exists) {
      // this will check availability of document
      if (mounted) {
        setState(
          () {
            branch = doc.data()['Branch'];
            semester = doc.data()['Semester'];
            name = doc.data()['Name'];
            rollNo = doc.data()['RollNo'];
            email = doc.data()['Email'];
          },
        );
      }
    } else {
      if (mounted) {
        setState(
          () {
            branch = 'User is not available';
            semester = 'User is not available';
            name = 'User is not available';
            rollNo = 'User is not available';
            email = 'User is not available';
          },
        );
      }
    }
  }

  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getUserDetails();
    return Scaffold(
      backgroundColor: kBgColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Background(
                height1: 280.0,
                height2: 150.0,
                height3: 100.0,
                height4: 100.0,
              ),
              Padding(
                padding: EdgeInsets.all(0.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InfoIconButton(
                            icon: FontAwesomeIcons.info,
                            onPressed: () async {
                              Navigator.pushNamed(context, AboutUs.id);
                            }),
                      ],
                    ),
                    FadeAnimation(
                      1.8,
                      Column(
                        children: [

                          CustomTileDesign(
                            name: 'Name  :  $name',
                          ),
                          CustomTileDesign(
                            name: 'Semester  :  $semester',
                          ),
                          CustomTileDesign(
                            name: 'Branch  :  $branch',
                          ),
                          CustomTileDesign(
                            name: 'Roll No  :  $rollNo',
                          ),
                          CustomTileDesign(
                            name: 'E-mail  :  $email',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ProfileIconButton(
                                  icon: FontAwesomeIcons.userEdit,
                                  onPressed: () async {
                                    Navigator.pushNamed(context, UpdateScreen.id);
                                  }),

                              ProfileIconButton(
                                  icon: FontAwesomeIcons.signOutAlt,
                                  onPressed: () async {
                                    SharedPreferences sharedPreference =
                                        await SharedPreferences.getInstance();
                                    sharedPreference.remove('email');
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
                                  }),
                              //SizedBox(width: 20.0)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
