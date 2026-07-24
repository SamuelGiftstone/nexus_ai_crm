// lib/features/duplicates/domain/duplicate_cluster.dart

import '../../../../shared/models/customer_model.dart';

enum DuplicateMatchType {
  exactEmail,
  fuzzyNameAndCompany,
  matchingPhone,
}

class DuplicateCluster {
  final String id;
  final CustomerModel primaryContact;
  final List<CustomerModel> duplicateCandidates;
  final DuplicateMatchType matchType;
  final double confidenceScore; // 0.0 to 1.0

  const DuplicateCluster({
    required this.id,
    required this.primaryContact,
    required this.duplicateCandidates,
    required this.matchType,
    required this.confidenceScore,
  });

  String get matchTypeLabel {
    switch (matchType) {
      case DuplicateMatchType.exactEmail:
        return 'Exact Email Match';
      case DuplicateMatchType.fuzzyNameAndCompany:
        return 'Similar Name & Company';
      case DuplicateMatchType.matchingPhone:
        return 'Matching Phone Number';
    }
  }
}