
class Homeblogs {
  String name;
  String email;
  List<Blogs> blogs;

  Homeblogs({
    this.name = "",
    this.email = "",
    this.blogs = const <Blogs>[],
  });

  factory Homeblogs.fromJson(Map<String, dynamic> json) {
    List<Blogs> blogs = json["blogs"].map<Blogs>((jsonx) {
      return Blogs.fromJson(jsonx);
    }).toList();
    return Homeblogs(
      name: json['name'],
      email: json['_id'],
      blogs: blogs,
    );
  }
}

class Blogs {
  String title;
  String thumbnail;
  String content;
  String description;
  Blogs({
    this.title = "",
    this.thumbnail = "",
    this.content = "",
    this.description = "",
  });

  factory Blogs.fromJson(Map<String, dynamic> json) {
    return Blogs(
        title: json["title"],
        thumbnail: json["thumbnail"],
        content: json["content"],
        description: json["description"]);
  }
}
