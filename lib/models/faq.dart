import 'dart:convert';

Faq faqFromJson(String jsonStr) => Faq.fromJson(json.decode(jsonStr));
String faqToJson(Faq data) => json.encode(data.toJson());

class Faq {
  String id;
  String title;
  String content;

  Faq({
    this.id,
    this.title,
    this.content,
  });

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
        id: json["_id"],
        title: json['title'],
        content: json['content'],
      );

  Map<String, dynamic> toJson() => {
        "name": title,
        "content": content,
      };

  @override
  String toString() {
    return 'Faq({id: $id, title: $title, content: $content})';
  }
}
