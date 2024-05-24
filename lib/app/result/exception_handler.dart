import 'package:freezed_annotation/freezed_annotation.dart';

part 'exception_handler.freezed.dart';

/// Represents various exception types and their associated error messages.
@freezed
class ExceptionHandler with _$ExceptionHandler {
  const factory ExceptionHandler.jsonDecodingError({required Exception exception}) = JsonDecodingError;
  const factory ExceptionHandler.requestCancelled() = RequestCancelled;
  const factory ExceptionHandler.payloadEmpty({final String? className}) = PayloadEmpty;
  const factory ExceptionHandler.unauthorizedRequest(final String message) = UnauthorizedRequest;
  const factory ExceptionHandler.socketIoError(final String message) = SocketIoError;
  const factory ExceptionHandler.badRequest() = BadRequest;
  const factory ExceptionHandler.notFound(final String reason) = NotFound;
  const factory ExceptionHandler.methodNotAllowed() = MethodNotAllowed;
  const factory ExceptionHandler.notAcceptable() = NotAcceptable;
  const factory ExceptionHandler.requestTimeout() = RequestTimeout;
  const factory ExceptionHandler.sendTimeout() = SendTimeout;
  const factory ExceptionHandler.conflict() = Conflict;
  const factory ExceptionHandler.internalServerError() = InternalServerError;
  const factory ExceptionHandler.notImplemented() = NotImplemented;
  const factory ExceptionHandler.serviceUnavailable() = ServiceUnavailable;
  const factory ExceptionHandler.noInternetConnection() = NoInternetConnection;
  const factory ExceptionHandler.formatException() = FormatException;
  const factory ExceptionHandler.badGateway() = BadGateWay;
  const factory ExceptionHandler.gatewayTimeout() = GatewayTimeout;
  const factory ExceptionHandler.networkAuthRequired() = NetworkAuthRequired;
  const factory ExceptionHandler.forbidden() = Forbidden;
  const factory ExceptionHandler.unableToProcess() = UnableToProcess;
  const factory ExceptionHandler.defaultError(final String error) = DefaultError;
  const factory ExceptionHandler.unexpectedError() = UnexpectedError;
  const factory ExceptionHandler.wrongVerification() = WrongVerification;
  const factory ExceptionHandler.invalidEmail() = InvalidEmail;
  const factory ExceptionHandler.wrongPassword() = WrongPassword;
  const factory ExceptionHandler.userNotFound() = UserNotFound;
  const factory ExceptionHandler.userDisabled() = UserDisabled;
  const factory ExceptionHandler.tooManyRequests() = TooManyRequests;
  const factory ExceptionHandler.operationNotAllowed() = OperationNotAllowed;
  const factory ExceptionHandler.undefined() = Undefined;

  /// Retrieves the error message associated with the given [exceptionHandler].
  static String getErrorMessage(
      final ExceptionHandler exceptionHandler, {
        final bool showInLog = true,
        final dynamic stackTrace,
      }) {
     final errorMessages = {
      JsonDecodingError: (Exception e) => 'Failed to decode JSON data error: ${e.toString()}',
      NotImplemented: () => 'Not Implemented',
      RequestCancelled: () => 'Request Cancelled',
      InternalServerError: () => 'Internal Server Error',
      NotFound: (String reason) => reason,
      ServiceUnavailable: () => 'Service Unavailable',
      MethodNotAllowed: () => 'Method Not Allowed',
      BadRequest: () => 'Bad Request',
      UnauthorizedRequest: (String message) => message.isEmpty ? 'Unauthorized Request' : message,
      UnexpectedError: () => 'Unexpected Error Occurred',
      RequestTimeout: () => 'Connection Request Timeout',
      NoInternetConnection: () => 'No Internet Connection',
      Conflict: () => 'Error Due to a Conflict',
      SendTimeout: () => 'Send Timeout in Connection with API Server',
      UnableToProcess: () => 'Unable to Process the Data',
      DefaultError: (String error) => error,
      FormatException: () => 'Unexpected Error Occurred',
      NotAcceptable: () => 'Not Acceptable',
      SocketIoError: (String message) => 'Socket Connection Error: $message',
      NetworkAuthRequired: () => 'Unable to Process the Data',
      BadGateWay: () => 'Bad Gateway',
      Forbidden: () => 'Forbidden Access',
      GatewayTimeout: () => 'Gateway Timeout',
      OperationNotAllowed: () => 'Signing in with Number and Password is Not Enabled',
      WrongVerification: () => 'Wrong Code. Please Try Again',
      InvalidEmail: () => 'Your Email Address Appears to be Malformed',
      UserNotFound: () => 'Invalid Phone Number. Please Try Again',
      UserDisabled: () => 'User with this Number has Been Disabled',
      WrongPassword: () => 'Your Password is Wrong',
      TooManyRequests: () => 'Too Many Requests. Try Again Later',
      PayloadEmpty: (String? className) => 'The Payload is Empty: $className',
      Undefined: () => 'An Undefined Error Occurred',
    };

    var errorMessage = 'An Unknown Error Occurred';
     exceptionHandler.map(
       jsonDecodingError: (e) => errorMessage = errorMessages[JsonDecodingError]?.call(e.exception) ?? errorMessage,
       notImplemented: (_) => errorMessage = errorMessages[NotImplemented]?.call() ?? errorMessage,
       requestCancelled: (_) => errorMessage = errorMessages[RequestCancelled]?.call() ?? errorMessage,
       internalServerError: (_) => errorMessage = errorMessages[InternalServerError]?.call() ?? errorMessage,
       notFound: (e) => errorMessage = errorMessages[NotFound]?.call(e.reason) ?? errorMessage,
       serviceUnavailable: (_) => errorMessage = errorMessages[ServiceUnavailable]?.call() ?? errorMessage,
       methodNotAllowed: (_) => errorMessage = errorMessages[MethodNotAllowed]?.call() ?? errorMessage,
       badRequest: (_) => errorMessage = errorMessages[BadRequest]?.call() ?? errorMessage,
       unauthorizedRequest: (e) => errorMessage = errorMessages[UnauthorizedRequest]?.call(e.message) ?? errorMessage,
       unexpectedError: (_) => errorMessage = errorMessages[UnexpectedError]?.call() ?? errorMessage,
       requestTimeout: (_) => errorMessage = errorMessages[RequestTimeout]?.call() ?? errorMessage,
       noInternetConnection: (_) => errorMessage = errorMessages[NoInternetConnection]?.call() ?? errorMessage,
       conflict: (_) => errorMessage = errorMessages[Conflict]?.call() ?? errorMessage,
       sendTimeout: (_) => errorMessage = errorMessages[SendTimeout]?.call() ?? errorMessage,
       unableToProcess: (_) => errorMessage = errorMessages[UnableToProcess]?.call() ?? errorMessage,
       defaultError: (e) => errorMessage = errorMessages[DefaultError]?.call(e.error) ?? errorMessage,
       formatException: (_) => errorMessage = errorMessages[FormatException]?.call() ?? errorMessage,
       notAcceptable: (_) => errorMessage = errorMessages[NotAcceptable]?.call() ?? errorMessage,
       socketIoError: (e) => errorMessage = errorMessages[SocketIoError]?.call(e.message) ?? errorMessage,
       networkAuthRequired: (_) => errorMessage = errorMessages[NetworkAuthRequired]?.call() ?? errorMessage,
       badGateway: (_) => errorMessage = errorMessages[BadGateWay]?.call() ?? errorMessage,
       forbidden: (_) => errorMessage = errorMessages[Forbidden]?.call() ?? errorMessage,
       gatewayTimeout: (_) => errorMessage = errorMessages[GatewayTimeout]?.call() ?? errorMessage,
       operationNotAllowed: (_) => errorMessage = errorMessages[OperationNotAllowed]?.call() ?? errorMessage,
       wrongVerification: (_) => errorMessage = errorMessages[WrongVerification]?.call() ?? errorMessage,
       invalidEmail: (_) => errorMessage = errorMessages[InvalidEmail]?.call() ?? errorMessage,
       userNotFound: (_) => errorMessage = errorMessages[UserNotFound]?.call() ?? errorMessage,
       userDisabled: (_) => errorMessage = errorMessages[UserDisabled]?.call() ?? errorMessage,
       wrongPassword: (_) => errorMessage = errorMessages[WrongPassword]?.call() ?? errorMessage,
       tooManyRequests: (_) => errorMessage = errorMessages[TooManyRequests]?.call() ?? errorMessage,
       payloadEmpty: (e) => errorMessage = errorMessages[PayloadEmpty]?.call(e.className) ?? errorMessage,
       undefined: (_) => errorMessage = errorMessages[Undefined]?.call() ?? errorMessage,
     );

     return errorMessage;
  }
}
