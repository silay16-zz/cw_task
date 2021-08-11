import 'package:cw_task/blocs/story/story_bloc.dart';
import 'package:cw_task/screens/story_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoryBloc(),
      child: MaterialApp(
        title: 'Codeway',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StoryScreen(),
      ),
    );
  }
}
