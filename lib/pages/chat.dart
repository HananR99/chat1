// // import 'package:flutter/material.dart';

// // class Chat extends StatefulWidget {
// //   const Chat({super.key, required String name, required String profileurl, required String username});

// //   @override
// //   State<Chat> createState() => _ChatState();
// // }

// // class _ChatState extends State<Chat> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Color(0xFF553370),
// //       resizeToAvoidBottomInset: false,
// //       body: SingleChildScrollView(
// //         child: Container(
// //           margin: EdgeInsets.only(top: 60.0,),
// //           child: Column(
// //             children: [
// //             Padding(
// //               padding: const EdgeInsets.only(left: 10.0),
// //               child: Row(children: [
// //                 Icon(Icons.arrow_back_ios_new_outlined, color: Color(0Xffc199cd),),
// //                 SizedBox(width: 90.0,),
// //                 Text("Hanan Ramzan", style: TextStyle(color: Color(0Xffc199cd), fontSize: 22.0, fontWeight: FontWeight.w500),),
// //               ],),
// //             ),
// //             SizedBox(height: 20.0,),
// //             Container(
// //               padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0, bottom: MediaQuery.of(context).viewInsets.bottom + 30.0),
// //               width: MediaQuery.of(context).size.width,
// //               height: MediaQuery.of(context).size.height / 1.144,
// //               decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
// //             child: Column(
// //               children: [
// //                 Container(
// //                   padding: EdgeInsets.all(10.0),
// //                   margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/2),
// //                   alignment: Alignment.bottomRight,
// //                   decoration: BoxDecoration(
// //                     color: Color.fromARGB(255, 223, 228, 239),
// //                     borderRadius: BorderRadius.only(
// //                       topLeft: Radius.circular(10),
// //                       topRight: Radius.circular(10),
// //                       bottomLeft: Radius.circular(10))),
// //                child: Text("Hello, How was the day?", style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w500)),),
// //                SizedBox(height: 20.0,),
// //                Container(
// //                   padding: EdgeInsets.all(10.0),
// //                   margin: EdgeInsets.only(right: MediaQuery.of(context).size.width/3),
// //                   alignment: Alignment.bottomLeft,
// //                   decoration: BoxDecoration(
// //                     color: Color.fromARGB(255, 197, 203, 213),
// //                     borderRadius: BorderRadius.only(
// //                       bottomRight: Radius.circular(10),
// //                       topRight: Radius.circular(10),
// //                       topLeft: Radius.circular(10))),
// //                child: Text("Hi, it's really good ", style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w500)),),
// //               Spacer(),
// //               Material(
// //                 elevation: 5.0,
// //                 borderRadius: BorderRadius.circular(30),
// //                 child: Container(
// //                   padding: EdgeInsets.all(10),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(30)),
// //                   child: Row(children: [
// //                   Expanded(
// //                     child: TextField(
// //                       decoration: InputDecoration(
// //                         hintText: "Type a message",
// //                         hintStyle: TextStyle(color: Colors.black45, fontSize: 15.0, fontWeight: FontWeight.w500),
// //                         border: InputBorder.none,
// //                       ),
// //                     ),
// //                   ),
// //                   Container(
// //                     padding: EdgeInsets.all(10),
// //                     decoration: BoxDecoration(color: Color(0xFFf3f3f3), borderRadius: BorderRadius.circular(60)),
// //                     child: Center(child: Icon(Icons.send, color: Color.fromARGB(255, 141, 139, 139),)))
// //                 ],
// //                 ),
// //                 ),
// //               )
// //               ],
// //             ),
// //           ),
// //           ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:chat/pages/home.dart';
// import 'package:chat/service/database.dart';
// import 'package:chat/service/shared_pref.dart';
// import 'package:random_string/random_string.dart';

// class Chat extends StatefulWidget {
//   final String name, profileurl, username;

//   Chat({required this.name, required this.profileurl, required this.username});

