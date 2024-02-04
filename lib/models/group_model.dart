import 'package:begivenhet/models/events.dart';

class GroupModel {
  int? id;
  String? name;
  String? picture;
  String? description;
  List<EventsModel>? events;

  GroupModel({this.id, this.name, this.picture, this.description, this.events});

  GroupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    picture = json['picture'];
    description = json['description'];
    if (json['events'] != null) {
      events = <EventsModel>[];
      json['events'].forEach((v) {
        events!.add(new EventsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['picture'] = this.picture;
    data['description'] = this.description;
    if (this.events != null) {
      data['events'] = this.events!.map((v) {
        return v.toJson();
      }).toList();
    }
    return data;
  }
}
