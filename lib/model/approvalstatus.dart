class ApprovalStatus {
  String level;
  String status;

  ApprovalStatus({this.level, this.status});

  ApprovalStatus.fromJson(Map<String, dynamic> json) {
    level = json['Level'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Level'] = this.level;
    data['Status'] = this.status;
    return data;
  }
}
