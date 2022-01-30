class LocationPost {
  final String username;
  final String mood;
  final String location;
  final String desc;

  LocationPost(
      {required this.username,
      required this.mood,
      required this.location,
      required this.desc});

  factory LocationPost.fromJson(Map<String, dynamic> json) {
    return LocationPost(
        username: json['username'],
        mood: json['mood'],
        location: json['location'],
        desc: json['desc']);
  }
}
