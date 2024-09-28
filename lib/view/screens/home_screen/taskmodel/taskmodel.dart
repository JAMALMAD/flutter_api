// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));


class TaskModel {
  String? status;
  String? message;
  Data? data;

  TaskModel({
    this.status,
    this.message,
    this.data,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );


}

class Data {
  int? count;
  List<MyTask>? myTasks;

  Data({
    this.count,
    this.myTasks,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    count: json["count"],
    myTasks: json["myTasks"] == null ? [] : List<MyTask>.from(json["myTasks"]!.map((x) => MyTask.fromJson(x))),
  );


}

class MyTask {
  String? id;
  String? title;
  String? description;
  String? creatorEmail;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  MyTask({
    this.id,
    this.title,
    this.description,
    this.creatorEmail,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MyTask.fromJson(Map<String, dynamic> json) => MyTask(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    creatorEmail: json["creator_email"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  //
}
