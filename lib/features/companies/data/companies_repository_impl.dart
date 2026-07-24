import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nexus_ai_crm/core/error/failures.dart';
import 'package:nexus_ai_crm/features/companies/data/companies_repository.dart';
import 'package:nexus_ai_crm/features/companies/domain/models/company_model.dart';

class CompaniesRepositoryImpl implements CompaniesRepository {
  final Dio _dio;

  const CompaniesRepositoryImpl(this._dio);

  @override
  Future<Either<Failure, List<CompanyModel>>> getCompanies({
    int page = 1,
    int limit = 20,
    String? searchQuery,
    String? filterIndustry,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (searchQuery != null && searchQuery.isNotEmpty) 'q': searchQuery,
        if (filterIndustry != null && filterIndustry.isNotEmpty)
          'industry': filterIndustry,
      };

      final response =
          await _dio.get('/companies', queryParameters: queryParams);

      final List<dynamic> data = response.data['data'] ?? response.data;
      final companies = data
          .map((json) => CompanyModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(companies);
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to fetch companies'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CompanyModel>> getCompanyById(String id) async {
    try {
      final response = await _dio.get('/companies/$id');
      final company =
          CompanyModel.fromJson(response.data as Map<String, dynamic>);
      return Right(company);
    } on DioException catch (e) {
      return Left(
          ServerFailure(message: e.message ?? 'Failed to fetch company details'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CompanyModel>> createCompany(
      CompanyModel company) async {
    try {
      final response =
          await _dio.post('/companies', data: company.toJson());
      final createdCompany =
          CompanyModel.fromJson(response.data as Map<String, dynamic>);
      return Right(createdCompany);
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to create company'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CompanyModel>> updateCompany(
      CompanyModel company) async {
    try {
      final response =
          await _dio.put('/companies/${company.id}', data: company.toJson());
      final updatedCompany =
          CompanyModel.fromJson(response.data as Map<String, dynamic>);
      return Right(updatedCompany);
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to update company'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCompany(String id) async {
    try {
      await _dio.delete('/companies/$id');
      return const Right(unit);
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to delete company'));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}