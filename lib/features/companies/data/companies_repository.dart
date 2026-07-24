import 'package:fpdart/fpdart.dart'; // Or use standard try/catch if preferred
import 'package:nexus_ai_crm/core/error/failures.dart';
import 'package:nexus_ai_crm/features/companies/domain/models/company_model.dart';

abstract class CompaniesRepository {
  /// Fetches a paginated list of companies with optional search & filter terms.
  Future<Either<Failure, List<CompanyModel>>> getCompanies({
    int page = 1,
    int limit = 20,
    String? searchQuery,
    String? filterIndustry,
  });

  /// Fetches a single company by its unique identifier.
  Future<Either<Failure, CompanyModel>> getCompanyById(String id);

  /// Creates a new company record.
  Future<Either<Failure, CompanyModel>> createCompany(CompanyModel company);

  /// Updates an existing company record.
  Future<Either<Failure, CompanyModel>> updateCompany(CompanyModel company);

  /// Deletes a company by ID.
  Future<Either<Failure, Unit>> deleteCompany(String id);
}