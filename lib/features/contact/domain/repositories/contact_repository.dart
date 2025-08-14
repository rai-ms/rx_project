import 'package:dartz/dartz.dart';
import 'package:rx_project/core/error/failures.dart';

abstract class ContactRepository {
  Future<Either<Failure, void>> sendMessage({
    required String name,
    required String email,
    required String message,
  });
}
