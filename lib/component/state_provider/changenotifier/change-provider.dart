import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderDemo extends StatefulWidget {
  const ProviderDemo({Key? key}) : super(key: key);

  @override
  _ProviderDemoState createState() => _ProviderDemoState();
}

class _ProviderDemoState extends State<ProviderDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("change notifier"),),
      body: ChangeNotifierProvider(
        create: (context) => CountModel(),
        child: ChipWrapper(),
      ),
    );
  }
}


class CountModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  int _count=0;

  get count => _count;

  void add() {
    _count++;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
  void minus(){
    _count--;
    notifyListeners();
  }
  void remove(){
    _count=0;
    notifyListeners();
  }
}

class ChipWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SonChip(),
        SonChip(),
        SonChip(),
        Clear(),
      ],
    );
  }
}

class SonChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final int count = CountProvider.of(context)!.count;
    // final VoidCallback add = CountProvider.of(context)!.addCount;
    return Consumer<CountModel>(
      builder: (context, value, child) {
        return Column(
          children: [
            ActionChip(label: Text("${value.count}"), onPressed: () =>value.add()),
           ActionChip(label: Text("${value.count}"), onPressed: () =>value.minus()),
          ],
        );
      },
    );
  }
}

class Clear extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final countModel = Provider.of<CountModel>(context);
    return ElevatedButton(onPressed: (){countModel.remove();}, child: Text("clear"));
  }
}