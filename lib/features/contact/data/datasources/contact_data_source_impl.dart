import 'package:dartz/dartz.dart';
import 'package:rx_project/core/error/failures.dart';
import 'package:rx_project/features/contact/data/datasources/contact_data_source.dart';

class ContactDataSourceImpl implements ContactDataSource {
  @override
  Future<Either<Failure, void>> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    // TODO: Implement actual API call to send the message
    // This is a mock implementation
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Simulate success response
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to send message: $e'));
    }
  }
}
