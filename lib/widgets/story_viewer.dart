import 'package:cw_task/blocs/story/story_bloc.dart';
import 'package:cw_task/models/story.dart';
import 'package:cw_task/widgets/video_story.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StoryViewer extends StatelessWidget {
  final Story story;
  StoryViewer(this.story);

  tapUp(TapUpDetails details, StoryBloc bloc, Size size) {
    if (details.globalPosition.dx < size.width * .3)
      bloc.add(UserTappedLeft());
    else
      bloc.add(UserTappedRight());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    StoryBloc storyBloc = context.read<StoryBloc>();
    return GestureDetector(
      onLongPressStart: (_) => storyBloc.add(UserHoldDown()),
      onLongPressEnd: (_) => storyBloc.add(UserReleasedUp()),
      onTapUp: (d) => tapUp(d, storyBloc, size),
      child: Center(
        child: story.isVideo
            ? VideoStory(story)
            : Image.network(
                story.url,
                height: size.height,
                width: size.width,
                fit: BoxFit.fill,
              ),
      ),
    );
  }
}
