import 'package:flutter/material.dart';
import 'package:flutter_api/business_logic/bloc/characterBloc.dart';
import 'package:flutter_api/business_logic/state/character_state.dart';
import 'package:flutter_api/view/screen/characters_screen.dart';
import 'package:flutter_api/view/screen/quotes_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterBloc>(create:(context)=>CharacterBloc(LoadingState())),
      ],
      child: MyMaterialApp(),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/characters_screen',
      routes: {
        '/characters_screen': (context) => const CharactersScreen(),
        '/quotes_screen': (context) => const QuotesScreen(),
      },
    );
  }
}

