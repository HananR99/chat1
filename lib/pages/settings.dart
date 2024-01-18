import 'package:chat/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat/service/shared_pref.dart';
import 'dart:io';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? currentUserPic, currentUserName;
  File? _image;
  final picker = ImagePicker();
  TextEditingController newUserNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    currentUserPic = await SharedPreferenceHelper().getUserPic();
    currentUserName = await SharedPreferenceHelper().getUserName();
    setState(() {});
  }

  Future<void> updateUserName(String newUserName) async {
    // Update username in shared preferences
    await SharedPreferenceHelper().saveUserName(newUserName);

    // Update username in Firestore
    String? userId = await SharedPreferenceHelper().getUserId();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update({"username": newUserName});

    // Reload user data
    await loadUserData();
  }

  Future<void> updateProfilePic(File newImage) async {
    // Upload new profile picture to Firebase Storage
    String? userId = await SharedPreferenceHelper().getUserId();
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child("profile_pics")
        .child(userId!);
    UploadTask uploadTask = storageReference.putFile(newImage);
    await uploadTask.whenComplete(() async {
      String imageUrl = await storageReference.getDownloadURL();

      // Update profile picture URL in shared preferences
      await SharedPreferenceHelper().saveUserPic(imageUrl);

      // Update profile picture URL in Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .update({"photo": imageUrl});

      // Reload user data
      await loadUserData();
    });
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to perform sign-out
  Future<void> signOut() async {
    await SharedPreferenceHelper().clearUserData(); // Clear user data in shared preferences
    // Navigate to the authentication page (you need to replace 'AuthPage' with the actual name of your authentication page)
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              currentUserPic != null
                  ? CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(currentUserPic!),
                    )
                  : CircularProgressIndicator(),
              SizedBox(height: 20),
              currentUserName != null
                  ? Text(
                      "Username: $currentUserName",
                      style: TextStyle(fontSize: 18),
                    )
                  : CircularProgressIndicator(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => pickImage(),
                child: Text("Pick Profile Picture"),
              ),
              SizedBox(height: 20),
              _image != null
                  ? ElevatedButton(
                      onPressed: () => updateProfilePic(_image!),
                      child: Text("Update Profile Picture"),
                    )
                  : Container(),
              SizedBox(height: 20),
              TextField(
                controller: newUserNameController,
                onChanged: (value) {
                },
                decoration: InputDecoration(
                  labelText: "New Username",
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String newUserName = newUserNameController.text;
                  await updateUserName(newUserName);
                },
                child: Text("Update Username"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await signOut();
                },
                child: Text("Sign Out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
