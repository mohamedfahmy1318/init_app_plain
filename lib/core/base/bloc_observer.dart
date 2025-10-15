import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/logger_service.dart';
import '../di/service_locator.dart';

/// Global BLoC Observer for logging and monitoring
/// يراقب جميع الـ BLoCs ويسجل جميع Events و States
class AppBlocObserver extends BlocObserver {
  final LoggerService _logger = getIt<LoggerService>();

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _logger.debug(
      'BLoC Created: ${bloc.runtimeType}',
      tag: 'BLOC',
    );
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _logger.logBlocEvent(
      bloc.runtimeType.toString(),
      event.runtimeType.toString(),
      data: event,
    );
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _logger.logBlocState(
      bloc.runtimeType.toString(),
      change.nextState.runtimeType.toString(),
      data: change.nextState,
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _logger.error(
      'BLoC Error in ${bloc.runtimeType}',
      tag: 'BLOC',
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _logger.debug(
      'BLoC Closed: ${bloc.runtimeType}',
      tag: 'BLOC',
    );
  }
}

/// استخدام:
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   
///   // Setup Service Locator
///   await setupServiceLocator();
///   
///   // Setup BLoC Observer
///   Bloc.observer = AppBlocObserver();
///   
///   runApp(MyApp());
/// }
/// ```
