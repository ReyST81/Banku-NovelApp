class LogModel{
  String? userId;
  String? email;
  String? username;

  LogModel({this.userId, this.email, this.username});

  factory LogModel.fromMap(map){
    return LogModel(
      userId: map('userId'),
      email: map('email'),
      username: map('username')
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'userId':userId,
      'email':email,
      'username':username
    };
  }
}