import 'package:laundry/utils/enums.dart';

class ApiResponse {
  final ApiExceptions exceptions;
  final String? message;

  ApiResponse({required this.exceptions, this.message});
}
