import 'package:dartz/dartz.dart';
import 'package:rx_project/core/error/failures.dart';
import 'package:rx_project/features/contact/domain/repositories/contact_repository.dart';

class SendMessageUseCase {
  final ContactRepository repository;

  SendMessageUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String name,
    required String email,
    required String message,
  }) async {
    return await repository.sendMessage(
      name: name,
      email: email,
      message: message,
    );
  }
}
