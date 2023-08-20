class SingleEventModal {
  late Content content;
  late bool status;
  String? error;

  SingleEventModal({required this.content, required this.status});

  SingleEventModal.fromJson(Map<String, dynamic> json) {
    content =
        (json['content'] != null ? new Content.fromJson(json['content']) : null)!;
    status = json['status'];
  }
  SingleEventModal.withError(String errorMessage) {
    error = errorMessage;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Content {
 late Data data;

  Content({required this.data});

  Content.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  late int id;
  late String title;
  late String description;
 late String bannerImage;
  late String dateTime;
  late String organiserName;
  late String organiserIcon;
  late String venueName;
  late String venueCity;
  late String venueCountry;

  Data(
      {required this.id,
      required this.title,
      required this.description,
      required this.bannerImage,
      required this.dateTime,
      required this.organiserName,
      required this.organiserIcon,
      required this.venueName,
      required this.venueCity,
      required this.venueCountry});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    bannerImage = json['banner_image'];
    dateTime = json['date_time'];
    organiserName = json['organiser_name'];
    organiserIcon = json['organiser_icon'];
    venueName = json['venue_name'];
    venueCity = json['venue_city'];
    venueCountry = json['venue_country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['banner_image'] = this.bannerImage;
    data['date_time'] = this.dateTime;
    data['organiser_name'] = this.organiserName;
    data['organiser_icon'] = this.organiserIcon;
    data['venue_name'] = this.venueName;
    data['venue_city'] = this.venueCity;
    data['venue_country'] = this.venueCountry;
    return data;
  }
}
