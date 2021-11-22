class Pass {
  late String appName;
  late String encryptedPassword;
  late int passwordId;
  late String username;

  Pass(
      {required this.appName,
      required this.encryptedPassword,
      required this.passwordId,
      required this.username});

  Pass.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    encryptedPassword = json['encrypted_password'];
    passwordId = json['password_id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_name'] = this.appName;
    data['encrypted_password'] = this.encryptedPassword;
    data['password_id'] = this.passwordId;
    data['username'] = this.username;
    return data;
  }
}
