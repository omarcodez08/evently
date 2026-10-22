class MyUser {
  static const String collectionName = "Users";
  String? id;
  String? name;
  String? email;
  List<String>? favorites;
  MyUser({this.name,this.email,this.id,this.favorites});

  MyUser.fromFireStore(Map<String,dynamic>? data){
    id = data?["id"];
    name = data?["name"];
    email = data?["email"];
    favorites = List<String>.from(data?["favoriteList"]);
  }

  Map<String,dynamic> toFireStore(){
    return {
      "id":id,
      "name":name,
      "email":email,
      "favoriteList":favorites
    };
  }
}