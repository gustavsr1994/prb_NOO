class Address {
  int id;
  String name;
  String streetName;
  String city;
  String country;
  String state;
  int zipCode;
  int parentId;
  String long;
  String lat;

  Address(
      {this.id,
        this.name,
        this.streetName,
        this.city,
        this.country,
        this.state,
        this.zipCode,
        this.parentId,
        this.long,
        this.lat,
      });

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    streetName = json['StreetName'];
    city = json['City'];
    country = json['Country'];
    state = json['State'];
    zipCode = json['ZipCode'];
    parentId = json['ParentId'];
    long = json['Long'];
    lat = json['Lat'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['StreetName'] = this.streetName;
    data['City'] = this.city;
    data['Country'] = this.country;
    data['State'] = this.state;
    data['ZipCode'] = this.zipCode;
    data['ParentId'] = this.parentId;
    data['Long'] = this.long;
    data['Lat'] = this.lat;
    return data;
  }
}
