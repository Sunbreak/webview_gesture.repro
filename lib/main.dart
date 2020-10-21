import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'long_post_horizontal_drag_detector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: PageView(
        controller: _pageController,
        children: [
          NotificationListener<OverscrollNotification>(
            onNotification: (n) {
              if (n.overscroll > 0 &&
                  n.metrics.axisDirection == AxisDirection.right) {
                _pageController.jumpTo(_pageController.offset + n.overscroll);
              }
              return false;
            },
            child: HorizontalDragDetector(
              child: WebView(
                initialUrl: 'https://flutter.dev',
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ),
          Container(color: Colors.grey, constraints: BoxConstraints.expand())
        ],
      )),
    );
  }
}
