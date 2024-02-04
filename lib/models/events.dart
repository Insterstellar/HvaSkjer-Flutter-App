class EventsModel {
  int? id;
  String? eventName;
  String? eventDescription;
  String? eventImage;
  String? eventVenue;
  String? eventStartTime;
  String? eventEndTime;

  EventsModel(
      {this.id,
        this.eventName,
        this.eventDescription,
        this.eventImage,
        this.eventVenue,
        this.eventStartTime,
        this.eventEndTime});

  EventsModel.fromJson(Map<String, dynamic> json) {
    id=json['id'];
    eventName = json['eventName'];
    eventDescription = json['eventDescription'];
    eventImage = json['eventImage'];
    eventVenue = json['eventVenue'];
    eventStartTime = json['eventStartTime'];
    eventEndTime = json['eventEndTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['eventName'] = this.eventName;
    data['eventDescription'] = this.eventDescription;
    data['eventImage'] = this.eventImage;
    data['eventVenue'] = this.eventVenue;
    data['eventStartTime'] = this.eventStartTime;
    data['eventEndTime'] = this.eventEndTime;
    return data;
  }
}
