class ApiResponse {
  final String id;
  final DateTime timestamp;

  ApiResponse({
    required this.id, 
    required this.timestamp});
}

class APIResponseData extends ApiResponse {
  final dynamic data;

  APIResponseData({
    required super.id, 
    required super.timestamp,
    required this.data});

  factory APIResponseData.fromJson(Map<String, dynamic> data) {
    return APIResponseData(
      id: data["responseId"],
      timestamp: DateTime.parse(data["timestamp"]),
      data: data["data"]
    );
  }
}

class APIResponseError extends ApiResponse { 
  final String error;

  APIResponseError({
    required super.id,
    required super.timestamp, 
    required this.error});

  factory APIResponseError.fromJson(Map<String, dynamic> data) {
    return APIResponseError(
      id: data["id"],
      timestamp: data["timestamp"],
      error: data["error"]
    );
  }
}
