import 'package:cw_task/blocs/story/story_bloc.dart';
import 'package:cw_task/widgets/animated_bar.dart';
import 'package:cw_task/widgets/story_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<StoryBloc, StoryState>(
          builder: (context, state) {
            if (state is StoriesLoaded) {
              return Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: StoryViewer(state.stories[state.storyIndex]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, left: 20.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.yellow,
                          child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.red,
                              child: Text(
                                state.userId,
                                style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w700),
                              )),
                        )),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedBar(),
                  ),
                ],
              );
            } else
              return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: context
                      .read<StoryBloc>()
                      .userIds
                      .map(
                        (e) => TextButton(
                          onPressed: () => context.read<StoryBloc>().add(LoadStories(e)),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.yellow.shade800,
                            child: CircleAvatar(
                              radius: 48,
                              backgroundColor: Colors.red,
                              child: Text(
                                e,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList());
          },
        ),
      ),
    );
  }
}
