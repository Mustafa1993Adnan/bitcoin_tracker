import 'package:bitcoin_tracker/services/networkHelper.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const apiKey = 'C382924F-CEA2-4BDF-8C8A-B1636074CFEC';
const coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate';

class CoinModel {
  //Default coin type and currency
  String coinType = 'BTC';
  String currency = 'USD';
  Future<dynamic> getCoinData(String coinType, String currency) async {
    var url = '$coinApiUrl/$coinType/$currency?apiKey=$apiKey';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var coinData = await networkHelper.getData();
    //print(url);
    //print(coinData);
    return coinData;
  }
}
