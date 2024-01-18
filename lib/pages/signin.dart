import 'package:chat/pages/forgotpassword.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat/pages/home.dart';
import 'package:chat/pages/signup.dart';
import 'package:chat/service/database.dart';
import 'package:chat/service/shared_pref.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = "", password = "", name = "", username = "", pic = "", id = "";
  TextEditingController usermailController = TextEditingController();
  TextEditingController userpasswordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  // void showErrorMessage(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       backgroundColor: Colors.red,
  //       content: Text(
  //         message,
  //         style: TextStyle(fontSize: 18.0, color: Colors.black),
  //       ),
  //     ),
  //   );
  // }

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      QuerySnapshot querySnapshot =
          await DatabaseMethods().getUserbyemail(email);

      
        name = querySnapshot.docs[0]["Name"];
        username = querySnapshot.docs[0]["username"];
        pic = querySnapshot.docs[0]["photo"];
        id = querySnapshot.docs[0].id;

        await SharedPreferenceHelper().saveDisplayName(name);
        await SharedPreferenceHelper().saveUserId(id);
        await SharedPreferenceHelper().saveUserName(username);
        await SharedPreferenceHelper().saveUserPic(pic);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
       
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "No User Found",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Password Wrong",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Something Went Wrong",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      }
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF7f30fe), Color(0xFF6380fb)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width, 90.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "SignIn",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Login to your account",
                      style: TextStyle(
                        color: Color(0xFFbbb0ff),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        height: MediaQuery.of(context).size.height - 475,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                padding: EdgeInsets.only(left: 10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0, color: Colors.black38),
                                ),
                                child: TextFormField(
                                  controller: usermailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Email";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.mail_outline,
                                        color: Color(0xFF7f30fe)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "Password",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                padding: EdgeInsets.only(left: 10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0, color: Colors.black38),
                                ),
                                child: TextFormField(
                                  controller: userpasswordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Password";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.password,
                                        color: Color(0xFF7f30fe)),
                                  ),
                                  obscureText: true,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 50.0),
                              GestureDetector(
                                onTap: () async {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() {
                                      email = usermailController.text;
                                      password = userpasswordController.text;
                                    });
                                  }
                                  userLogin();
                                },
                                child: Center(
                                  child: SizedBox(
                                    width: 130,
                                    child: Material(
                                      elevation: 5.0,
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            color: Color(0xFF7f30fe),
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Center(
                                          child: Text(
                                            "SignIn",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text(
                          " Sign Up Now!",
                          style: TextStyle(
                              color: Color(0xFF7f30fe),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
