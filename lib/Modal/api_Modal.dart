class ApiModal {
  final String Image;

  ApiModal({
    required this.Image,
  });

  factory ApiModal.fromMaptoImageObject({required Map data}) {
    return ApiModal(Image: data['largeImageURL']);
  }
}
