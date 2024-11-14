class UserDM {
  static const String collectionName = 'users';
  static UserDM? currentUser;

  String id;

  String userName;

  String email;

  UserDM({required this.id, required this.userName, required this.email});

  Map<String, dynamic> toFireStore() => {
        'id': id,
        'email': email,
        'userName': userName,
      };

  UserDM.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
          userName: data['userName'],
          email: data['email'],
        );
}
