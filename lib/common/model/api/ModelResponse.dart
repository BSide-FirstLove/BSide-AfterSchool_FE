class ModelResponse {
  final int resultCode;
  final String message;
  final Map<String, dynamic> data;

  const ModelResponse({
    required this.resultCode,
    required this.message,
    required this.data,
  });

  factory ModelResponse.fromJson(Map<String, dynamic> json) {
    return ModelResponse(
      resultCode: json['resultCode'],
      message: json['message'],
      data: json['data'],
    );
  }
}