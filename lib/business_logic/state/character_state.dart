
abstract class CharacterState{}

class LoadingState extends CharacterState{}
class GetAllCharacterState<Model> extends CharacterState{

  final List<Model> data;

  GetAllCharacterState(this.data);
}