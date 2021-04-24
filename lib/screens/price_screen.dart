import 'package:bitcoin_tracker/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  PriceScreen({this.coinData});
  final coinData;
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  double bitCoinPrice = 0;
  String selectedCurrency = 'USD';
  String selectedCrypto = 'BTC';
  CoinModel coinModel = CoinModel();
  @override
  void initState() {
    super.initState();
    updateUserInterface(widget.coinData);
  }

  void updateUserInterface(coinData) {
    setState(() {
      if (coinData == null) {
        bitCoinPrice = 0;
      } else {
        double _bitCoinPrice = coinData['rate'];
        bitCoinPrice = double.parse((_bitCoinPrice).toStringAsFixed(2));
      }
    });
  }

  ///Android Currencies
  DropdownButton getAndroidCurrencies() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var currencyItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(currencyItem);
    }
    return DropdownButton<String>(
      items: dropDownItems,
      value: selectedCurrency,
      onChanged: (changedValue) {
        setState(() async {
          selectedCurrency = changedValue;
          updateUserInterface(
              await coinModel.getCoinData(selectedCrypto, selectedCurrency));
        });
      },
    );
  }

  ///iOS Currencies
  CupertinoPicker getIOSCurrencies() {
    List<Text> items = [];
    for (String currency in currenciesList) {
      items.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) async {
        selectedCurrency = currenciesList[selectedIndex];
        updateUserInterface(
            await coinModel.getCoinData(selectedCrypto, selectedCurrency));
      },
      children: items,
    );
  }

  ///iOS Crypto Currencies
  CupertinoPicker getIOSCrypto() {
    List<Text> cryptoItems = [];
    for (String crypto in cryptoList) {
      cryptoItems.add(Text(crypto));
    }
    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) async {
          selectedCrypto = cryptoList[selectedIndex];
          updateUserInterface(
              await coinModel.getCoinData(selectedCrypto, selectedCurrency));
        },
        children: cryptoItems);
  }

  ///Android Crypto Currencies
  DropdownButton getAndroidCrypto() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String crypto in cryptoList) {
      var currencyItem = DropdownMenuItem(
        child: Text(crypto),
        value: crypto,
      );
      dropDownItems.add(currencyItem);
    }
    return DropdownButton<String>(
      items: dropDownItems,
      value: selectedCrypto,
      onChanged: (changedValue) {
        setState(() async {
          selectedCrypto = changedValue;
          updateUserInterface(
              await coinModel.getCoinData(selectedCrypto, selectedCurrency));
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: kPrimaryColor,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $selectedCrypto = $bitCoinPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Crypto Currencies',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  height: 150.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 30.0),
                  color: kPrimaryColor,
                  child: Platform.isIOS ? getIOSCrypto() : getAndroidCrypto()),
              SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Currencies',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  height: 150.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 30.0),
                  color: kPrimaryColor,
                  child: Platform.isIOS
                      ? getIOSCurrencies()
                      : getAndroidCurrencies()
                  //Platform.isIOS ? getiOSCurrencies: getAndroidCurrencies
                  // CupertinoPicker(
                  //   itemExtent: 32.0,
                  //   onSelectedItemChanged: (selectedIndex) {
                  //     selectedCurrency = currenciesList[selectedIndex];
                  //     print(selectedCurrency);
                  //   },
                  //   children: getCurrencies(),
                  // ),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
// <String>(
// value: selectedCurrency,
// items: getDropDownCurrencies(),
// onChanged: (changedValue) {
// setState(() {
// selectedCurrency = changedValue;
// });
// },
