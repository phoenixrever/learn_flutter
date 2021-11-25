import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationsDemo extends StatelessWidget {
  const LocalizationsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(title: Text("localizations"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${locale.languageCode}'),//ja
            Text('${locale.toString()}'),//ja
            // Text(AppLocalizations.of(context)!.helloWorld),
          ],
        ),
      ),
    );
  }
}
