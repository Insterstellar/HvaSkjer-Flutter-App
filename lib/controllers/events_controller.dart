import 'package:begivenhet/models/category_model.dart';
import 'package:begivenhet/models/events.dart';
import 'package:begivenhet/models/events.dart';
import 'package:begivenhet/repository/interfaces/events_interface.dart';

import '../models/group_model.dart';

class EventsController {
  final Repository _repository;
  EventsController(this._repository);


  Future<List<EventsModel>> fetchEventsLists() async {
    return _repository.getAllEvents();
  }

  Future<String> postEvent(EventsModel events, GroupModel groupModel, CategoryModel categoryModel) async {
    return _repository.postEvent(events, groupModel, categoryModel);
  }
}
