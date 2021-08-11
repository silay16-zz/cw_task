import 'package:cw_task/blocs/story/story_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedBar extends StatefulWidget {
  @override
  _AnimatedBarState createState() => _AnimatedBarState();
}

class _AnimatedBarState extends State<AnimatedBar> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(seconds: 5));
    controller.addListener(() {
      if (controller.value == 1) {
        context.read<StoryBloc>().add(UserTappedRight());
      }
    });
    if (!(context.read<StoryBloc>().state as StoriesLoaded).paused) controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoryBloc, StoryState>(
      listener: (context, state) {
        if (state is StoriesLoaded) {
          controller.duration = state.duration;
          if (state.isVideo && !state.paused && !state.released)
            controller.reset();
          else if (state.paused)
            controller.stop();
          else if (state.released)
            controller.forward();
          else {
            controller.reset();
            controller.forward();
          }
        }
      },
      builder: (context, state) {
        if (state is StoriesLoaded)
          return Row(
            children: List<int>.generate(state.stories.length, (i) => i)
                .map(
                  (i) => Expanded(
                    flex: 1,
                    child: Padding(
                        padding: EdgeInsets.all(32),
                        child: i < state.storyIndex
                            ? _renderFullBar()
                            : i == state.storyIndex
                                ? AnimatedBuilder(
                                    animation: controller,
                                    builder: (c, _) => LinearProgressIndicator(
                                      minHeight: 8,
                                      value: controller.value,
                                      backgroundColor: Colors.white30,
                                      valueColor: AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  )
                                : _renderEmptyBar()),
                  ),
                )
                .toList(),
          );
        else
          return Container();
      },
    );
  }

  Widget _renderEmptyBar() {
    return Container(
      height: 8,
      color: Colors.white24,
    );
  }

  Widget _renderFullBar() {
    return Container(
      height: 8,
      color: Colors.white,
    );
  }
}
