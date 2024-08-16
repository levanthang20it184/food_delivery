class UserModel{
  int _id;
  String _name;
  String _email;
  String _phone;
  int _orderCount;
  int get id => _id;
  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  int get orderCount => _orderCount;
  
  UserModel({
    required id,
    required name,
    required email,
    required phone,
    required orderCount,
  }): _id = id,
        _name = name,
        _email = email,
        _phone = phone,
        _orderCount = orderCount;
  factory UserModel.fromJson(Map<String, dynamic> json )
  {
    return UserModel(
      id: json['id'], 
      name: json['f_name'],
      email: json['email'], 
      phone: json['phone'], 
      orderCount: json['order_count'],
      );
  }
  

}