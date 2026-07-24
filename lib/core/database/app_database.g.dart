// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _companyMeta =
      const VerificationMeta('company');
  @override
  late final GeneratedColumn<String> company = GeneratedColumn<String>(
      'company', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
      'position', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _websiteMeta =
      const VerificationMeta('website');
  @override
  late final GeneratedColumn<String> website = GeneratedColumn<String>(
      'website', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _avatarUrlMeta =
      const VerificationMeta('avatarUrl');
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
      'avatar_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dealValueMeta =
      const VerificationMeta('dealValue');
  @override
  late final GeneratedColumn<double> dealValue = GeneratedColumn<double>(
      'deal_value', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Lead'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        firstName,
        lastName,
        company,
        position,
        email,
        phone,
        website,
        avatarUrl,
        dealValue,
        status,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(Insertable<Customer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('company')) {
      context.handle(_companyMeta,
          company.isAcceptableOrUnknown(data['company']!, _companyMeta));
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('website')) {
      context.handle(_websiteMeta,
          website.isAcceptableOrUnknown(data['website']!, _websiteMeta));
    }
    if (data.containsKey('avatar_url')) {
      context.handle(_avatarUrlMeta,
          avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta));
    }
    if (data.containsKey('deal_value')) {
      context.handle(_dealValueMeta,
          dealValue.isAcceptableOrUnknown(data['deal_value']!, _dealValueMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      company: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company']),
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}position']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      website: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}website']),
      avatarUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_url']),
      dealValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}deal_value'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
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
  final String status;
  final DateTime createdAt;
  const Customer(
      {required this.id,
      required this.firstName,
      required this.lastName,
      this.company,
      this.position,
      this.email,
      this.phone,
      this.website,
      this.avatarUrl,
      required this.dealValue,
      required this.status,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    if (!nullToAbsent || company != null) {
      map['company'] = Variable<String>(company);
    }
    if (!nullToAbsent || position != null) {
      map['position'] = Variable<String>(position);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || website != null) {
      map['website'] = Variable<String>(website);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    map['deal_value'] = Variable<double>(dealValue);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      company: company == null && nullToAbsent
          ? const Value.absent()
          : Value(company),
      position: position == null && nullToAbsent
          ? const Value.absent()
          : Value(position),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      website: website == null && nullToAbsent
          ? const Value.absent()
          : Value(website),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      dealValue: Value(dealValue),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory Customer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<String>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      company: serializer.fromJson<String?>(json['company']),
      position: serializer.fromJson<String?>(json['position']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      website: serializer.fromJson<String?>(json['website']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      dealValue: serializer.fromJson<double>(json['dealValue']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'company': serializer.toJson<String?>(company),
      'position': serializer.toJson<String?>(position),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'website': serializer.toJson<String?>(website),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'dealValue': serializer.toJson<double>(dealValue),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Customer copyWith(
          {String? id,
          String? firstName,
          String? lastName,
          Value<String?> company = const Value.absent(),
          Value<String?> position = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> website = const Value.absent(),
          Value<String?> avatarUrl = const Value.absent(),
          double? dealValue,
          String? status,
          DateTime? createdAt}) =>
      Customer(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        company: company.present ? company.value : this.company,
        position: position.present ? position.value : this.position,
        email: email.present ? email.value : this.email,
        phone: phone.present ? phone.value : this.phone,
        website: website.present ? website.value : this.website,
        avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
        dealValue: dealValue ?? this.dealValue,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      company: data.company.present ? data.company.value : this.company,
      position: data.position.present ? data.position.value : this.position,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      website: data.website.present ? data.website.value : this.website,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      dealValue: data.dealValue.present ? data.dealValue.value : this.dealValue,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('company: $company, ')
          ..write('position: $position, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('website: $website, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('dealValue: $dealValue, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, firstName, lastName, company, position,
      email, phone, website, avatarUrl, dealValue, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.company == this.company &&
          other.position == this.position &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.website == this.website &&
          other.avatarUrl == this.avatarUrl &&
          other.dealValue == this.dealValue &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<String> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String?> company;
  final Value<String?> position;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> website;
  final Value<String?> avatarUrl;
  final Value<double> dealValue;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.company = const Value.absent(),
    this.position = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.website = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.dealValue = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomersCompanion.insert({
    required String id,
    required String firstName,
    required String lastName,
    this.company = const Value.absent(),
    this.position = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.website = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.dealValue = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        firstName = Value(firstName),
        lastName = Value(lastName);
  static Insertable<Customer> custom({
    Expression<String>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? company,
    Expression<String>? position,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? website,
    Expression<String>? avatarUrl,
    Expression<double>? dealValue,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (company != null) 'company': company,
      if (position != null) 'position': position,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (website != null) 'website': website,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (dealValue != null) 'deal_value': dealValue,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomersCompanion copyWith(
      {Value<String>? id,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<String?>? company,
      Value<String?>? position,
      Value<String?>? email,
      Value<String?>? phone,
      Value<String?>? website,
      Value<String?>? avatarUrl,
      Value<double>? dealValue,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return CustomersCompanion(
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
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (company.present) {
      map['company'] = Variable<String>(company.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (website.present) {
      map['website'] = Variable<String>(website.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (dealValue.present) {
      map['deal_value'] = Variable<double>(dealValue.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('company: $company, ')
          ..write('position: $position, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('website: $website, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('dealValue: $dealValue, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InteractionsTable extends Interactions
    with TableInfo<$InteractionsTable, Interaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InteractionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
      'customer_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customers (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, customerId, type, notes, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'interactions';
  @override
  VerificationContext validateIntegrity(Insertable<Interaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Interaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Interaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $InteractionsTable createAlias(String alias) {
    return $InteractionsTable(attachedDatabase, alias);
  }
}

class Interaction extends DataClass implements Insertable<Interaction> {
  final int id;
  final String customerId;
  final String type;
  final String notes;
  final DateTime timestamp;
  const Interaction(
      {required this.id,
      required this.customerId,
      required this.type,
      required this.notes,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<String>(customerId);
    map['type'] = Variable<String>(type);
    map['notes'] = Variable<String>(notes);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  InteractionsCompanion toCompanion(bool nullToAbsent) {
    return InteractionsCompanion(
      id: Value(id),
      customerId: Value(customerId),
      type: Value(type),
      notes: Value(notes),
      timestamp: Value(timestamp),
    );
  }

  factory Interaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Interaction(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<String>(json['customerId']),
      type: serializer.fromJson<String>(json['type']),
      notes: serializer.fromJson<String>(json['notes']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<String>(customerId),
      'type': serializer.toJson<String>(type),
      'notes': serializer.toJson<String>(notes),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  Interaction copyWith(
          {int? id,
          String? customerId,
          String? type,
          String? notes,
          DateTime? timestamp}) =>
      Interaction(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        type: type ?? this.type,
        notes: notes ?? this.notes,
        timestamp: timestamp ?? this.timestamp,
      );
  Interaction copyWithCompanion(InteractionsCompanion data) {
    return Interaction(
      id: data.id.present ? data.id.value : this.id,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      type: data.type.present ? data.type.value : this.type,
      notes: data.notes.present ? data.notes.value : this.notes,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Interaction(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('type: $type, ')
          ..write('notes: $notes, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, customerId, type, notes, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Interaction &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.type == this.type &&
          other.notes == this.notes &&
          other.timestamp == this.timestamp);
}

class InteractionsCompanion extends UpdateCompanion<Interaction> {
  final Value<int> id;
  final Value<String> customerId;
  final Value<String> type;
  final Value<String> notes;
  final Value<DateTime> timestamp;
  const InteractionsCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.type = const Value.absent(),
    this.notes = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  InteractionsCompanion.insert({
    this.id = const Value.absent(),
    required String customerId,
    required String type,
    required String notes,
    this.timestamp = const Value.absent(),
  })  : customerId = Value(customerId),
        type = Value(type),
        notes = Value(notes);
  static Insertable<Interaction> custom({
    Expression<int>? id,
    Expression<String>? customerId,
    Expression<String>? type,
    Expression<String>? notes,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (type != null) 'type': type,
      if (notes != null) 'notes': notes,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  InteractionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? customerId,
      Value<String>? type,
      Value<String>? notes,
      Value<DateTime>? timestamp}) {
    return InteractionsCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      type: type ?? this.type,
      notes: notes ?? this.notes,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InteractionsCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('type: $type, ')
          ..write('notes: $notes, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

class $QuotationsTable extends Quotations
    with TableInfo<$QuotationsTable, Quotation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuotationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
      'customer_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customers (id)'));
  static const VerificationMeta _totalAmountMeta =
      const VerificationMeta('totalAmount');
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
      'total_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Draft'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, customerId, totalAmount, status, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quotations';
  @override
  VerificationContext validateIntegrity(Insertable<Quotation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
          _totalAmountMeta,
          totalAmount.isAcceptableOrUnknown(
              data['total_amount']!, _totalAmountMeta));
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Quotation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Quotation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_id'])!,
      totalAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_amount'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $QuotationsTable createAlias(String alias) {
    return $QuotationsTable(attachedDatabase, alias);
  }
}

class Quotation extends DataClass implements Insertable<Quotation> {
  final String id;
  final String customerId;
  final double totalAmount;
  final String status;
  final DateTime createdAt;
  const Quotation(
      {required this.id,
      required this.customerId,
      required this.totalAmount,
      required this.status,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['customer_id'] = Variable<String>(customerId);
    map['total_amount'] = Variable<double>(totalAmount);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  QuotationsCompanion toCompanion(bool nullToAbsent) {
    return QuotationsCompanion(
      id: Value(id),
      customerId: Value(customerId),
      totalAmount: Value(totalAmount),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory Quotation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Quotation(
      id: serializer.fromJson<String>(json['id']),
      customerId: serializer.fromJson<String>(json['customerId']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'customerId': serializer.toJson<String>(customerId),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Quotation copyWith(
          {String? id,
          String? customerId,
          double? totalAmount,
          String? status,
          DateTime? createdAt}) =>
      Quotation(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        totalAmount: totalAmount ?? this.totalAmount,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  Quotation copyWithCompanion(QuotationsCompanion data) {
    return Quotation(
      id: data.id.present ? data.id.value : this.id,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      totalAmount:
          data.totalAmount.present ? data.totalAmount.value : this.totalAmount,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Quotation(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, customerId, totalAmount, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Quotation &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.totalAmount == this.totalAmount &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class QuotationsCompanion extends UpdateCompanion<Quotation> {
  final Value<String> id;
  final Value<String> customerId;
  final Value<double> totalAmount;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const QuotationsCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuotationsCompanion.insert({
    required String id,
    required String customerId,
    required double totalAmount,
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        customerId = Value(customerId),
        totalAmount = Value(totalAmount);
  static Insertable<Quotation> custom({
    Expression<String>? id,
    Expression<String>? customerId,
    Expression<double>? totalAmount,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuotationsCompanion copyWith(
      {Value<String>? id,
      Value<String>? customerId,
      Value<double>? totalAmount,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return QuotationsCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuotationsCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FollowupsTable extends Followups
    with TableInfo<$FollowupsTable, Followup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FollowupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
      'customer_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, customerId, title, dueDate, isCompleted, completedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'followups';
  @override
  VerificationContext validateIntegrity(Insertable<Followup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Followup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Followup(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
    );
  }

  @override
  $FollowupsTable createAlias(String alias) {
    return $FollowupsTable(attachedDatabase, alias);
  }
}

class Followup extends DataClass implements Insertable<Followup> {
  final int id;
  final String customerId;
  final String title;
  final DateTime dueDate;
  final bool isCompleted;
  final DateTime? completedAt;
  const Followup(
      {required this.id,
      required this.customerId,
      required this.title,
      required this.dueDate,
      required this.isCompleted,
      this.completedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<String>(customerId);
    map['title'] = Variable<String>(title);
    map['due_date'] = Variable<DateTime>(dueDate);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  FollowupsCompanion toCompanion(bool nullToAbsent) {
    return FollowupsCompanion(
      id: Value(id),
      customerId: Value(customerId),
      title: Value(title),
      dueDate: Value(dueDate),
      isCompleted: Value(isCompleted),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory Followup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Followup(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<String>(json['customerId']),
      title: serializer.fromJson<String>(json['title']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<String>(customerId),
      'title': serializer.toJson<String>(title),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  Followup copyWith(
          {int? id,
          String? customerId,
          String? title,
          DateTime? dueDate,
          bool? isCompleted,
          Value<DateTime?> completedAt = const Value.absent()}) =>
      Followup(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        title: title ?? this.title,
        dueDate: dueDate ?? this.dueDate,
        isCompleted: isCompleted ?? this.isCompleted,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
      );
  Followup copyWithCompanion(FollowupsCompanion data) {
    return Followup(
      id: data.id.present ? data.id.value : this.id,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      title: data.title.present ? data.title.value : this.title,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Followup(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('title: $title, ')
          ..write('dueDate: $dueDate, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, customerId, title, dueDate, isCompleted, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Followup &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.title == this.title &&
          other.dueDate == this.dueDate &&
          other.isCompleted == this.isCompleted &&
          other.completedAt == this.completedAt);
}

class FollowupsCompanion extends UpdateCompanion<Followup> {
  final Value<int> id;
  final Value<String> customerId;
  final Value<String> title;
  final Value<DateTime> dueDate;
  final Value<bool> isCompleted;
  final Value<DateTime?> completedAt;
  const FollowupsCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.title = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  FollowupsCompanion.insert({
    this.id = const Value.absent(),
    required String customerId,
    required String title,
    required DateTime dueDate,
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
  })  : customerId = Value(customerId),
        title = Value(title),
        dueDate = Value(dueDate);
  static Insertable<Followup> custom({
    Expression<int>? id,
    Expression<String>? customerId,
    Expression<String>? title,
    Expression<DateTime>? dueDate,
    Expression<bool>? isCompleted,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (title != null) 'title': title,
      if (dueDate != null) 'due_date': dueDate,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  FollowupsCompanion copyWith(
      {Value<int>? id,
      Value<String>? customerId,
      Value<String>? title,
      Value<DateTime>? dueDate,
      Value<bool>? isCompleted,
      Value<DateTime?>? completedAt}) {
    return FollowupsCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FollowupsCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('title: $title, ')
          ..write('dueDate: $dueDate, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

class $AiHistoryTable extends AiHistory
    with TableInfo<$AiHistoryTable, AiHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
      'customer_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customers (id)'));
  static const VerificationMeta _promptMeta = const VerificationMeta('prompt');
  @override
  late final GeneratedColumn<String> prompt = GeneratedColumn<String>(
      'prompt', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _responseMeta =
      const VerificationMeta('response');
  @override
  late final GeneratedColumn<String> response = GeneratedColumn<String>(
      'response', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _actionTypeMeta =
      const VerificationMeta('actionType');
  @override
  late final GeneratedColumn<String> actionType = GeneratedColumn<String>(
      'action_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, customerId, prompt, response, actionType, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_history';
  @override
  VerificationContext validateIntegrity(Insertable<AiHistoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    }
    if (data.containsKey('prompt')) {
      context.handle(_promptMeta,
          prompt.isAcceptableOrUnknown(data['prompt']!, _promptMeta));
    } else if (isInserting) {
      context.missing(_promptMeta);
    }
    if (data.containsKey('response')) {
      context.handle(_responseMeta,
          response.isAcceptableOrUnknown(data['response']!, _responseMeta));
    } else if (isInserting) {
      context.missing(_responseMeta);
    }
    if (data.containsKey('action_type')) {
      context.handle(
          _actionTypeMeta,
          actionType.isAcceptableOrUnknown(
              data['action_type']!, _actionTypeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiHistoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_id']),
      prompt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}prompt'])!,
      response: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}response'])!,
      actionType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action_type']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AiHistoryTable createAlias(String alias) {
    return $AiHistoryTable(attachedDatabase, alias);
  }
}

class AiHistoryData extends DataClass implements Insertable<AiHistoryData> {
  final int id;
  final String? customerId;
  final String prompt;
  final String response;
  final String? actionType;
  final DateTime createdAt;
  const AiHistoryData(
      {required this.id,
      this.customerId,
      required this.prompt,
      required this.response,
      this.actionType,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<String>(customerId);
    }
    map['prompt'] = Variable<String>(prompt);
    map['response'] = Variable<String>(response);
    if (!nullToAbsent || actionType != null) {
      map['action_type'] = Variable<String>(actionType);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AiHistoryCompanion toCompanion(bool nullToAbsent) {
    return AiHistoryCompanion(
      id: Value(id),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      prompt: Value(prompt),
      response: Value(response),
      actionType: actionType == null && nullToAbsent
          ? const Value.absent()
          : Value(actionType),
      createdAt: Value(createdAt),
    );
  }

  factory AiHistoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiHistoryData(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<String?>(json['customerId']),
      prompt: serializer.fromJson<String>(json['prompt']),
      response: serializer.fromJson<String>(json['response']),
      actionType: serializer.fromJson<String?>(json['actionType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<String?>(customerId),
      'prompt': serializer.toJson<String>(prompt),
      'response': serializer.toJson<String>(response),
      'actionType': serializer.toJson<String?>(actionType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AiHistoryData copyWith(
          {int? id,
          Value<String?> customerId = const Value.absent(),
          String? prompt,
          String? response,
          Value<String?> actionType = const Value.absent(),
          DateTime? createdAt}) =>
      AiHistoryData(
        id: id ?? this.id,
        customerId: customerId.present ? customerId.value : this.customerId,
        prompt: prompt ?? this.prompt,
        response: response ?? this.response,
        actionType: actionType.present ? actionType.value : this.actionType,
        createdAt: createdAt ?? this.createdAt,
      );
  AiHistoryData copyWithCompanion(AiHistoryCompanion data) {
    return AiHistoryData(
      id: data.id.present ? data.id.value : this.id,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      prompt: data.prompt.present ? data.prompt.value : this.prompt,
      response: data.response.present ? data.response.value : this.response,
      actionType:
          data.actionType.present ? data.actionType.value : this.actionType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiHistoryData(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('prompt: $prompt, ')
          ..write('response: $response, ')
          ..write('actionType: $actionType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, customerId, prompt, response, actionType, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiHistoryData &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.prompt == this.prompt &&
          other.response == this.response &&
          other.actionType == this.actionType &&
          other.createdAt == this.createdAt);
}

class AiHistoryCompanion extends UpdateCompanion<AiHistoryData> {
  final Value<int> id;
  final Value<String?> customerId;
  final Value<String> prompt;
  final Value<String> response;
  final Value<String?> actionType;
  final Value<DateTime> createdAt;
  const AiHistoryCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.prompt = const Value.absent(),
    this.response = const Value.absent(),
    this.actionType = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AiHistoryCompanion.insert({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    required String prompt,
    required String response,
    this.actionType = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : prompt = Value(prompt),
        response = Value(response);
  static Insertable<AiHistoryData> custom({
    Expression<int>? id,
    Expression<String>? customerId,
    Expression<String>? prompt,
    Expression<String>? response,
    Expression<String>? actionType,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (prompt != null) 'prompt': prompt,
      if (response != null) 'response': response,
      if (actionType != null) 'action_type': actionType,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AiHistoryCompanion copyWith(
      {Value<int>? id,
      Value<String?>? customerId,
      Value<String>? prompt,
      Value<String>? response,
      Value<String?>? actionType,
      Value<DateTime>? createdAt}) {
    return AiHistoryCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      prompt: prompt ?? this.prompt,
      response: response ?? this.response,
      actionType: actionType ?? this.actionType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (prompt.present) {
      map['prompt'] = Variable<String>(prompt.value);
    }
    if (response.present) {
      map['response'] = Variable<String>(response.value);
    }
    if (actionType.present) {
      map['action_type'] = Variable<String>(actionType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiHistoryCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('prompt: $prompt, ')
          ..write('response: $response, ')
          ..write('actionType: $actionType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $InteractionsTable interactions = $InteractionsTable(this);
  late final $QuotationsTable quotations = $QuotationsTable(this);
  late final $FollowupsTable followups = $FollowupsTable(this);
  late final $AiHistoryTable aiHistory = $AiHistoryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [customers, interactions, quotations, followups, aiHistory];
}

typedef $$CustomersTableCreateCompanionBuilder = CustomersCompanion Function({
  required String id,
  required String firstName,
  required String lastName,
  Value<String?> company,
  Value<String?> position,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> website,
  Value<String?> avatarUrl,
  Value<double> dealValue,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$CustomersTableUpdateCompanionBuilder = CustomersCompanion Function({
  Value<String> id,
  Value<String> firstName,
  Value<String> lastName,
  Value<String?> company,
  Value<String?> position,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> website,
  Value<String?> avatarUrl,
  Value<double> dealValue,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$CustomersTableReferences
    extends BaseReferences<_$AppDatabase, $CustomersTable, Customer> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InteractionsTable, List<Interaction>>
      _interactionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.interactions,
              aliasName: $_aliasNameGenerator(
                  db.customers.id, db.interactions.customerId));

  $$InteractionsTableProcessedTableManager get interactionsRefs {
    final manager = $$InteractionsTableTableManager($_db, $_db.interactions)
        .filter((f) => f.customerId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_interactionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$QuotationsTable, List<Quotation>>
      _quotationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.quotations,
          aliasName:
              $_aliasNameGenerator(db.customers.id, db.quotations.customerId));

  $$QuotationsTableProcessedTableManager get quotationsRefs {
    final manager = $$QuotationsTableTableManager($_db, $_db.quotations)
        .filter((f) => f.customerId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_quotationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AiHistoryTable, List<AiHistoryData>>
      _aiHistoryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.aiHistory,
          aliasName:
              $_aliasNameGenerator(db.customers.id, db.aiHistory.customerId));

  $$AiHistoryTableProcessedTableManager get aiHistoryRefs {
    final manager = $$AiHistoryTableTableManager($_db, $_db.aiHistory)
        .filter((f) => f.customerId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_aiHistoryRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get company => $composableBuilder(
      column: $table.company, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get website => $composableBuilder(
      column: $table.website, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatarUrl => $composableBuilder(
      column: $table.avatarUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get dealValue => $composableBuilder(
      column: $table.dealValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> interactionsRefs(
      Expression<bool> Function($$InteractionsTableFilterComposer f) f) {
    final $$InteractionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.interactions,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InteractionsTableFilterComposer(
              $db: $db,
              $table: $db.interactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> quotationsRefs(
      Expression<bool> Function($$QuotationsTableFilterComposer f) f) {
    final $$QuotationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.quotations,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuotationsTableFilterComposer(
              $db: $db,
              $table: $db.quotations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> aiHistoryRefs(
      Expression<bool> Function($$AiHistoryTableFilterComposer f) f) {
    final $$AiHistoryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aiHistory,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AiHistoryTableFilterComposer(
              $db: $db,
              $table: $db.aiHistory,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get company => $composableBuilder(
      column: $table.company, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get website => $composableBuilder(
      column: $table.website, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
      column: $table.avatarUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get dealValue => $composableBuilder(
      column: $table.dealValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get company =>
      $composableBuilder(column: $table.company, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get website =>
      $composableBuilder(column: $table.website, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<double> get dealValue =>
      $composableBuilder(column: $table.dealValue, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> interactionsRefs<T extends Object>(
      Expression<T> Function($$InteractionsTableAnnotationComposer a) f) {
    final $$InteractionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.interactions,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InteractionsTableAnnotationComposer(
              $db: $db,
              $table: $db.interactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> quotationsRefs<T extends Object>(
      Expression<T> Function($$QuotationsTableAnnotationComposer a) f) {
    final $$QuotationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.quotations,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuotationsTableAnnotationComposer(
              $db: $db,
              $table: $db.quotations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> aiHistoryRefs<T extends Object>(
      Expression<T> Function($$AiHistoryTableAnnotationComposer a) f) {
    final $$AiHistoryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.aiHistory,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AiHistoryTableAnnotationComposer(
              $db: $db,
              $table: $db.aiHistory,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CustomersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CustomersTable,
    Customer,
    $$CustomersTableFilterComposer,
    $$CustomersTableOrderingComposer,
    $$CustomersTableAnnotationComposer,
    $$CustomersTableCreateCompanionBuilder,
    $$CustomersTableUpdateCompanionBuilder,
    (Customer, $$CustomersTableReferences),
    Customer,
    PrefetchHooks Function(
        {bool interactionsRefs, bool quotationsRefs, bool aiHistoryRefs})> {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> firstName = const Value.absent(),
            Value<String> lastName = const Value.absent(),
            Value<String?> company = const Value.absent(),
            Value<String?> position = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> website = const Value.absent(),
            Value<String?> avatarUrl = const Value.absent(),
            Value<double> dealValue = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CustomersCompanion(
            id: id,
            firstName: firstName,
            lastName: lastName,
            company: company,
            position: position,
            email: email,
            phone: phone,
            website: website,
            avatarUrl: avatarUrl,
            dealValue: dealValue,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String firstName,
            required String lastName,
            Value<String?> company = const Value.absent(),
            Value<String?> position = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> website = const Value.absent(),
            Value<String?> avatarUrl = const Value.absent(),
            Value<double> dealValue = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CustomersCompanion.insert(
            id: id,
            firstName: firstName,
            lastName: lastName,
            company: company,
            position: position,
            email: email,
            phone: phone,
            website: website,
            avatarUrl: avatarUrl,
            dealValue: dealValue,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CustomersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {interactionsRefs = false,
              quotationsRefs = false,
              aiHistoryRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (interactionsRefs) db.interactions,
                if (quotationsRefs) db.quotations,
                if (aiHistoryRefs) db.aiHistory
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (interactionsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CustomersTableReferences
                            ._interactionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CustomersTableReferences(db, table, p0)
                                .interactionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.customerId == item.id),
                        typedResults: items),
                  if (quotationsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$CustomersTableReferences._quotationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CustomersTableReferences(db, table, p0)
                                .quotationsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.customerId == item.id),
                        typedResults: items),
                  if (aiHistoryRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$CustomersTableReferences._aiHistoryRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CustomersTableReferences(db, table, p0)
                                .aiHistoryRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.customerId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CustomersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CustomersTable,
    Customer,
    $$CustomersTableFilterComposer,
    $$CustomersTableOrderingComposer,
    $$CustomersTableAnnotationComposer,
    $$CustomersTableCreateCompanionBuilder,
    $$CustomersTableUpdateCompanionBuilder,
    (Customer, $$CustomersTableReferences),
    Customer,
    PrefetchHooks Function(
        {bool interactionsRefs, bool quotationsRefs, bool aiHistoryRefs})>;
typedef $$InteractionsTableCreateCompanionBuilder = InteractionsCompanion
    Function({
  Value<int> id,
  required String customerId,
  required String type,
  required String notes,
  Value<DateTime> timestamp,
});
typedef $$InteractionsTableUpdateCompanionBuilder = InteractionsCompanion
    Function({
  Value<int> id,
  Value<String> customerId,
  Value<String> type,
  Value<String> notes,
  Value<DateTime> timestamp,
});

final class $$InteractionsTableReferences
    extends BaseReferences<_$AppDatabase, $InteractionsTable, Interaction> {
  $$InteractionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
          $_aliasNameGenerator(db.interactions.customerId, db.customers.id));

  $$CustomersTableProcessedTableManager? get customerId {
    if ($_item.customerId == null) return null;
    final manager = $$CustomersTableTableManager($_db, $_db.customers)
        .filter((f) => f.id($_item.customerId!));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$InteractionsTableFilterComposer
    extends Composer<_$AppDatabase, $InteractionsTable> {
  $$InteractionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableFilterComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InteractionsTableOrderingComposer
    extends Composer<_$AppDatabase, $InteractionsTable> {
  $$InteractionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableOrderingComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InteractionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InteractionsTable> {
  $$InteractionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableAnnotationComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InteractionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InteractionsTable,
    Interaction,
    $$InteractionsTableFilterComposer,
    $$InteractionsTableOrderingComposer,
    $$InteractionsTableAnnotationComposer,
    $$InteractionsTableCreateCompanionBuilder,
    $$InteractionsTableUpdateCompanionBuilder,
    (Interaction, $$InteractionsTableReferences),
    Interaction,
    PrefetchHooks Function({bool customerId})> {
  $$InteractionsTableTableManager(_$AppDatabase db, $InteractionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InteractionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InteractionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InteractionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> customerId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
          }) =>
              InteractionsCompanion(
            id: id,
            customerId: customerId,
            type: type,
            notes: notes,
            timestamp: timestamp,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String customerId,
            required String type,
            required String notes,
            Value<DateTime> timestamp = const Value.absent(),
          }) =>
              InteractionsCompanion.insert(
            id: id,
            customerId: customerId,
            type: type,
            notes: notes,
            timestamp: timestamp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$InteractionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({customerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (customerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.customerId,
                    referencedTable:
                        $$InteractionsTableReferences._customerIdTable(db),
                    referencedColumn:
                        $$InteractionsTableReferences._customerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$InteractionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InteractionsTable,
    Interaction,
    $$InteractionsTableFilterComposer,
    $$InteractionsTableOrderingComposer,
    $$InteractionsTableAnnotationComposer,
    $$InteractionsTableCreateCompanionBuilder,
    $$InteractionsTableUpdateCompanionBuilder,
    (Interaction, $$InteractionsTableReferences),
    Interaction,
    PrefetchHooks Function({bool customerId})>;
typedef $$QuotationsTableCreateCompanionBuilder = QuotationsCompanion Function({
  required String id,
  required String customerId,
  required double totalAmount,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$QuotationsTableUpdateCompanionBuilder = QuotationsCompanion Function({
  Value<String> id,
  Value<String> customerId,
  Value<double> totalAmount,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$QuotationsTableReferences
    extends BaseReferences<_$AppDatabase, $QuotationsTable, Quotation> {
  $$QuotationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
          $_aliasNameGenerator(db.quotations.customerId, db.customers.id));

  $$CustomersTableProcessedTableManager? get customerId {
    if ($_item.customerId == null) return null;
    final manager = $$CustomersTableTableManager($_db, $_db.customers)
        .filter((f) => f.id($_item.customerId!));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$QuotationsTableFilterComposer
    extends Composer<_$AppDatabase, $QuotationsTable> {
  $$QuotationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableFilterComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuotationsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuotationsTable> {
  $$QuotationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableOrderingComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuotationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuotationsTable> {
  $$QuotationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableAnnotationComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuotationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuotationsTable,
    Quotation,
    $$QuotationsTableFilterComposer,
    $$QuotationsTableOrderingComposer,
    $$QuotationsTableAnnotationComposer,
    $$QuotationsTableCreateCompanionBuilder,
    $$QuotationsTableUpdateCompanionBuilder,
    (Quotation, $$QuotationsTableReferences),
    Quotation,
    PrefetchHooks Function({bool customerId})> {
  $$QuotationsTableTableManager(_$AppDatabase db, $QuotationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuotationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuotationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuotationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> customerId = const Value.absent(),
            Value<double> totalAmount = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuotationsCompanion(
            id: id,
            customerId: customerId,
            totalAmount: totalAmount,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String customerId,
            required double totalAmount,
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuotationsCompanion.insert(
            id: id,
            customerId: customerId,
            totalAmount: totalAmount,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$QuotationsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({customerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (customerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.customerId,
                    referencedTable:
                        $$QuotationsTableReferences._customerIdTable(db),
                    referencedColumn:
                        $$QuotationsTableReferences._customerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$QuotationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuotationsTable,
    Quotation,
    $$QuotationsTableFilterComposer,
    $$QuotationsTableOrderingComposer,
    $$QuotationsTableAnnotationComposer,
    $$QuotationsTableCreateCompanionBuilder,
    $$QuotationsTableUpdateCompanionBuilder,
    (Quotation, $$QuotationsTableReferences),
    Quotation,
    PrefetchHooks Function({bool customerId})>;
typedef $$FollowupsTableCreateCompanionBuilder = FollowupsCompanion Function({
  Value<int> id,
  required String customerId,
  required String title,
  required DateTime dueDate,
  Value<bool> isCompleted,
  Value<DateTime?> completedAt,
});
typedef $$FollowupsTableUpdateCompanionBuilder = FollowupsCompanion Function({
  Value<int> id,
  Value<String> customerId,
  Value<String> title,
  Value<DateTime> dueDate,
  Value<bool> isCompleted,
  Value<DateTime?> completedAt,
});

class $$FollowupsTableFilterComposer
    extends Composer<_$AppDatabase, $FollowupsTable> {
  $$FollowupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customerId => $composableBuilder(
      column: $table.customerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));
}

class $$FollowupsTableOrderingComposer
    extends Composer<_$AppDatabase, $FollowupsTable> {
  $$FollowupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customerId => $composableBuilder(
      column: $table.customerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));
}

class $$FollowupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FollowupsTable> {
  $$FollowupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get customerId => $composableBuilder(
      column: $table.customerId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);
}

class $$FollowupsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FollowupsTable,
    Followup,
    $$FollowupsTableFilterComposer,
    $$FollowupsTableOrderingComposer,
    $$FollowupsTableAnnotationComposer,
    $$FollowupsTableCreateCompanionBuilder,
    $$FollowupsTableUpdateCompanionBuilder,
    (Followup, BaseReferences<_$AppDatabase, $FollowupsTable, Followup>),
    Followup,
    PrefetchHooks Function()> {
  $$FollowupsTableTableManager(_$AppDatabase db, $FollowupsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FollowupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FollowupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FollowupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> customerId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<DateTime> dueDate = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
          }) =>
              FollowupsCompanion(
            id: id,
            customerId: customerId,
            title: title,
            dueDate: dueDate,
            isCompleted: isCompleted,
            completedAt: completedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String customerId,
            required String title,
            required DateTime dueDate,
            Value<bool> isCompleted = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
          }) =>
              FollowupsCompanion.insert(
            id: id,
            customerId: customerId,
            title: title,
            dueDate: dueDate,
            isCompleted: isCompleted,
            completedAt: completedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FollowupsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FollowupsTable,
    Followup,
    $$FollowupsTableFilterComposer,
    $$FollowupsTableOrderingComposer,
    $$FollowupsTableAnnotationComposer,
    $$FollowupsTableCreateCompanionBuilder,
    $$FollowupsTableUpdateCompanionBuilder,
    (Followup, BaseReferences<_$AppDatabase, $FollowupsTable, Followup>),
    Followup,
    PrefetchHooks Function()>;
typedef $$AiHistoryTableCreateCompanionBuilder = AiHistoryCompanion Function({
  Value<int> id,
  Value<String?> customerId,
  required String prompt,
  required String response,
  Value<String?> actionType,
  Value<DateTime> createdAt,
});
typedef $$AiHistoryTableUpdateCompanionBuilder = AiHistoryCompanion Function({
  Value<int> id,
  Value<String?> customerId,
  Value<String> prompt,
  Value<String> response,
  Value<String?> actionType,
  Value<DateTime> createdAt,
});

final class $$AiHistoryTableReferences
    extends BaseReferences<_$AppDatabase, $AiHistoryTable, AiHistoryData> {
  $$AiHistoryTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
          $_aliasNameGenerator(db.aiHistory.customerId, db.customers.id));

  $$CustomersTableProcessedTableManager? get customerId {
    if ($_item.customerId == null) return null;
    final manager = $$CustomersTableTableManager($_db, $_db.customers)
        .filter((f) => f.id($_item.customerId!));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AiHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $AiHistoryTable> {
  $$AiHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get prompt => $composableBuilder(
      column: $table.prompt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get response => $composableBuilder(
      column: $table.response, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get actionType => $composableBuilder(
      column: $table.actionType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableFilterComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AiHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $AiHistoryTable> {
  $$AiHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get prompt => $composableBuilder(
      column: $table.prompt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get response => $composableBuilder(
      column: $table.response, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get actionType => $composableBuilder(
      column: $table.actionType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableOrderingComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AiHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiHistoryTable> {
  $$AiHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get prompt =>
      $composableBuilder(column: $table.prompt, builder: (column) => column);

  GeneratedColumn<String> get response =>
      $composableBuilder(column: $table.response, builder: (column) => column);

  GeneratedColumn<String> get actionType => $composableBuilder(
      column: $table.actionType, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableAnnotationComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AiHistoryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AiHistoryTable,
    AiHistoryData,
    $$AiHistoryTableFilterComposer,
    $$AiHistoryTableOrderingComposer,
    $$AiHistoryTableAnnotationComposer,
    $$AiHistoryTableCreateCompanionBuilder,
    $$AiHistoryTableUpdateCompanionBuilder,
    (AiHistoryData, $$AiHistoryTableReferences),
    AiHistoryData,
    PrefetchHooks Function({bool customerId})> {
  $$AiHistoryTableTableManager(_$AppDatabase db, $AiHistoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> customerId = const Value.absent(),
            Value<String> prompt = const Value.absent(),
            Value<String> response = const Value.absent(),
            Value<String?> actionType = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              AiHistoryCompanion(
            id: id,
            customerId: customerId,
            prompt: prompt,
            response: response,
            actionType: actionType,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> customerId = const Value.absent(),
            required String prompt,
            required String response,
            Value<String?> actionType = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              AiHistoryCompanion.insert(
            id: id,
            customerId: customerId,
            prompt: prompt,
            response: response,
            actionType: actionType,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AiHistoryTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({customerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (customerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.customerId,
                    referencedTable:
                        $$AiHistoryTableReferences._customerIdTable(db),
                    referencedColumn:
                        $$AiHistoryTableReferences._customerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AiHistoryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AiHistoryTable,
    AiHistoryData,
    $$AiHistoryTableFilterComposer,
    $$AiHistoryTableOrderingComposer,
    $$AiHistoryTableAnnotationComposer,
    $$AiHistoryTableCreateCompanionBuilder,
    $$AiHistoryTableUpdateCompanionBuilder,
    (AiHistoryData, $$AiHistoryTableReferences),
    AiHistoryData,
    PrefetchHooks Function({bool customerId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$InteractionsTableTableManager get interactions =>
      $$InteractionsTableTableManager(_db, _db.interactions);
  $$QuotationsTableTableManager get quotations =>
      $$QuotationsTableTableManager(_db, _db.quotations);
  $$FollowupsTableTableManager get followups =>
      $$FollowupsTableTableManager(_db, _db.followups);
  $$AiHistoryTableTableManager get aiHistory =>
      $$AiHistoryTableTableManager(_db, _db.aiHistory);
}