//   @override
//   State<Chat> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<Chat> {
//   TextEditingController messageController = TextEditingController();
//   String? myUserName, myProfilePic, chatRoomId;
//   Stream? messageStream;

//   @override
//   void initState() {
//     super.initState();
//     onInitLoad();
//   }

//   Future<void> onInitLoad() async {
//     await getSharedPrefs();
//     await getAndSetMessages();
//   }

//   Future<void> getSharedPrefs() async {
//     myUserName = await SharedPreferenceHelper().getUserName();
//     myProfilePic = await SharedPreferenceHelper().getUserPic();
//     chatRoomId = getChatRoomIdByUsernames(widget.username, myUserName!);
//   }

//   String getChatRoomIdByUsernames(String a, String b) {
//     return a.substring(0, 1).compareTo(b.substring(0, 1)) > 0
//         ? "$b\_$a"
//         : "$a\_$b";
//   }

//   Widget chatMessageTile(String message, bool sendByMe) {
//     return Row(
//       mainAxisAlignment:
//           sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//       children: [
//         Flexible(
//           child: Container(
//             padding: EdgeInsets.all(16),
//             margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(24),
//                 bottomRight:
//                     sendByMe ? Radius.circular(0) : Radius.circular(24),
//                 topRight: Radius.circular(24),
//                 bottomLeft: sendByMe ? Radius.circular(24) : Radius.circular(0),
//               ),
//               color: sendByMe
//                   ? Color.fromARGB(255, 234, 236, 240)
//                   : Color.fromARGB(255, 211, 228, 243),
//             ),
//             child: Text(
//               message,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 15.0,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget chatMessage() {
//     return StreamBuilder(
//       stream: messageStream,
//       builder: (context, AsyncSnapshot snapshot) {
//         return snapshot.hasData
//             ? ListView.builder(
//                 padding: EdgeInsets.only(bottom: 90.0, top: 130),
//                 itemCount: snapshot.data.docs.length,
//                 reverse: true,
//                 itemBuilder: (context, index) {
//                   DocumentSnapshot ds = snapshot.data.docs[index];
//                   return chatMessageTile(
//                       ds["message"], myUserName == ds["sendBy"]);
//                 },
//               )
//             : Center(
//                 child: CircularProgressIndicator(),
//               );
//       },
//     );
//   }

//   Future<void> getAndSetMessages() async {
//     messageStream = await DatabaseMethods().getChatRoomMessages(chatRoomId);
//     setState(() {});
//   }

//   void addMessage(bool sendClicked) {
//     if (messageController.text.isNotEmpty) {
//       String message = messageController.text;
//       messageController.text = "";

//       DateTime now = DateTime.now();
//       String formattedDate = DateFormat('h:mma').format(now);

//       Map<String, dynamic> messageInfoMap = {
//         "message": message,
//         "sendBy": myUserName,
//         "ts": formattedDate,
//         "time": FieldValue.serverTimestamp(),
//         "imgUrl": myProfilePic,
//       };

//       String messageId = randomAlphaNumeric(10);

