class MobileApiResponse {
  MobileApiResponse({
    this.hasError,
    this.errorMessage,
  });

  bool? hasError;
  String? errorMessage;

  factory MobileApiResponse.fromJson(Map<String, dynamic> json) =>
      MobileApiResponse(
        hasError: json["hasError"],
        errorMessage: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "hasError": hasError,
        "message": errorMessage,
      };
}
