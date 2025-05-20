
class UserModel {
  final int id;
  final int groupId;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? tokenActivate;
  final String status;
  final String? avatar;
  final String? company;
  final String? birthDate;
  final String? mobile;
  final String? gender;
  final String? address;
  final int? provId;
  final int? kabkotaId;
  final String? postcode;
  final String? twitter;
  final String? facebook;
  final String? instagram;
  final String? firebaseUID;
  final String? tokenDevice;
  final int? createdBy;
  final int isDeleted;
  final int isVerified;
  final int? vendorId;
  final String createdAt;
  final String updatedAt;
  final String? userType;
  final int? statusCode;
  final String? updateNote;
  final int? pdpApproval;
  final String? pdpText;
  final String? pdpApprovalDate;
  final int? pdpApprovalBy;
  final int? member;
  final String? sumberMendaftar;
  final int? agreedTerms;

  UserModel({
    required this.id,
    required this.groupId,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.tokenActivate,
    required this.status,
    this.avatar,
    this.company,
    this.birthDate,
    this.mobile,
    this.gender,
    this.address,
    this.provId,
    this.kabkotaId,
    this.postcode,
    this.twitter,
    this.facebook,
    this.instagram,
    this.firebaseUID,
    this.tokenDevice,
    this.createdBy,
    required this.isDeleted,
    required this.isVerified,
    this.vendorId,
    required this.createdAt,
    required this.updatedAt,
    this.userType,
    this.statusCode,
    this.updateNote,
    this.pdpApproval,
    this.pdpText,
    this.pdpApprovalDate,
    this.pdpApprovalBy,

    this.sumberMendaftar,
    this.agreedTerms,
    this.member,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      groupId: json['group_id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      emailVerifiedAt: json['email_verified_at'] as String?,
      tokenActivate: json['token_activate'] as String?,
      status: json['status'] as String,
      avatar: json['avatar'] as String?,
      company: json['company'] as String?,
      birthDate: json['birth_date'] as String?,
      mobile: json['mobile'] as String?,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      provId: json['prov_id'] as int?,
      kabkotaId: json['kabkota_id'] as int?,
      postcode: json['postcode'] as String?,
      twitter: json['twitter'] as String?,
      facebook: json['facebook'] as String?,
      instagram: json['instagram'] as String?,
      firebaseUID: json['firebaseUID'] as String?,
      tokenDevice: json['token_device'] as String?,
      createdBy: json['created_by'] as int?,
      isDeleted: json['is_deleted'] as int,
      isVerified: json['is_verified'] as int,
      vendorId: json['vendor_id'] as int?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      userType: json['user_type'] as String?,
      statusCode: json['status_code'] as int?,
      updateNote: json['update_note'] as String?,
      pdpApproval: json['pdp_approval'] as int?,
      pdpText: json['pdp_text'] as String?,
      pdpApprovalDate: json['pdp_approval_date'] as String?,
      pdpApprovalBy: json['pdp_approval_by'] as int?,
      member: json['member'] as int?,
      sumberMendaftar: json['sumber_mendaftar'] as String?,
      agreedTerms: json['agreed_terms'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'token_activate': tokenActivate,
      'status': status,
      'avatar': avatar,
      'company': company,
      'birth_date': birthDate,
      'mobile': mobile,
      'gender': gender,
      'address': address,
      'prov_id': provId,
      'kabkota_id': kabkotaId,
      'postcode': postcode,
      'twitter': twitter,
      'facebook': facebook,
      'instagram': instagram,
      'firebaseUID': firebaseUID,
      'token_device': tokenDevice,
      'created_by': createdBy,
      'is_deleted': isDeleted,
      'is_verified': isVerified,
      'vendor_id': vendorId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user_type': userType,
      'status_code': statusCode,
      'update_note': updateNote,
      'pdp_approval': pdpApproval,
      'pdp_text': pdpText,
      'pdp_approval_date': pdpApprovalDate,
      'pdp_approval_by': pdpApprovalBy,
      'member': member,
      'sumber_mendaftar': sumberMendaftar,
      'agreed_terms': agreedTerms,
    };
  }
}