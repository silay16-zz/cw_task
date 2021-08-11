import 'package:cw_task/models/story.dart';

Story story1 = Story(
  userName: "John",
  url: "https://picsum.photos/200/300",
  isVideo: false,
);
Story story2 = Story(
  userName: "John",
  url: "https://picsum.photos/200/301",
  isVideo: false,
);
Story story3 = Story(
  userName: "Shyam",
  url: "https://picsum.photos/200/302",
  isVideo: false,
);
Story story4 = Story(
  userName: "Bob",
  url: "https://picsum.photos/200/303",
  isVideo: false,
);
Story story5 = Story(
  userName: "Bob",
  url: "https://download.samplelib.com/mp4/sample-5s.mp4",
  isVideo: true,
);

List<Story> stories = [story1, story2, story3, story4, story5];
Map<String, Story> users = Map<String, Story>.fromIterable(
  stories,
  key: (s) => s.userName,
  value: (s) => s,
);

Map<String, List<Story>> createUsers() {
  Map<String, List<Story>> response = {};
  for (var story in stories) {
    response.putIfAbsent(story.userName, () => []);
    response[story.userName]!.add(story);
  }
  return response;
}
