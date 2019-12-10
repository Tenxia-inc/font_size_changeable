import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_size_changeable/app_bloc.dart';
import 'package:font_size_changeable/font_size_setting_page.dart';
import 'package:font_size_changeable/logger.dart';

const _minFactor = 0.8;
const _maxFactor = 2.0;

@immutable
class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = AppBlocProvider.of(context);
    return StreamBuilder<double>(
      initialData: bloc.textScaleFactor.value,
      stream: bloc.textScaleFactor,
      builder: (context, snapshot) => MaterialApp(
        title: 'Font Size Changeable',
        home: const FontSizeSettingPage(),
        builder: (BuildContext context, Widget child) {
          final platformFactor = MediaQuery.of(context).textScaleFactor ?? 1;
          final multipliedFactor = platformFactor * snapshot.data;
          final adjustedFactor =
              min(max(_minFactor, multipliedFactor), _maxFactor);
          logger.info('Set textScaleFactor: $adjustedFactor');
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaleFactor: adjustedFactor),
            child: child,
          );
        },
      ),
    );
  }
}
