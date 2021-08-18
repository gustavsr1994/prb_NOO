class User {
  int id;
  String username;
  String name;
  String role;
  String lastLogin;
  int approvalRole;
  String so;
  String bu;

  User(
      {this.id,
        this.username,
        this.name,
        this.role,
        this.lastLogin,
        this.so,
        this.bu,
        this.approvalRole});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['Username'];
    name = json['Name'];
    role = json['Role'];
    lastLogin = json['LastLogin'];
    approvalRole = json['ApprovalRole'];
    so = json['SO'];
    bu = json["BU"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Username'] = this.username;
    data['Name'] = this.name;
    data['Role'] = this.role;
    data['LastLogin'] = this.lastLogin;
    data['ApprovalRole'] = this.approvalRole;
    data['SO'] = this.so;
    data['BU'] = this.bu;
    return data;
  }
}