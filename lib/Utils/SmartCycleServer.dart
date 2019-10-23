import 'dart:convert';
import 'dart:io';

import 'package:googleapis/customsearch/v1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:smartcycle/model/DoYouKnowDTO.dart';
import 'package:smartcycle/model/SearchHistory.dart';

const test_base = "http://172.17.0.65:8080/";
const base = 'http://smartcycle.ljhnas.com/';

class SmartCycleServer {
  static HttpClient client;

  SmartCycleServer() {
    client = new HttpClient();
  }

  void _timeOut() {}

  AuthUtils() {
    // for https certificate
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  }

  // 서버가 살아있는지 테스트
  Future<bool> isServerAlive() {

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
    if (response.statusCode == 200) {
      return jsondata;
    }
    print("사용자 기록 : " + jsondata.toString());
  }


  Future<String> registerDevice(String user_email, String berry_id) async {
    // POST /socket/

    HttpClient client = new HttpClient();
    client.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);

    Map data = {"user_email": "$user_email", "berry_id": "$berry_id"};

    var body = json.encode(data);

    HttpClientRequest request = await client
        .postUrl(Uri.parse("http://smartcycle.ljhnas.com/socket/connect"));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(body));

    HttpClientResponse response = await request.close();

    String reply = await response.transform(utf8.decoder).join();

    return reply;
  }

  // %% ONLY FOR TEST %% registerDevice
  Future<String> registerDeviceTest(String user_email, String berry_id) async {
    String result = '{"result":1}';
    return result;
  }

  // %% ONLY FOR TEST %% registerDevice
  static Future<DoYouKnows> getDoYouKnowTest() async {
    HttpClientRequest request =
    await client.getUrl(Uri.parse("${test_base}test/getDoYouKnowInfo"));
    request.headers.set('content-type', 'application/json');

    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print(reply);
    final jsondata = DoYouKnows.fromJson(json.decode(reply));
    if (response.statusCode == 200) {
      return jsondata;
    }
  }

}
