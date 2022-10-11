import 'package:flutter/material.dart';
import 'package:flutter_api/business_logic/bloc/characterBloc.dart';
import 'package:flutter_api/business_logic/event/character_event.dart';
import 'package:flutter_api/business_logic/state/character_state.dart';
import 'package:flutter_api/data/api/controllers/characters_api_controller.dart';
import 'package:flutter_api/data/models/characters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character> _characters = <Character>[];
  late Future<List<Character>> _future;
  late List<Character> searchedForCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = CharactersApiController().getAllCharacters();
    BlocProvider.of<CharacterBloc>(context).add(GetAllCharacterEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: _isSearching
            ? BackButton(
          color: Colors.amber,
        )
            : Container(),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        buildWhen: (previous, current) =>
            current is LoadingState ||
            current is GetAllCharacterState<Character>,
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                      strokeWidth: 15,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is GetAllCharacterState<Character> &&
              state.data.isNotEmpty) {
            _characters = state.data ?? [];
            return GridView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: _characters.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/quotes_screen');
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                    padding: const EdgeInsetsDirectional.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Hero(
                          tag: _characters[index].charId,
                          child: SizedBox(
                            width: double.infinity,
                            height: 230,
                            child: Image.network(_characters[index].img,
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 35,
                          color: Colors.amber,
                          child: Center(
                            child: Text(
                              _characters[index].name,
                              style:const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            Center(
              child: Column(
                children:const  [
                  Text(
                    'Not found Characters',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Icon(Icons.error, size: 100),
                ],
              ),
              // CircularProgressIndicator(),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: Colors.grey,
      decoration:const InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
      ),
      style:const TextStyle(color: Colors.grey, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedFOrItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedFOrItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = _characters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: Colors.grey),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget _buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(color: Colors.grey),
    );
  }

}
