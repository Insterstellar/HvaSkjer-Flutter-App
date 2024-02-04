import 'package:begivenhet/models/group_model.dart';

abstract class GroupInterface {
  Future<List<GroupModel>>getAllGroups();
  Future<String> patchCompletedGroups(GroupModel groupModel);
  Future<String> putCompletedGroups(GroupModel groupModel);
  Future<String> deleteGroups(GroupModel groupModel);
  Future<String> postGroups(GroupModel groupyModel);
}