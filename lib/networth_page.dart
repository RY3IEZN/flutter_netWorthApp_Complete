import 'package:flutter/material.dart';

class NetWorthPage extends StatefulWidget {
  NetWorthPage({Key? key, this.amount}) : super(key: key);

  final amount;
  @override
  State<NetWorthPage> createState() => _NetWorthPageState();
}

class _NetWorthPageState extends State<NetWorthPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 2000),
  );

  late final Animation<int> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animation = IntTween(begin: 0, end: widget.amount).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff222747),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: _animation,
              builder: (BuildContext context, dynamic value, Widget? child) {
                return Text("Your total network is $value");
              },
            ),
          ],
        ),
      ),
    );
  }
}
