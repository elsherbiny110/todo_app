import 'package:firebase_auth/firebase_auth.dart';

class TaskModel {
  String id;
  String title;
  String desc;
  int date;
  String time;
  String userId;
  bool isDone;
  TaskModel(
      {this.id = "",
      required this.title,
      required this.date,
      required this.desc,
      required this.time,
      this.userId = "",
      required this.isDone}) {
    userId = FirebaseAuth.instance.currentUser?.uid ?? "";
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        id: json["id"],
        title: json['title'],
        date: json['date'],
        desc: json["desc"],
        userId: json["userId"]??"",
        time: json["time"],
        isDone: json["isDone"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "desc": desc,
      "title": title,
      "time": time,
      "date": date,
      "userId": userId,
      "isDone": isDone
    };
  }
}
