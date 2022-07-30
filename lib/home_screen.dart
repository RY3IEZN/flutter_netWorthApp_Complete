import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'networth_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var assetAmount = 0;
  var liabilitiesAmount = 0;

  setAssetAmount(int asset) {
    setState(() {
      assetAmount = asset;
    });
  }

  setLiabilitiesAmount(int liabilities) {
    setState(() {
      liabilitiesAmount = liabilities;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff222747),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Add your assets and liabilities",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 100,
                ),
                AmountCard(
                  title: "assets",
                  amount: assetAmount,
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return NumberInputDialog(
                            onTap: setAssetAmount,
                            title: "assets",
                            amount: assetAmount);
                      }),
                ),
                SizedBox(height: 15),
                AmountCard(
                  title: "liabilitiess",
                  amount: liabilitiesAmount,
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return NumberInputDialog(
                            onTap: setLiabilitiesAmount,
                            title: "liabilities",
                            amount: liabilitiesAmount);
                      }),
                ),
                SizedBox(
                  height: 90,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => NetWorthPage(
                              amount: assetAmount - liabilitiesAmount),
                          fullscreenDialog: true),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(20),
                      onPrimary: Colors.black,
                      primary: Colors.white),
                  child: Text("Calculate"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* card component */
class AmountCard extends StatelessWidget {
  AmountCard(
      {Key? key,
      required this.title,
      required this.amount,
      required this.onTap})
      : super(key: key);

  final String title;
  final int amount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(title), Text(amount.toString())],
          ),
        ),
      ),
    );
  }
}

/* dialog to add value */
class NumberInputDialog extends StatefulWidget {
  NumberInputDialog({
    Key? key,
    required this.title,
    required this.amount,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final int amount;
  final Function(int) onTap;

  @override
  State<NumberInputDialog> createState() => _NumberInputDialogState();
}

class _NumberInputDialogState extends State<NumberInputDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: widget.amount == 0 ? "" : widget.amount.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.title),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: "Write Amount",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onTap(int.parse(_controller.text));
                Navigator.of(context).pop();
              },
              child: Text("Done"),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  primary: Colors.indigo),
            )
          ],
        ),
      ),
    );
  }
}
