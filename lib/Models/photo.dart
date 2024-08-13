class Photo {
  Photo({
    this.PhotoId,
    this.PhotoName,
    this.PhotoImage,
  });

  int? PhotoId;
  String? PhotoName;
  String? PhotoImage;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        PhotoId: json["PhotoId"],
        PhotoName: json["PhotoName"],
        PhotoImage: json["PhotoImage"],
      );

  Map<String, dynamic> toJson() => {
        "PhotoId": PhotoId,
        "PhotoName": PhotoName,
        "PhotoImage": PhotoImage,
      };
}
