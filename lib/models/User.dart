class UserModel {
  int id;
  String name;
  String uniqId;
  String mobile;
  dynamic entrepriseId;
  String photo;
  String email;
  dynamic emailVerifiedAt;
  dynamic pays;
  dynamic ville;
  dynamic deleted_by;
  dynamic deleted_at;
  DateTime createdAt;
  DateTime updatedAt;

  UserModel(
    this.id,
    this.uniqId,
    this.name,
    this.mobile,
    this.entrepriseId,
    this.photo,
    this.email,
    this.emailVerifiedAt,
    this.pays,
    this.ville,
    this.deleted_by,
    this.deleted_at,
    this.createdAt,
    this.updatedAt,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        json["id"],
        json["uniqId"],
        json["name"],
        json["mobile"],
        json["entreprise_id"],
        json["photo"],
        json["email"],
        json["email_verified_at"],
        json["pays"],
        json["ville"],
        json["deleted_by"],
        json["deleted_at"],
        DateTime.parse(json["created_at"]),
        DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uniqId": uniqId,
        "name": name,
        "mobile": mobile,
        "entreprise_id": entrepriseId,
        "photo": photo,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "pays": pays,
        "ville": ville,
        "deleted_by": deleted_by,
        "deleted_at": deleted_at,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}


// class UserModel {
//   int id;
//   int entrepriseId;
//   String name;
//   String mobile;
//   String email;
//   dynamic emailVerifiedAt;
//   String pays;
//   String ville;
//   String avatar;
//   dynamic path;
//   DateTime createdAt;
//   dynamic createdBy;
//   dynamic deletedAt;
//   dynamic deletedBy;
//   DateTime updatedAt;

//   UserModel(
//     this.id,
//     this.entrepriseId,
//     this.name,
//     this.mobile,
//     this.email,
//     this.emailVerifiedAt,
//     this.pays,
//     this.ville,
//     this.avatar,
//     this.path,
//     this.createdAt,
//     this.createdBy,
//     this.deletedAt,
//     this.deletedBy,
//     this.updatedAt,
//   );

//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         json["id"],
//         json["entreprise_id"],
//         json["name"],
//         json["mobile"],
//         json["email"],
//         json["email_verified_at"],
//         json["pays"],
//         json["ville"],
//         json["avatar"],
//         json["path"],
//         DateTime.parse(json["created_at"]),
//         json["created_by"],
//         json["deleted_at"],
//         json["deleted_by"],
//         DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "entreprise_id": entrepriseId,
//         "name": name,
//         "mobile": mobile,
//         "email": email,
//         "email_verified_at": emailVerifiedAt,
//         "pays": pays,
//         "ville": ville,
//         "avatar": avatar,
//         "path": path,
//         "created_at": createdAt.toIso8601String(),
//         "created_by": createdBy,
//         "deleted_at": deletedAt,
//         "deleted_by": deletedBy,
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }
