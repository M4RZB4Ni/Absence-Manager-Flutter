import '../../../app/base/api_result.dart';

/// An abstract class representing a use case in the application.
///
/// A use case encapsulates a specific business logic operation, typically
/// involving data retrieval or manipulation. This class defines a generic
/// interface for executing a use case with optional parameters.
///
/// The [Type] is the expected return type of the use case's execution result,
/// wrapped in an [ApiResult] to handle both success and failure outcomes.
///
/// The [Params] is the type of parameters that the use case might require.
/// It's nullable to allow use cases without parameters.
abstract class UseCase<Type, Params> {
  /// Executes the use case with optional parameters.
  ///
  /// This method should be implemented by concrete use case classes to
  /// perform the intended business logic operation. The result is returned
  /// as a [Future] containing an [ApiResult] with the operation outcome.
  ///
  /// The [params] are the parameters required for the use case execution.
  /// They are optional and can be null if the use case does not require any.
  Future<ApiResult<Type>> call({Params? params});
}
