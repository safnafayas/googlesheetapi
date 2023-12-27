class UserFields{
  static final String id='Id';
  static final String character_name='Character';
  static final String real_name='RealName';
  static final String role='Role';
  static final String age='Age';
 static List<String> getFields()=>[id,character_name,real_name,role,age];

}
class User {
  final int? id;
  final String character_name;
  final String real_name;
  final String role;
  final int age;

  const User({required this.id,required this.character_name,required this.real_name,required this.role,required this.age,});

  Map<String,dynamic> toJson()=>{
    UserFields.id:id,
    UserFields.character_name:character_name,
    UserFields.real_name:real_name,
    UserFields.role:role,
    UserFields.age:age
  };


}