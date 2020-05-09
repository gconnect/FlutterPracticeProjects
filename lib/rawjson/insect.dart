class Insect {
  int id;
  String insect_image;
  String name;
  String longitude;
  String latitude;
  String date;
  String time;
  int count;

  Insect(
      {this.id,
      this.insect_image,
      this.name,
      this.longitude,
      this.latitude,
      this.date,
      this.time,
      this.count});

  Insect.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    insect_image = json['insect_image'];
    name = json['name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    date = json['date'];
    time = json['time'];
    count = json['count'];
  }
}
