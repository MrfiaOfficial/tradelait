import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:tradelait/services/routes/approutes.dart';

class ForexScreen extends StatefulWidget {
  @override
  createState() => _ForexScreenState();
}

class _ForexScreenState extends State<ForexScreen> {
  bool isLoading = true;
  final _key = UniqueKey();

  _ForexScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: _scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              AppRoutes.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.black)),
        title: Text(
          ' ',
          style: TextStyle(
            color: Color.fromARGB(255, 49, 76, 190),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            WebView(
              key: _key,
              initialUrl: 'https://forexadvocate.com',
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 10, 5),
                  child: IconButton(
                    onPressed: () {
                      AppRoutes.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  )),
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(),
          ],
        ),
      ),
    );
  }
}
