class Book {
  String id;  //编号
  String img; //封面
  String title; //标题
  String author; //作者
  String category; //所属类别
  String desc;   //描述
  String link;  //下载链接

  Book.fromJson(Map<String, dynamic> json) {
    this.id = json["id"].toString();
    this.img = json["imageUrl"];
    this.title = json["title"];
    this.author = json["author"];
    this.category = json["category"];
    this.desc = json["description"];
    this.link = json["link"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json["id"] = this.id;
    json["title"] = this.title;
    json["imageUrl"] = this.img;
    json["author"] = this.author;
    json["category"] = this.category;
    json["description"] = this.desc;
    json["link"] = this.link;
    return json;
  }
}