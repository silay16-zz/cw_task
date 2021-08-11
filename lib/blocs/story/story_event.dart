part of 'story_bloc.dart';

@immutable
abstract class StoryEvent {}

class UserTappedRight extends StoryEvent {}

class UserTappedLeft extends StoryEvent {}

class UserHoldDown extends StoryEvent {}

class UserReleasedUp extends StoryEvent {}

class LoadStories extends StoryEvent {
  final String userId;
  LoadStories(this.userId);
}

class SetDuration extends StoryEvent {
  final Duration duration;
  SetDuration(this.duration);
}
