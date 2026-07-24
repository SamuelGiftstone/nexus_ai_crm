// lib/features/contacts/domain/contact_filter.dart

class ContactFilter {
  final String searchQuery;
  final String? status;
  final double? minDealValue;
  final double? maxDealValue;
  final String sortBy; // 'name', 'createdAt', 'dealValue'
  final bool ascending;

  const ContactFilter({
    this.searchQuery = '',
    this.status,
    this.minDealValue,
    this.maxDealValue,
    this.sortBy = 'createdAt',
    this.ascending = false,
  });

  ContactFilter copyWith({
    String? searchQuery,
    String? status,
    double? minDealValue,
    double? maxDealValue,
    String? sortBy,
    bool? ascending,
  }) {
    return ContactFilter(
      searchQuery: searchQuery ?? this.searchQuery,
      status: status ?? this.status,
      minDealValue: minDealValue ?? this.minDealValue,
      maxDealValue: maxDealValue ?? this.maxDealValue,
      sortBy: sortBy ?? this.sortBy,
      ascending: ascending ?? this.ascending,
    );
  }
}