class UserData {
  final String? email;

  final String? password;

  UserData({
    this.email,
    this.password,
  });

  UserData copyWith({
    String? email,
    String? password,
  }) {
    return UserData(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
