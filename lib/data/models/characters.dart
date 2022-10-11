class Character {
  late int charId;
  late String name;
  late String birthday;
  late List<dynamic>? occupation;
  late String img;
  late String status;
  late String nickname;
  late List<int> appearance;
  late String portrayed;
  late String category;
  late List<dynamic> betterCallSaulAppearance;

  Character(
      {required this.charId,
       required  this.name,
       required  this.birthday,
       required  this.occupation,
       required  this.img,
       required  this.status,
       required  this.nickname,
       required  this.appearance,
       required  this.portrayed,
       required  this.category,
       required  this.betterCallSaulAppearance
      });

  Character.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    birthday = json['birthday'];
    occupation = json['occupation'].cast<String>();
    img = json['img'];
    status = json['status'];
    nickname = json['nickname'];
    appearance = json['appearance'].cast<int>();
    portrayed = json['portrayed'];
    category = json['category'];
    betterCallSaulAppearance = json['better_call_saul_appearance'];
    }
  }

