import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? id;
  String? userId;
  String? title;
  String? desc;
  Timestamp? dateAndTime;
  String? type;

  EventModel({this.id,this.title,this.type,this.userId,this.dateAndTime,this.desc});

  EventModel.fromFirestore(Map<String,dynamic>? data){
    id = data?["id"];
    userId = data?["userId"];
    title = data?["title"];
    desc = data?["desc"];
    type = data?["type"];
    dateAndTime = data?["dateAndTime"];
  }

  Map<String,dynamic> toFirestore(){
    return {
      "id":id,
      "userId":userId,
      "title":title,
      "desc":desc,
      "type":type,
      "dateAndTime":dateAndTime
    };
  }
}