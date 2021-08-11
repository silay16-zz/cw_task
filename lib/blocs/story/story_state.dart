part of 'story_bloc.dart';

@immutable
abstract class StoryState {}

class StoryInitial extends StoryState {}

class StoriesLoaded extends StoryState {
  final String userId;
  final int storyIndex;
  final List<Story> stories;
  final bool paused, released;
  final Duration duration;
  bool get isVideo => stories[storyIndex].isVideo;
  StoriesLoaded(
    this.userId,
    this.stories,
    this.storyIndex, [
    this.paused = false,
    this.released = false,
    this.duration = const Duration(seconds: 5),
  ]);

  StoriesLoaded pause() {
    return StoriesLoaded(this.userId, stories, storyIndex, true);
  }

  StoriesLoaded play() {
    return StoriesLoaded(this.userId, stories, storyIndex, false, true);
  }

  StoriesLoaded changeIndex(String newId, int newIndex, [List<Story>? newStories]) {
    print("change index calledd");
    List<Story> _newStories = newStories ?? stories;
    bool _isVideo = _newStories[newIndex].isVideo;
    return StoriesLoaded(newId, _newStories, newIndex, false, false);
  }

  StoriesLoaded setDuration(Duration duration) {
    print("set duration called");
    return StoriesLoaded(userId, stories, storyIndex, false, true, duration);
  }
}

class StoryFinish extends StoryState {}
