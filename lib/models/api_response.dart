// import "dart:convert";
import "user_model.dart";

// ApiResponse customResponseFromJson(String str) => ApiResponse.fromJson(json.decode(str));

// String customResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse<T> {
  final String status;
  final T? data;
  final String? message;
  final String? accessToken;
  final int? expiresIn;
  final int? page;
  final int? perPage;
  final int? total;
  final int? totalPages;

  ApiResponse({
    required this.status,
    this.data,
    this.message,
    this.accessToken,
    this.expiresIn,
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
  });

  bool get isSuccess => status == "success" || status == "ok";
  bool get isError => status == "error";
  bool get hasData => data != null;

  factory ApiResponse.fromJson(Map<String, dynamic> json, {required T Function(dynamic) dataParser}) {
    return ApiResponse<T>(
      status: json["status"] ?? "unknown",
      data: json["data"] != null ? dataParser(json["data"]) : null,
      message: json["message"],
      accessToken: json["accessToken"],
      expiresIn: json["expiresIn"],
      page: json["page"],
      perPage: json["per_page"],
      total: json["total"],
      totalPages: json["total_pages"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    if (data != null) "data": data,
    if (message != null) "message": message,
    if (accessToken != null) "accessToken": accessToken,
    if (expiresIn != null) "expiresIn": expiresIn,
    if (page != null) "page": page,
    if (perPage != null) "per_page": perPage,
    if (total != null) "total": total,
    if (totalPages != null) "total_pages": totalPages,
  };

  @override
  String toString() => "ApiResponse(status: $status, hasData: $hasData)";
}

class ListResponse<T> {
  final String status;
  final List<T> items;
  final int? page;
  final int? perPage;
  final int? total;
  final int? totalPages;
  final String? message;

  ListResponse({
    required this.status,
    required this.items,
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.message,
  });

  bool get isSuccess => status == "success" || status == "ok";

  factory ListResponse.fromJson(Map<String, dynamic> json, {required T Function(dynamic) itemParser}) {
    final items = json["items"] ?? json["data"] ?? [];
    return ListResponse<T>(
      status: json["status"] ?? "unknown",
      items: List<T>.from(items.map((x) => itemParser(x))),
      page: json["page"],
      perPage: json["per_page"],
      total: json["total"],
      totalPages: json["total_pages"],
      message: json["message"],
    );
  }
}

class SingleResponse<T> {
  final String status;
  final T? data;
  final String? message;

  SingleResponse({required this.status, this.data, this.message});

  bool get isSuccess => status == "success" || status == "ok";

  factory SingleResponse.fromJson(Map<String, dynamic> json, {required T Function(dynamic) dataParser}) {
    return SingleResponse<T>(
      status: json["status"] ?? "unknown",
      data: json["data"] != null ? dataParser(json["data"]) : null,
      message: json["message"],
    );
  }
}

class AuthResponse {
  final String status;
  final String? accessToken;
  final int? expiresIn;
  final UserModel? user;
  final String? message;

  AuthResponse({required this.status, this.accessToken, this.expiresIn, this.user, this.message});

  bool get isSuccess => status == "success" || status == "ok";

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      status: json["status"] ?? "unknown",
      accessToken: json["accessToken"],
      expiresIn: json["expiresIn"],
      user: json["user"] != null ? UserModel.fromJson(json["user"]) : null,
      message: json["message"],
    );
  }
}
