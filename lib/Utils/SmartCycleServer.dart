import 'dart:convert';
import 'dart:io';

import 'package:googleapis/customsearch/v1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:smartcycle/model/SearchHistory.dart';

const test_base = "http://192.168.15.70:8080/";
const base = 'http://smartcycle.ljhnas.com/';

class SmartCycleServer {
  HttpClient client;

  SmartCycleServer() {
    client = new HttpClient();
  }

  void _timeOut() {

  }


  AuthUtils() {
    // for https certificate
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  }

  // %%%% 최근 검색한 분리수거 %%%%
  Future<SearchHistorys> getUserHistory(String userEmail) async {
    print(userEmail);
    HttpClientRequest request =
        await client.getUrl(Uri.parse("{$base}trash/lately/$userEmail"));
    request.headers.set('content-type', 'application/json');


    HttpClientResponse response = await request.close();
    response.timeout(const Duration(seconds: 20));

    String reply = await response.transform(utf8.decoder).join();
    print(reply);
    final jsondata = SearchHistorys.fromJson(json.decode(reply));
    print("사용자 기록 : " + jsondata.toString());
    return jsondata;
  }


  // %% ONLY FOR TEST %% getUserHistoryTest
  Future<SearchHistorys> getUserHistoryTest(String userEmail) async {
    // 이 함수에서는 실질적으로 userEmail 의 의미가 없습니다.

    HttpClientRequest request =
        await client.getUrl(Uri.parse("${test_base}test/trash/lately"));
    request.headers.set('content-type', 'application/json');

    HttpClientResponse response = await request.close();

    String reply = await response.transform(utf8.decoder).join();
    print(reply);
    final jsondata = SearchHistorys.fromJson(json.decode(reply));
    print("사용자 기록 : " + jsondata.toString());
    return jsondata;
  }
}
