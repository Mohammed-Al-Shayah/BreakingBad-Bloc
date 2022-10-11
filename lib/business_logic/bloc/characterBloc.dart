
import 'package:flutter_api/business_logic/event/character_event.dart';
import 'package:flutter_api/business_logic/state/character_state.dart';
import 'package:flutter_api/data/api/controllers/characters_api_controller.dart';
import 'package:flutter_api/data/models/characters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterBloc extends Bloc<CharacterEvent,CharacterState>{

  CharacterBloc(super.initialState){
  on<GetAllCharacterEvent>(_GetAllCharacterEvent);
  }
  List<Character> _characters =<Character>[];
  final CharactersApiController _charactersApiController=CharactersApiController();

  void _GetAllCharacterEvent(GetAllCharacterEvent event,Emitter emitter)async{
    _characters=await _charactersApiController.getAllCharacters();
    emitter(GetAllCharacterState(_characters));
  }
}