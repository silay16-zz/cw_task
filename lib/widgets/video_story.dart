import 'package:cw_task/blocs/story/story_bloc.dart';
import 'package:cw_task/models/story.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoStory extends StatefulWidget {
  final Story story;
  VideoStory(this.story);
  @override
  _VideoStoryState createState() => _VideoStoryState();
}

class _VideoStoryState extends State<VideoStory> {
  late VideoPlayerController controller;
  bool loaded = false;

  @override
  void initState() {
    initVideo();
    super.initState();
  }

  initVideo() async {
    controller = VideoPlayerController.network(widget.story.url);
    await controller.initialize();
    print(controller.value.duration);
    setState(() {
      loaded = true;
    });
    await controller.play();
    //await Future.delayed(Duration(seconds: 2));
    context.read<StoryBloc>().add(SetDuration(controller.value.duration));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: loaded
          ? BlocConsumer<StoryBloc, StoryState>(
              listener: (context, state) {
                if (state is StoriesLoaded) {
                  if (state.paused) controller.pause();
                  if (state.released) controller.play();
                }
              },
              builder: (context, state) {
                return Container(
                  color: Colors.amber,
                  child: VideoPlayer(controller),
                );
              },
            )
          : CircularProgressIndicator(),
    );
  }
}
