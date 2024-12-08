class PostDTO {
  final String title;
  final String description;

  const PostDTO({
    required this.title,
    required this.description,
  });

  factory PostDTO.fromJson(Map<String, dynamic> json) {
    return PostDTO(
      title: json['title'],
      description: json['description'],
    );
  }
}