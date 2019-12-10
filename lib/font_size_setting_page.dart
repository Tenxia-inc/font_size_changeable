import 'package:flutter/material.dart';
import 'package:font_size_changeable/app_bloc.dart';
import 'package:font_size_changeable/fit_text.dart';

@immutable
class FontSizeSettingPage extends StatelessWidget {
  const FontSizeSettingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(centerTitle: true, title: const Text('画面表示')),
      body: ListView(
        children: [
          const SizedBox(height: 50),
          const FitText(
            '自動でサイズが調整されてほしいテキスト。\n'
            '運営者側の説明文や注釈などで、\n'
            '変なところで改行してほしくないときに使う。\n'
            '左右にPaddingを入れておくと\n'
            '画面いっぱいまで広がらないので良い。',
            padding: EdgeInsets.symmetric(horizontal: 8),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          Row(
            children: [
              Spacer(),
              Column(children: [
                const Text(
                  'フォントサイズが',
                  textScaleFactor: 1,
                  textAlign: TextAlign.right,
                ),
                const Text(
                  '不変であってほしいテキスト。',
                  textScaleFactor: 1,
                  textAlign: TextAlign.right,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: const Text(
                    'ボタンとか',
                    textScaleFactor: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ]),
            ],
          ),
          const SizedBox(height: 50),
          const Text(
            '普通に文字サイズが変更されてほしいテキスト。\n'
            'メインのコンテンツとかですね',
          ),
          const SizedBox(height: 50),
          _TextSizeSlider(),
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
