import 'package:begivenhet/models/category_model.dart';
import 'package:begivenhet/models/events.dart';

import '../../models/group_model.dart';

abstract class Repository {
  Future<List<EventsModel>>getAllEvents();
  Future<String> patchCompleted(EventsModel events);
  Future<String> putCompleted(EventsModel events);
  Future<String> deleteEvent(EventsModel events);
  Future<String> postEvent(EventsModel events, GroupModel groupModel,CategoryModel categoryModel);
}