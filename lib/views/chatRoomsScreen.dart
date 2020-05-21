import 'package:flutter/material.dart';
import 'package:flutter_chat/helper/authenticate.dart';
import 'package:flutter_chat/helper/constant.dart';
import 'package:flutter_chat/helper/database.dart';
import 'package:flutter_chat/helper/helperfunctions.dart';
import 'package:flutter_chat/services/auth.dart';
import 'package:flutter_chat/views/conversation_screen.dart';
import 'package:flutter_chat/views/search.dart';
import 'package:flutter_chat/widgets/widget.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRoomsStream;
  AuthMethods methods = new AuthMethods();
  HelperFunctions helperFunctions = new HelperFunctions();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Widget chatRoomList() {
    return StreamBuilder(
        stream: chatRoomsStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                //shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return ChatRoomsTile(
                        snapshot.data.documents[index].data["chatroomId"]
                            .toString()
                            .replaceAll("_","")
                            .replaceAll(Constants.myName,""),
                        snapshot.data.documents[index].data["chatroomId"]);
                  })
              : Container(
                child:Center(
                  child:  Text("no data",style: simpleTextStyle(),),
                )
              );
        });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await helperFunctions.getUserNameSharedPreference();
    databaseMethods.getChatRoom(Constants.myName).then((value) {
      if(value==null){
        print("no data found");
      }else{
        setState(() {
        chatRoomsStream=value;
      });
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Chat"),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              methods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
        child: Icon(Icons.search),
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomsTile(this.userName, this.chatRoomId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(
                      chatRoomId: chatRoomId,
                    )));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: <Widget>[
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(40)),
              child: Text(
                "${userName.substring(0, 1).toUpperCase()}",
                style: simpleTextStyle(),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              userName,
              style: simpleTextStyle(),
            )
          ],
        ),
      ),
    );
  }
}
