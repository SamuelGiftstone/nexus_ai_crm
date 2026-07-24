class CompanyModel {
  final String id;
  final String name;
  final String domain;
  final String industry;
  final int contactCount;
  final String status;
  final String revenue;
  final String? phone;
  final String? email;
  final String? address;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CompanyModel({
    required this.id,
    required this.name,
    required this.domain,
    required this.industry,
    required this.contactCount,
    required this.status,
    required this.revenue,
    this.phone,
    this.email,
    this.address,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  /// Factory constructor for building a CompanyModel from JSON / Database Map
  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      domain: json['domain'] as String? ?? '',
      industry: json['industry'] as String? ?? 'General',
      contactCount: (json['contactCount'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'Active',
      revenue: json['revenue'] as String? ?? '\$0',
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      description: json['description'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
    );
  }

  /// Converts CompanyModel instance to JSON Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'domain': domain,
      'industry': industry,
      'contactCount': contactCount,
      'status': status,
      'revenue': revenue,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (description != null) 'description': description,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  /// Immutability helper for state management updates
  CompanyModel copyWith({
    String? id,
    String? name,
    String? domain,
    String? industry,
    int? contactCount,
    String? status,
    String? revenue,
    String? phone,
    String? email,
    String? address,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      domain: domain ?? this.domain,
      industry: industry ?? this.industry,
      contactCount: contactCount ?? this.contactCount,
      status: status ?? this.status,
      revenue: revenue ?? this.revenue,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CompanyModel &&
        other.id == id &&
        other.name == name &&
        other.domain == domain &&
        other.industry == industry &&
        other.contactCount == contactCount &&
        other.status == status &&
        other.revenue == revenue &&
        other.phone == phone &&
        other.email == email &&
        other.address == address &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      domain,
      industry,
      contactCount,
      status,
      revenue,
      phone,
      email,
      address,
      description,
      createdAt,
      updatedAt,
    );
  }
}