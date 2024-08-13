class PhotoDto {
  PhotoDto({
    this.PhotoName,
    this.PhotoImage,
    this.ImageFile,
  });

  String? PhotoName;
  String? PhotoImage;
  String? ImageFile;

  factory PhotoDto.fromJson(Map<String, dynamic> json) => PhotoDto(
        PhotoName: json["PhotoName"],
        PhotoImage: json["PhotoImage"],
        ImageFile: json["ImageFile"],
      );

  Map<String, dynamic> toJson() => {
        "PhotoName": PhotoName,
        "PhotoImage": PhotoImage,
        "ImageFile": ImageFile,
      };
}
