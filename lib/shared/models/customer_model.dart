// lib/shared/models/customer_model.dart

class CustomerModel {
  final String id;
  final String firstName;
  final String lastName;
  final String? company;
  final String? position;
  final String? email;
  final String? phone;
  final String? website;
  final String? avatarUrl;
  final double dealValue;
  final String status; // Lead, Qualified, Proposal, Won, Lost
  final DateTime? lastContactedAt;
  final DateTime createdAt;

  const CustomerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.company,
    this.position,
    this.email,
    this.phone,
    this.website,
    this.avatarUrl,
    this.dealValue = 0.0,
    this.status = 'Lead',
    this.lastContactedAt,
    required this.createdAt,
  });

  String get fullName => '$firstName $lastName'.trim();

  CustomerModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? company,
    String? position,
    String? email,
    String? phone,
    String? website,
    String? avatarUrl,
    double? dealValue,
    String? status,
    DateTime? lastContactedAt,
    DateTime? createdAt,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      company: company ?? this.company,
      position: position ?? this.position,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      dealValue: dealValue ?? this.dealValue,
      status: status ?? this.status,
      lastContactedAt: lastContactedAt ?? this.lastContactedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'company': company,
      'position': position,
      'email': email,
      'phone': phone,
      'website': website,
      'avatar_url': avatarUrl,
      'deal_value': dealValue,
      'status': status,
      'last_contacted_at': lastContactedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] as String,
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      company: json['company'] as String?,
      position: json['position'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      dealValue: (json['deal_value'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? 'Lead',
      lastContactedAt: json['last_contacted_at'] != null
          ? DateTime.tryParse(json['last_contacted_at'] as String)
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }
}