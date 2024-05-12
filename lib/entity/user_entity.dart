class UserEntity {
  UserEntity({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  final Data data;
  final int errorCode;
  final String errorMsg;

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      data: Data.fromJson(json['data']),
      errorCode: json['errorCode'],
      errorMsg: json['errorMsg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
      'errorCode': errorCode,
      'errorMsg': errorMsg,
    };
  }
}

class Data {
  Data({
    required this.admin,
    required this.chapterTops,
    required this.coinCount,
    required this.collectIds,
    required this.email,
    required this.icon,
    required this.id,
    required this.nickname,
    required this.password,
    required this.publicName,
    required this.token,
    required this.type,
    required this.username,
  });

  final bool admin;
  final List<dynamic> chapterTops;
  final int coinCount;
  final List<dynamic> collectIds;
  final String email;
  final String icon;
  final int id;
  final String nickname;
  final String password;
  final String publicName;
  final String token;
  final int type;
  final String username;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      admin: json['admin'] ?? false,
      chapterTops: json['chapterTops'] ?? [],
      coinCount: json['coinCount'] ?? 0,
      collectIds: json['collectIds'] ?? [],
      email: json['email'] ?? '',
      icon: json['icon'] ?? '',
      id: json['id'] ?? 0,
      nickname: json['nickname'] ?? '',
      password: json['password'] ?? '',
      publicName: json['publicName'] ?? '',
      token: json['token'] ?? '',
      type: json['type'] ?? 0,
      username: json['username'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'admin': admin,
      'chapterTops': chapterTops,
      'coinCount': coinCount,
      'collectIds': collectIds,
      'email': email,
      'icon': icon,
      'id': id,
      'nickname': nickname,
      'password': password,
      'publicName': publicName,
      'token': token,
      'type': type,
      'username': username,
    };
  }
}


// class UserEntity {
//     final int errorCode;
//     final String errorMsg;
//     final Data data;
//     UserEntity()
//
//
// }
//
// class Data{
//   final bool admin;
//   final
// }