class NovelModel{
  String? genre;
  String? image;
  String? title;
  String? content;
  String? description;
  String? key;
  String? user;
  String? date;
  NovelModel({this.content,  this.genre,  this.title,  this.description,  this.image, this.key, this.user, this.date});

  factory NovelModel.formJson(Map<String,dynamic>json){
    return NovelModel(
      content: json['content'],
      genre: json['genre'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      user: json['user'],
      date: json['date']
      );
  }
  Map<String, dynamic> toJson(){
    return{
      'content':content,
      'genre':genre,
      'title':title,
      'description':description,
      'image':image,
      'user': user,
      'date': date
    };
  }
}