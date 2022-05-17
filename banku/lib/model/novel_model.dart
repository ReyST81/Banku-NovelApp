
class NovelModel{
  String? genre;
  String? image;
  String? likes;
  String? title;
  String? content;
  String? description;
  String? key;
  String? user;

  NovelModel({this.content,  this.genre,  this.title,  this.description,  this.image,  this.likes, this.key, this.user});

  factory NovelModel.formJson(Map<String,dynamic>json){
    return NovelModel(
      content: json['content'],
      genre: json['genre'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      likes: json['likes'],
      user: json['user']

      );
  }
  Map<String, dynamic> toJson(){
    return{
      'content':content,
      'genre':genre,
      'title':title,
      'description':description,
      'image':image,
      'likes':likes,  
      'user': user
    };
  }
}