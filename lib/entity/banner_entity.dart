class BannerEntity {
  BannerEntity({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  final List<Data> data;
  final int errorCode;
  final String errorMsg;

  factory BannerEntity.fromJson(Map<String, dynamic> json) {
    List<Data> dataList = [];
    if (json['data'] != null) {
      dataList = (json['data'] as List).map((item) => Data.fromJson(item)).toList();
    }
    return BannerEntity(
      data: dataList,
      errorCode: json['errorCode'] ?? 0,
      errorMsg: json['errorMsg'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((data) => data.toJson()).toList(),
      'errorCode': errorCode,
      'errorMsg': errorMsg,
    };
  }
}

class Data {
  Data({
    this.desc,
    this.id,
    this.imagePath,
    this.isVisible,
    this.order,
    this.title,
    this.type,
    this.url,
  });

  final String? desc;
  final int? id;
  final String? imagePath;
  final int? isVisible;
  final int? order;
  final String? title;
  final int? type;
  final String? url;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      desc: json['desc'],
      id: json['id'],
      imagePath: json['imagePath'],
      isVisible: json['isVisible'],
      order: json['order'],
      title: json['title'],
      type: json['type'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'desc': desc,
      'id': id,
      'imagePath': imagePath,
      'isVisible': isVisible,
      'order': order,
      'title': title,
      'type': type,
      'url': url,
    };
  }
}
