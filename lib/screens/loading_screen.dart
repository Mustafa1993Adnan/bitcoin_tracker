import 'package:bitcoin_tracker/coin_data.dart';
import 'package:bitcoin_tracker/screens/price_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCoinData();
  }

  void getCoinData() async {
    String coinType = 'BTC';
    String currency = 'USD';
    var coinDataFirstLoad = await CoinModel().getCoinData(coinType, currency);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PriceScreen(
        coinData: coinDataFirstLoad,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitThreeBounce(
        color: Colors.green,
        size: 60,
      ),
    ));
  }
}
