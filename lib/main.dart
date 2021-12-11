import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:learn_flutter/Component/table/table_demo.dart';
import 'package:learn_flutter/component/async/future_demo.dart';
import 'package:learn_flutter/component/async/stream_game.dart';
import 'package:learn_flutter/component/bloc/bloc_demo.dart';
import 'package:learn_flutter/component/http/http_demo.dart';
import 'package:learn_flutter/component/localization/localizations.dart';
import 'package:learn_flutter/component/rxdart/rxdart_demo.dart';
import 'package:learn_flutter/component/scroll/list_navigation.dart';
import 'package:learn_flutter/component/scroll/sliver_app.dart';
import 'package:learn_flutter/component/shared_perferences/SharedPreferencesDemo.dart';
import 'package:learn_flutter/component/state_provider/stream/stream_demo.dart';
import 'package:learn_flutter/component/stepper_demo.dart';
import 'package:learn_flutter/component/swipper/IosSwiper.dart';

import 'component/animation/animated_crossfade_demo.dart';
import 'component/ios/IosDemo.dart';
import 'component/Test/test_demo.dart';
import 'component/animation/animation_demo.dart';
import 'component/card_demo.dart';
import 'component/fom_demo.dart';
import 'component/component/component_demo.dart';
import 'component/key/key_demo.dart';
import 'component/layout/key_game.dart';
import 'component/layout/layout_constraints.dart';
import 'component/layout/multichild_layout.dart';
import 'component/layout/render_object_demo.dart';
import 'component/other/count_down_demo.dart';
import 'component/other/build_context_demo.dart';
import 'component/other/hollowed_text.dart';
import 'component/other/small_widget.dart';
import 'component/other/water_marker.dart';
import 'component/other/will_pop_scope_demo.dart';
import 'component/scroll/GridViewDemo.dart';
import 'component/scroll/github_demo.dart';
import 'component/scroll/infinity_scroll.dart';
import 'component/scroll/list_view.dart';
import 'component/scroll/single_child_scroll_view.dart';
import 'component/scroll/sliver_demo.dart';
import 'component/scroll/sliver_fill_remaining.dart';
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
        "form": (context) => FormDemo(),
        "component": (context) => ComponentDemo(),
        "table": (context) => TableDemo(),
        "card": (context) => CardDemo(),
        "stepper": (context) => StepperDemo(),
        "state": (context) => InheritedWidgetDemo(),
        "change-notifier": (context) => ProviderDemo(),
        "value-notifier": (context) => ValueNotifierDemo(),
        "stream": (context) => StreamDemo(),
        "rxdart": (context) => RxdartDemo(),
        "bloc": (context) => BlocDemo(),
        "http": (context) => HttpDemo(),
        "animation": (context) => AnimationDemo(),
        "localizations": (context) => LocalizationsDemo(),
        "test": (context) => TestDemo(),
        "ios": (context) => IosDemo(),
        "swiper": (context) => IosSwiper(),
        "shared_preferences": (context) => SharedPreferencesDemo(),
        "list-view": (context) => ListViewDemo(),
        "gridview": (context) => GridViewDemo(),
        "SingleChildScrollView": (context) => SingleChildScrollViewDemo(),
        "github": (context) => GithubDemo(),
        "constraints": (context) => LayoutConstraints(),
        "multichild": (context) => MultiChildLayout(),
        "renderObject": (context) => RenderObjectDemo(),
        "keydemo": (context) => KeyDemo(),
        "key-game": (context) => KeyGame(),
        "future": (context) => FutureDemo(),
        "list-navigation": (context) => ListNavigation(),
        "stream-game": (context) => StreamGame(),
        "sliver": (context) => SliverDemo(),
        "sliver-fill-remaining": (context) => SliverFillRemainingDemo(),
        "sliver-app": (context) => SliverApp(),
        "cross-fade": (context) => AnimatedCrossFadeDemo(),
        "small-widget": (context) => SmallWidgetsDemo(),
        "hollowed-text": (context) => HollowedText(),
        "build-context": (context) => BuildContextDemo(),
        "water-marker": (context) => WaterMarker(),
        "count-down-demo": (context) => CountDownDemo(),
        "will-pop-scope": (context) =>WillPopScopeDemo(),
        "infinity_scroll":(context) =>InfinityScroll(),
      },

      /*///取消debug图标
      theme: ThemeData(
          primaryColor: Colors.deepPurple,

          ///词语颜色
          accentColor: Colors.purpleAccent,

          ///按钮被按下的背景色
          highlightColor: Color.fromRGBO(255, 255, 255, 0.5),

          ///水波纹颜色
          splashColor: Colors.white70,

          ///按钮主题  针对旧按钮有效
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.tealAccent,
              textTheme: ButtonTextTheme.accent,
              height: 50),
          textTheme: TextTheme(
            subtitle1: TextStyle(color: Colors.teal)
          ),
        cardTheme: CardTheme(color: Colors.white70)
      ),
*/
      // 适配终端的主题风格
      // theme: ThemeData.light(),
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.pink
        ),
      darkTheme:ThemeData.dark() ,
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
