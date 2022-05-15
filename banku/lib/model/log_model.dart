class LogModel{
  String? userId;
  String? email;
  String? username;

  LogModel({this.userId, this.email, this.username});

  //ambil data dari server
  factory LogModel.fromMap(map){
    return LogModel(
      userId: map('userId'),
      email: map('email'),
      username: map('username')
    );
  }

  //mengirim data ke server
  Map<String, dynamic> toMap(){
    return{
      'userId':userId,
      'email':email,
      'username':username
    };
  }
}