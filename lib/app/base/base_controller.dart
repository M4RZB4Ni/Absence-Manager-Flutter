import 'package:crewmeister/app/base/result_state.dart';
import 'package:get/get.dart';


abstract class BaseController extends GetxController {
  final Rx<ResultState?> _pageStateController = const ResultState.idle().obs;

  ResultState get pageState => _pageStateController.value ?? const ResultState.idle();

  void updatePageState(final ResultState state) => _pageStateController(state);

  void showLoading() => updatePageState(const ResultState.loading());

  void resetPageState() => updatePageState(const ResultState.idle());

  void hideLoading() => resetPageState();

}

