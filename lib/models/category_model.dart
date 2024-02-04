import 'package:begivenhet/models/events.dart';

class CategoryModel {
  int? id;
  String? name;
  String? picture;
  List<EventsModel>? eventsList;

  CategoryModel({this.id, this.name, this.picture, this.eventsList});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    picture = json['picture'];
    if (json['eventsList'] != null) {
      eventsList = <EventsModel>[];
      json['eventsList'].forEach((v) {
        eventsList!.add(EventsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['picture'] = picture;
    if (eventsList != null) {
      data['eventsList'] = eventsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}