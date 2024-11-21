class User{
  static const String collectionName="User";
  String? Id;
  String? Name;
  String? Email;
  int? Age;
  User({this.Id,this.Name,this.Email,this.Age});

  User.fromFireStore(Map<String,dynamic>? data){
    Id= data?["id"];
    Name= data?["name"];
    Email= data?["email"];
    Age= data?["age"];
  }
  Map<String,dynamic>tofireStore(){
    return{
      "id":Id,
      "name":Name,
      "email":Email,
      "age":Age
    };
  }
}