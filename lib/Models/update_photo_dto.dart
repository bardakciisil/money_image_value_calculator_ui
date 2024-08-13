class UpdatePhotoDto {
  UpdatePhotoDto({
    this.PhotoId,
    this.PhotoName,
    this.PhotoImage,
    this.ImageFile,
  });

  int? PhotoId;
  String? PhotoName;
  String? PhotoImage;
  String? ImageFile;

  factory UpdatePhotoDto.fromJson(Map<String, dynamic> json) => UpdatePhotoDto(
        PhotoId: json["PhotoId"],
        PhotoName: json["PhotoName"],
        PhotoImage: json["PhotoImage"],
        ImageFile: json["ImageFile"],
      );

  Map<String, dynamic> toJson() => {
        "PhotoId": PhotoId,
        "PhotoName": PhotoName,
        "PhotoImage": PhotoImage,
        "ImageFile": ImageFile,
      };
}
