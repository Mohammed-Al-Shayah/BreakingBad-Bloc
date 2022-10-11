import 'dart:convert';

import 'package:flutter_api/data/api/api_settings.dart';
import 'package:flutter_api/data/models/characters.dart';
import 'package:http/http.dart' as http;
class CharactersApiController {
  Future<List<Character>> getAllCharacters() async{
    var url = Uri.parse(ApiSettings.CHARACTERS);
    var response =await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse=jsonDecode(response.body);
      var jsonArray= jsonResponse as List;
      return jsonArray.map((jsonObject) => Character.fromJson(jsonObject) ).toList();
    }
    else if (response.statusCode ==400 ){
      // print(response.reasonPhrase);

    }else{
    //
    }
    return[];
  }

}