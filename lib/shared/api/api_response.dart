class APIResponse {
  final String id;
  final DateTime expiration;
  final DateTime timestamp;

  APIResponse({required this.id, required this.expiration, required this.timestamp});
}

class APIResponseData extends APIResponse {
  final Map<String, dynamic> data;

  APIResponseData({required super.id, required super.expiration, required super.timestamp, required this.data});

  factory APIResponseData.fromJson(Map<String, dynamic> data) {
    return APIResponseData(
      expiration: data["expiration"],
      id: data["id"],
      timestamp: data["timestamp"],
      data: data["data"]
    );
  }
}

class APIResponseError extends APIResponse { 
  final String error;

  APIResponseError({required super.id, required super.expiration, required super.timestamp, required this.error});

  factory APIResponseError.fromJson(Map<String, dynamic> data) {
    return APIResponseError(
      expiration: data["expiration"],
      id: data["id"],
      timestamp: data["timestamp"],
      error: data["error"]
    );
  }
}
