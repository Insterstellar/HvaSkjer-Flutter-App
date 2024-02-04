import 'dart:convert';

import 'package:begivenhet/models/events.dart';
import 'package:begivenhet/repository/interfaces/events_interface.dart';
import 'package:http/http.dart' as http;

import '../../models/category_model.dart';
import '../../models/group_model.dart';

class EventsRepository implements Repository {
  String dataUrl = 'https://hva-skjer.herokuapp.com';
  //https://hva-skjer.herokuapp.com/api/v1/events/save/71/111
  //var httpResponse = await http.get(Uri.http('hva-skjer.herokuapp.com','api/v1/events/all'));
  //String dataUrl=
  @override
  Future<String> deleteEvent(EventsModel events) {
    // TODO: implement deleteEvent
    throw UnimplementedError();
  }

  @override
  Future<List<EventsModel>> getAllEvents() async {
    List<EventsModel> eventLists = [];
    var url = Uri.parse('$dataUrl/api/v1/events/all');
    var response = await http.get(url);
    var body = json.decode(response.body);

    for (var i = 0; i < body.length; i++) {
      eventLists.add(EventsModel.fromJson(body[i]));
    }

    return eventLists;

    // TODO: implement getAllEvents
    throw UnimplementedError();
  }

  // update an existing event or modify existing variablesgv
  @override
  Future<String> patchCompleted(EventsModel events) async {
    //to be ignored : https://hva-skjer.herokuapp.com/api/v1/events/save/71/111
    //http://localhost:8080/api/v1/events/updte/7
    var url = Uri.parse('$dataUrl/api/v1/events/updte/${events.id}');
    String resData = '';
    await http
        .patch(url,
            headers: {'Content-Type': 'application/json'},
            body: json.encode(events.toJson()))
        .then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      return resData = result['eventName'];
    });

    return resData;

    // TODO: implement patchCompleted
    //throw UnimplementedError();
  }

  // create a new event



  //update /create a new event /replace
  @override
  Future<String> putCompleted(EventsModel events) {
    // TODO: implement putCompleted
    throw UnimplementedError();
  }

  @override
  Future<String> postEvent(EventsModel events, GroupModel groupModel, CategoryModel categoryModel) async {
    var urlPost = Uri.parse('$dataUrl/api/v1/events/save/${groupModel.id}/${categoryModel.id}');
    var errorMessage;

    try {
      final response = await http.post(
        urlPost,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(events.toJson()),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return EventsModel.fromJson(jsonData).toString();
      } else {
        // Error in POST request
        print('Failed to post data. Error code: ${response.statusCode}');
        errorMessage=response.statusCode;

      }
    } catch (e) {
      // Exception occurred during POST request
      print('Failed to post data. Error: $e');
    }

    return errorMessage.toString(); // Return null in case of error
  }

}
