class WidgetResponse {
  final String id;
  final String userId;
  final dynamic data;
  final String description;

  factory WidgetResponse.fromJson(Map<String, dynamic> json) {
    return WidgetResponse(
      id: json["id"],
      userId: json["userId"],
      data: json["data"],
      description: json["description"],
    );
  }

  @override
  String toString() {
    return "$id, $userId, $data, $description";
  }

  const WidgetResponse({
    required this.id,
    required this.userId,
    required this.data,
    required this.description,
  });
}
