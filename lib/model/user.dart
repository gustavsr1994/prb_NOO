class User {
  int id;
  String username;
  String name;
  String role;
  String lastLogin;
  int approvalRole;

  User(
      {this.id,
        this.username,
        this.name,
        this.role,
        this.lastLogin,
        this.approvalRole});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['Username'];
    name = json['Name'];
    role = json['Role'];
    lastLogin = json['LastLogin'];
    approvalRole = json['ApprovalRole'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Username'] = this.username;
    data['Name'] = this.name;
    data['Role'] = this.role;
    data['LastLogin'] = this.lastLogin;
    data['ApprovalRole'] = this.approvalRole;
    return data;
  }
}