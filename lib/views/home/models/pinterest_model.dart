class PinterestModel {
  String? title;
  String? video;
  Thumbnail? thumbnail;

  PinterestModel({this.title, this.video, this.thumbnail});

  PinterestModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    video = json['video'];
    thumbnail = json['thumbnail'] != null ? Thumbnail.fromJson(json['thumbnail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['video'] = video;
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail!.toJson();
    }
    return data;
  }
}

class Thumbnail {
  String? url;
  dynamic dominantColor;
  int? height;
  dynamic type;
  int? width;

  Thumbnail({this.url, this.dominantColor, this.height, this.type, this.width});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    dominantColor = json['dominantColor'];
    height = json['height'];
    type = json['type'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['dominantColor'] = dominantColor;
    data['height'] = height;
    data['type'] = type;
    data['width'] = width;
    return data;
  }
}
