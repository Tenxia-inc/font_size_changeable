import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends Bloc {
  // BehaviorSubjects
  final _textScaleFactorSubject = BehaviorSubject<double>.seeded(1);

  // PublishSubjects
  final _setTextScaleFactorSubject = PublishSubject<double>();

  // Input
  Sink<double> get setTextScaleFactor => _setTextScaleFactorSubject.sink;

  // Output
  ValueObservable<double> get textScaleFactor => _textScaleFactorSubject;

  AppBloc() {
    // Binding
    _setTextScaleFactorSubject
        .distinct()
        .doOnData((_) {}) // ShardPreferenceに保存
        .listen(_textScaleFactorSubject.add);

    // Init
    setInitialTextScaleFactor();
  }

  Future<void> setInitialTextScaleFactor() async {
    // SharedPreferenceから値を取る
  }

  @override
  Future<void> dispose() async {
    // Drain
    await Future.wait(<BehaviorSubject>[
      _textScaleFactorSubject,
    ].map((s) => s.drain<void>()));

    // Close
    await Future.wait<void>([
      _textScaleFactorSubject.close(),
      _setTextScaleFactorSubject.close(),
    ]);
  }
}

class AppBlocProvider extends BlocProvider<AppBloc> {
  AppBlocProvider({@required Widget child})
      : super(
          child: child,
          creator: (context, _bag) => AppBloc(),
        );

  static AppBloc of(BuildContext context) => BlocProvider.of(context);
}
