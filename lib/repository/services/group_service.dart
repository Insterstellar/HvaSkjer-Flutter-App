import 'dart:convert';

import 'package:begivenhet/models/group_model.dart';
import 'package:begivenhet/repository/interfaces/group_interface.dart';
import 'package:http/http.dart' as http;

class GroupsRepository extends GroupInterface{
  String dataUrl ='https://hva-skjer.herokuapp.com';
  ///api/v1/group/save/{id}
  @override
  Future<String> deleteCategory(GroupModel groupModel) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<List<GroupModel>> getAllGroups() async {
    List<GroupModel> groupLists=[];
    var url = Uri.parse('$dataUrl/api/v1/group/all');
    var response= await http.get(url);
    var body = json.decode(response.body);
    for(var i=0; i< body.length; i++){
      groupLists.add(GroupModel.fromJson(body[i]));

    }
    return groupLists;

  }

  @override
  Future<String> deleteGroups(GroupModel groupModel) async {
    // TODO: implement deleteGroups
    ///api/v1/group/save/{id}

    throw UnimplementedError();
  }

  @override
  Future<String> patchCompletedGroups(GroupModel groupModel) {
    // TODO: implement patchCompletedGroups
    throw UnimplementedError();
  }

  @override
  Future<String> postGroups(GroupModel groupyModel) async {
    var url = Uri.parse('$dataUrl/api/v1/group/save/${groupyModel.id}');
    await http.post(url,
    headers: {'Content-Type': 'application/json'} ,
    body: json.encode(groupyModel.toJson()))
        .then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      return result['eventName'];

    });


    // TODO: implement postGroups
    throw UnimplementedError();
  }

  @override
  Future<String> putCompletedGroups(GroupModel groupModel) {
    // TODO: implement putCompletedGroups
    throw UnimplementedError();
  }



}