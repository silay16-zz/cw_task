import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cw_task/models/story.dart';
import 'package:cw_task/models/story_data.dart';
import 'package:meta/meta.dart';

part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  late Map<String, List<Story>> users;
  List<String> get userIds => users.keys.toList();
  StoryBloc() : super(StoryInitial()) {
    users = createUsers();
  }

  StoryState handleRight(StoriesLoaded _state) {
    print("tap right");
    int len = users[_state.userId]!.length;
    int userIndex = userIds.indexOf(_state.userId);
    if (_state.storyIndex == len - 1) {
      if (userIndex == userIds.length - 1) return StoryFinish();
      String newUserId = userIds[userIndex + 1];
      return _state.changeIndex(newUserId, 0, users[newUserId]);
    } else {
      return _state.changeIndex(_state.userId, _state.storyIndex + 1);
    }
  }

  StoryState handleLeft(StoriesLoaded _state) {
    print("tap left");
    int userIndex = userIds.indexOf(_state.userId);
    if (_state.storyIndex == 0) {
      if (userIndex == 0) return StoryFinish();
      String newUserId = userIds[userIndex - 1];
      int newIndex = users[newUserId]!.length - 1;
      return _state.changeIndex(newUserId, newIndex, users[newUserId]);
    } else {
      return _state.changeIndex(_state.userId, _state.storyIndex - 1);
    }
  }

  @override
  Stream<StoryState> mapEventToState(StoryEvent event) async* {
    if (event is UserHoldDown)
      yield (state as StoriesLoaded).pause();
    else if (event is UserReleasedUp)
      yield (state as StoriesLoaded).play();
    else if (event is UserTappedRight)
      yield handleRight(state as StoriesLoaded);
    else if (event is UserTappedLeft)
      yield handleLeft(state as StoriesLoaded);
    else if (event is LoadStories) {
      yield StoriesLoaded(event.userId, users[event.userId]!, 0);
    } else if (event is SetDuration) yield (state as StoriesLoaded).setDuration(event.duration);
  }
}
