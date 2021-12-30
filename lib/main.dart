import 'package:flutter/material.dart';
import 'package:textfield_maxlength_example/formatter/max_length_in_line_formatter.dart';
import 'package:textfield_maxlength_example/formatter/max_lines_formatter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      title: 'TextField Example',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: MyHomePage(title: 'TextField Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Center(child: buildTextField()),
        ],
      ),
    );
  }

  final int maxLength = 120;
  final int maxLengthInLine = 20;

  final int maxLines = 3;
  final int maxLinesForced = 3;

  Widget buildTextField() =>  Builder(
      builder: (context) => TextField(
            textInputAction: TextInputAction.newline,
            autofocus: true,
            maxLength: maxLength,
            maxLengthEnforced: true,
            maxLines: maxLines,
            inputFormatters: [
              MaxLinesTextInputFormatter(maxLinesForced, () {
                  showSnackBar(context, 'Only $maxLinesForced line breaks are allowed.');
              }),
              MaxLengthPerLineFormatter(maxLengthInLine, () {
                  showSnackBar(context, 'Only $maxLengthInLine characters are allowed per line.');
              }),
            ],
            style: TextStyle(fontSize: 22),
            decoration: InputDecoration(
              border: border(),
            ),
        ),
  );

  InputBorder border() => OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    borderSide: BorderSide(color: Colors.transparent, width: 0),
  );

  void showSnackBar(BuildContext context, String text) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(text),
      ));
  }
}
