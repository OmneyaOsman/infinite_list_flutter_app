import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomeWidget extends StatelessWidget {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:  AppBar(
        title: Text('Hello'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _textController,
                  autocorrect: false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(25.0),
                        ),
                        borderSide: BorderSide()),
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: GestureDetector(
                      child: Icon(Icons.clear),
                      onTap: () {
                        print('hi');
                      },
                    ),
                    hintText: 'Search',
                  ),
                ),
              ),
            ),
            RawMaterialButton(
              onPressed: () {},
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.pause,
                    color: Colors.blue,
                    size: 35.0,
                  ),
                  Text('Bringi'),
                  Text('iii'),
                ],
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.white,
              padding: EdgeInsets.all(15.0),
            ),
            Stack(
              fit: StackFit.passthrough,
              children: <Widget>[
                // Max Size
                Container(
                  color: Colors.green,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    color: Colors.blue,
                    height: 300.0,
                    width: 300.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      color: Colors.pink,
                      height: 150.0,
                      width: 150.0,
                    ),
                  ),
                ),
                Positioned(
                  right: 40.0,
                  top: 40.0,
                  child: Container(
                    color: Colors.black,
                    height: 150.0,
                    width: 150.0,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
