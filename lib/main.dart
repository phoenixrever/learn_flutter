import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:learn_flutter/Component/table/table_demo.dart';
import 'package:learn_flutter/component/bloc/bloc_demo.dart';
import 'package:learn_flutter/component/http/http_demo.dart';
import 'package:learn_flutter/component/localization/localizations.dart';
import 'package:learn_flutter/component/rxdart/rxdart_demo.dart';
import 'package:learn_flutter/component/state_provider/stream/stream_demo.dart';
import 'package:learn_flutter/component/stepper_demo.dart';

import 'component/Test/test_demo.dart';
import 'component/animation/animation_demo.dart';
import 'component/card_demo.dart';
import 'component/fom_demo.dart';
import 'component/component/component_emo.dart';
import 'component/sliver_demo.dart';
import 'component/state_provider/Inheritedwidget/inherited-widget.dart';
import 'component/state_provider/changenotifier/change-provider.dart';
import 'component/state_provider/value-notifier/value_notifier.dart';
import 'component/tab_bar_demo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///generate 语言包所需
      // localizationsDelegates: [
      //   //material 应用的本地化字符串
      //   GlobalMaterialLocalizations.delegate,
      //   //小部件文字的方向
      //   GlobalWidgetsLocalizations.delegate
      // ],
      // supportedLocales: [
      //   Locale('en',''),
      //   Locale('zh',''),
      //   Locale('ja',''),
      // ],
      ///手动选择语言1
      locale: Locale("ja"),
      ///手动选择语言2
      // localeResolutionCallback: (locale, supportedLocales) {
      //   // 做些判断决定显示那种语言
      //   return Locale('en');
      // },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      debugShowCheckedModeBanner: false,
      routes: {
        "sliver": (context) => SliverDemo(),
        "form": (context) => FormDemo(),
        "component": (context) => ComponentDemo(),
        "table": (context) => TableDemo(),
        "card": (context) => CardDemo(),
        "stepper": (context) => StepperDemo(),
        "state": (context) =>InheritedWidgetDemo(),
        "change-notifier": (context) =>ProviderDemo(),
        "value-notifier": (context) =>ValueNotifierDemo(),
        "stream": (context) =>StreamDemo(),
        "rxdart": (context) =>RxdartDemo(),
        "bloc": (context) =>BlocDemo(),
        "http": (context) =>HttpDemo(),
        "animation": (context) =>AnimationDemo(),
        "localizations": (context) =>LocalizationsDemo(),
        "test": (context) => TestDemo()
      },
      ///取消debug图标
      theme: ThemeData(
          primaryColor: Colors.deepPurple,
          ///按钮被按下的背景色
          highlightColor: Color.fromRGBO(255, 255, 255, 0.5),
          ///水波纹颜色
          splashColor:Colors.white70
      ),

      title: "hello again",
      home: _HomePage(),
    );
  }
}


class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarDemo();
  }
}
