import 'package:dartz/dartz.dart';
import 'package:rx_project/core/error/failures.dart';
import 'package:rx_project/features/contact/domain/repositories/contact_repository.dart';
import 'package:rx_project/features/contact/data/datasources/contact_data_source.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactDataSource dataSource;

  ContactRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, void>> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    // Add any business logic here before sending to data source
    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      return Left(ValidationFailure('All fields are required'));
    }

    if (!_isValidEmail(email)) {
      return Left(ValidationFailure('Please enter a valid email address'));
    }

    return await dataSource.sendMessage(
      name: name,
      email: email,
      message: message,
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