//       DatabaseMethods()
//           .addMessage(chatRoomId!, messageId, messageInfoMap)
//           .then((value) {
//         Map<String, dynamic> lastMessageInfoMap = {
//           "lastMessage": message,
//           "lastMessageSendTs": formattedDate,
//           "time": FieldValue.serverTimestamp(),
//           "lastMessageSendBy": myUserName,
//         };
//         DatabaseMethods()
//             .updateLastMessageSend(chatRoomId!, lastMessageInfoMap);
//         if (sendClicked) {
//           setState(() {});
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF553370),
//       body: Container(
//         padding: EdgeInsets.only(top: 60.0),
//         child: Stack(
//           children: [
//             Container(
//               margin: EdgeInsets.only(top: 50.0),
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height / 1.12,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                 ),
//               ),
//               child: chatMessage(),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => Home()),
//                       );
//                     },
//                     child: Icon(
//                       Icons.arrow_back_ios_new_outlined,
//                       color: Color(0Xffc199cd),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 90.0,
//                   ),
//                   Text(
//                     widget.name,
//                     style: TextStyle(
//                       color: Color(0Xffc199cd),
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
//               alignment: Alignment.bottomCenter,
//               child: Material(
//                 elevation: 5.0,
//                 borderRadius: BorderRadius.circular(30),
//                 child: Container(
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: messageController,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Type a message",
//                             hintStyle: TextStyle(
//                               color: Colors.black45,
//                             ),
//                           ),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           addMessage(true);
//                         },
//                         child: Icon(Icons.send_rounded),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chat/pages/home.dart';
import 'package:chat/service/database.dart';
import 'package:chat/service/shared_pref.dart';
import 'package:random_string/random_string.dart';

class Chat extends StatefulWidget {
  String name, profileurl, username;
  Chat(
      {required this.name, required this.profileurl, required this.username});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController messagecontroller = new TextEditingController();
  String? myUserName, myProfilePic, myName, myEmail, messageId, chatRoomId;
  Stream? messageStream;

  getthesharedpref() async {
    myUserName = await SharedPreferenceHelper().getUserName();
    myProfilePic = await SharedPreferenceHelper().getUserPic();
    myName = await SharedPreferenceHelper().getDisplayName();
    myEmail = await SharedPreferenceHelper().getUserEmail();

    chatRoomId = getChatRoomIdbyUsername(widget.username, myUserName!);
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    await getAndSetMessages();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  getChatRoomIdbyUsername(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
            child: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomRight:
                      sendByMe ? Radius.circular(0) : Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft:
                      sendByMe ? Radius.circular(24) : Radius.circular(0)),
              color: sendByMe
                  ? Color.fromARGB(255, 234, 236, 240)
                  : Color.fromARGB(255, 211, 228, 243)),
          child: Text(
            message,
            style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w500),
          ),
        )),
      ],
    );
  }

  Widget chatMessage() {
    return StreamBuilder(
        stream: messageStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.only(bottom: 90.0, top: 130),
                  itemCount: snapshot.data.docs.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return chatMessageTile(
                        ds["message"], myUserName == ds["sendBy"]);
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  addMessage(bool sendClicked) {
    if (messagecontroller.text != "") {
      String message = messagecontroller.text;
      messagecontroller.text = "";

      DateTime now = DateTime.now();
      String formattedDate = DateFormat('h:mma').format(now);
      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": myUserName,
        "ts": formattedDate,
        "time": FieldValue.serverTimestamp(),
        "imgUrl": myProfilePic,
      };
      messageId ??= randomAlphaNumeric(10);

      DatabaseMethods()
          .addMessage(chatRoomId!, messageId!, messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": formattedDate,
          "time": FieldValue.serverTimestamp(),
          "lastMessageSendBy": myUserName,
        };
        DatabaseMethods()
            .updateLastMessageSend(chatRoomId!, lastMessageInfoMap);
        if (sendClicked) {
          messageId = null;
        }
      });
    }
  }

  getAndSetMessages() async {
    messageStream = await DatabaseMethods().getChatRoomMessages(chatRoomId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF553370),
      body: Container(
        padding: EdgeInsets.only(top: 60.0),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.12,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: chatMessage()),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Color(0Xffc199cd),
                    ),
                  ),
                  SizedBox(
                    width: 90.0,
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(
                        color: Color(0Xffc199cd),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
                margin:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              alignment: Alignment.bottomCenter,
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: TextField(
                    controller: messagecontroller,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type a message",
                        hintStyle: TextStyle(color: Colors.black45),
                        suffixIcon: GestureDetector(
                          onTap: (){
                            addMessage(true);
                          },
                          child: Icon(Icons.send_rounded))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
