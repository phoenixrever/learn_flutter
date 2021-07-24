import 'package:flutter/material.dart';
import 'package:learn_flutter/Component/title_divider.dart';

class ChipsDemo extends StatefulWidget {
  const ChipsDemo({
    Key? key,
  }) : super(key: key);

  @override
  ChipsDemoState createState() => ChipsDemoState();
}

class ChipsDemoState extends State<ChipsDemo> {
  bool _isSelected = false;
  List<String> tags = ['Apple', 'Banana', 'Lemon'];

  void initTags() {
    setState(() {
      tags = ['Apple', 'Banana', 'Lemon'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing:5,

      ///行与行的间隔
      runSpacing: 8,
      children: [
        Chip(
          label: Text("chips"),
        ),
        Chip(
          avatar: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic_source%2F04%2F59%2F39%2F045939d823bf8db17e710c71af6f33cd.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629427299&t=04f3c9a0d4bb3f7b4db8f090edf18bb8"),
          ),
          elevation: 10,
          backgroundColor: Colors.orange,
          label: Text("chips"),
        ),
        Chip(
          clipBehavior: Clip.hardEdge,
          avatar: CircleAvatar(
            child: Text("皇"),
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          elevation: 10,
          label: Text("chips"),
          backgroundColor: Colors.green,

          ///设置了这个图标才会出来
          onDeleted: () {
            print('Flutter is deleted');
          },
          deleteIconColor: Colors.red,
        ),
        Chip(
          label: Text(
            "custom chip",
          ),
          avatar: InkWell(
            onTap: () {},
            child: Icon(
              Icons.close,
              size: 20,
              color: Colors.red,
            ),
          ),
        ),
        InputChip(
          elevation: 15,

          ///按下去的阴影
          pressElevation: 5,
          selected: _isSelected,
          onPressed: () {
            setState(() {
              _isSelected = !_isSelected;
            });
          },
          selectedColor: Colors.blue,
          checkmarkColor: Colors.white,
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: Colors.black54,
          label: Text('input chip'),
          onDeleted: () {
            print('Flutter is deleted');
          },
        ),
        Divider(
          color: Colors.grey,
          height: 32.0,

          ///左右缩进
          indent: 30,
          endIndent: 30,
        ),
        TitleDivider(title: "remove chip"),
        Wrap(
          spacing: 8,
          children: tags
              .map((tag) => Chip(
            label: Text(tag),
            onDeleted: () {
              setState(() {
                tags.remove(tag);
              });
            },
          ))
              .toList(),
        ),
        TitleDivider(title: "Action chip"),
        Wrap(
          spacing: 8,
          children: tags
              .map((tag) => ActionChip(
            onPressed: () {},
            label: Text(tag),
          ))
              .toList(),
        ),
        TitleDivider(title: "filter chip"),
        Wrap(spacing: 8, children: [
          FilterChip(
            label: Text("filter chip"),
            selected: _isSelected,
            onSelected: (value) {
              setState(() {
                _isSelected = !_isSelected;
              });
            },
          )
        ]),
        TitleDivider(title: "choice chip"),
        Wrap(spacing: 8, children: [
          ChoiceChip(
            label: Text("ChoiceChip"),
            selected: _isSelected,
            onSelected: (value) {
              setState(() {
                _isSelected = !_isSelected;
              });
            },
          )
        ]),
      ],
    );
  }
}
