import "dart:convert";
import "user_model.dart";

ApiReponse customResponseFromJson(String str) => ApiReponse.fromJson(json.decode(str));

String customResponseToJson(ApiReponse data) => json.encode(data.toJson());

class ApiReponse {
  String status;
  List<dynamic>? items;
  Item? item;
  String? message;
  String? accessToken;
  int? expiresIn;
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<dynamic>? data;
  UserModel? user;

  ApiReponse({
    required this.status,
    required this.items,
    required this.item,
    required this.message,
    required this.accessToken,
    required this.expiresIn,
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.user,
  });

  factory ApiReponse.fromJson(Map<String, dynamic> json) => ApiReponse(
    status: json["status"],
    items: List<dynamic>.from(json["items"].map((x) => x)),
    item: Item.fromJson(json["item"]),
    message: json["message"],
    accessToken: json["accessToken"],
    expiresIn: json["expiresIn"],
    page: json["page"],
    perPage: json["per_page"],
    total: json["total"],
    totalPages: json["total_pages"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
    user: UserModel.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "items": List<dynamic>.from(items!.map((x) => x)),
    "item": item!.toJson(),
    "message": message,
    "accessToken": accessToken,
    "expiresIn": expiresIn,
    "page": page,
    "per_page": perPage,
    "total": total,
    "total_pages": totalPages,
    "data": List<dynamic>.from(data!.map((x) => x)),
    "user": user!.toJson(),
  };
}

class Item {
  Item();
  factory Item.fromJson(Map<String, dynamic> json) => Item();
  Map<String, dynamic> toJson() => {};
}
