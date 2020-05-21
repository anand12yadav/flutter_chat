import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

 Future getUserByUsername(String username)async {
   return await Firestore.instance.collection("users")
   .where("name",isEqualTo:username)
   .getDocuments()
   .catchError((e){
     print(e.toString());
   });

 }

  Future getUserByUserEmail(String userEmail)async {
   return await Firestore.instance.collection("users")
   .where("email",isEqualTo:userEmail)
   .getDocuments()
   .catchError((e){
     print(e.toString());
   });

 }

 uplaodUserInfo(Map userMap){
      Firestore.instance.collection("users")
      .add(userMap);
 }
 
 createChatRoom(String chatRoomId, Map chatRoomMap){
   Firestore.instance.collection("ChatRoom")
   .document(chatRoomId)
   .setData(chatRoomMap)
   .catchError((e){
     print(e.toString());
   });
 }

 addConverationMessages(String chatRoomId,Map messageMap){
   Firestore.instance.collection("ChatRoom")
   .document(chatRoomId)
   .collection("chats")
   .add(messageMap).catchError((e){
     print(e.toString());
   });
 }

Future getConverationMessages(String chatRoomId)async{
   return Firestore.instance.collection("ChatRoom")
   .document(chatRoomId)
   .collection("chats")
   .orderBy("time",descending: false)
   .snapshots();  
 }

  Future getChatRoom(String userName)async {
   return Firestore.instance
   .collection("ChatRoom")
   .where("users",arrayContains: userName)
   .snapshots();
 }
}