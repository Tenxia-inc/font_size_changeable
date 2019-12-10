import 'package:flutter/material.dart';
import 'package:font_size_changeable/app_bloc.dart';

@immutable
class FontSizeSettingPage extends StatelessWidget {
  const FontSizeSettingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('画面表示'),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            color: Colors.white,
            child: _TextSizeSlider(),
          )
        ],
      ),
    );
  }
}

class _TextSizeSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = AppBlocProvider.of(context);
    return Row(
      children: [
        const Text(
          'Aa',
          style: TextStyle(fontSize: 12),
          textScaleFactor: 1,
        ),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 3),
              activeTickMarkColor: Theme.of(context).primaryColor,
              inactiveTickMarkColor: Theme.of(context).primaryColorLight,
            ),
            child: StreamBuilder<double>(
              initialData: bloc.textScaleFactor.value,
              stream: bloc.textScaleFactor,
              builder: (context, snapshot) => Slider(
                value: snapshot.data,
                onChanged: bloc.setTextScaleFactor.add,
                min: 0.75,
                max: 2,
                divisions: 5,
              ),
            ),
          ),
        ),
        const Text(
          'Aa',
          style: TextStyle(fontSize: 24),
          textScaleFactor: 1,
        ),
      ],
    );
  }
}
