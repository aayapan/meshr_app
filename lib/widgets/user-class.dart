class User {
  String username;
  List<String> thumbPaths;

  User({required this.username, required this.thumbPaths});

  Map<String, dynamic> toJson() => {
        'usernam': username,
        'thumbPaths': thumbPaths,
      };

  static User fromJson(Map<String, dynamic> json) =>
      User(username: json['username'], thumbPaths: json['thumbPaths']);
}
