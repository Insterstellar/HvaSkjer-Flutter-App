import 'package:begivenhet/repository/services/group_service.dart';

import '../models/group_model.dart';

class GroupController {
  final GroupsRepository _groupsRepository;
  GroupController(this._groupsRepository);

  Future<List<GroupModel>>fetchGroupLists() async {
    return _groupsRepository.getAllGroups();
  }
}