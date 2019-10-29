import 'dart:convert';
import 'dart:io';

import 'package:googleapis/customsearch/v1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:smartcycle/model/DoYouKnowDTO.dart';
import 'package:smartcycle/model/RcleDetail.dart';
import 'package:smartcycle/model/SearchHistory.dart';


/// SmartCycle 의 서버와 연결해주는 역할을 합니다.
/// test_base는 테스트 코드를 위한 로컬 서버를 가르킵니다.
/// 메소드명 뒤에 Test가 붙은 것들은 로컬 서버를 향하는 테스트 코드입니다.
/// ex) getUserHistoryTest
class SmartCycleServer {
  static var test_base = "http://172.16.0.157:8080";
  static var test_client_base = "$test_base/";
  static var base = 'http://smartcycle.ljhnas.com/';
  static var base_n = 'http://smartcycle.ljhnas.com';
  HttpClient client;

  SmartCycleServer() {
    client = new HttpClient();
  }

  void _timeOut() {}

  AuthUtils() {
    // for https certificate
    client.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
  }

  static String getServerImage(String image) {
    return base_n + "/pictures" + image;
  }

  // %%%% 최근 검색한 분리수거 %%%%
  Future<SearchHistorys> getUserHistory(String userEmail) async {
    print(userEmail);
    HttpClientRequest request =
    await client.getUrl(Uri.parse(base + "trash/info/$userEmail"));
    request.headers.set('content-type', 'application/json');

    HttpClientResponse response = await request.close();
    response.timeout(const Duration(seconds: 20));

    String reply = await response.transform(utf8.decoder).join();
    print(reply);
    print(response.statusCode.toString());
    final jsondata = SearchHistorys.fromJson(json.decode(reply));
    print("사용자 기록 : " + jsondata.toString());
    return jsondata;
  }

  // %% ONLY FOR TEST %% getUserHistoryTest
  Future<SearchHistorys> getUserHistoryTest(String userEmail) async {
    // 이 함수에서는 실질적으로 userEmail 의 의미가 없습니다.

    HttpClientRequest request =
    await client.getUrl(Uri.parse(test_client_base + "test/trash/lately"));
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
  Future<DoYouKnows> getDoYouKnowTest() async {
    HttpClientRequest request = await client
        .getUrl(Uri.parse("${test_client_base}test/getDoYouKnowInfo"));
    request.headers.set('content-type', 'application/json');

    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print(reply);
    final jsondata = DoYouKnows.fromJson(json.decode(reply));
    if (response.statusCode == 200) {
      return jsondata;
    }
  }

  Future<RclDetail> getRclDetail(int itemId) async {
    //print("요청 진입 : " + itemId.toString());
    http.Response response = await http.get(
        Uri.encodeFull('http://smartcycle.ljhnas.com/trash/info/$itemId'),
        headers: {"Accept": "application/json"});

    //printch
    // ("받은 쓰레기 이름" + TrashType().getTrashName(itemId));
    //print(response.body);
    final jsonData = json.decode(response.body.toString());
    RclDetails data = RclDetails.fromJson(jsonData);
    //rclData = data.rcls[0];
    //print(data.rcls[0].name.toString());

    return data.rcls[0];
    //print("데이터가 잘 전송되고 있어요." + detailData['step2Content']);
  }

  // %% ONLY FOR TEST %% rclDetail
  Future<RclDetail> getRclDetailTest(int itemId) async {
    print("요청 진입 : " + itemId.toString());
    http.Response response = await http.get(
        Uri.encodeFull('${test_client_base}test/getRclDetail'),
        headers: {"Accept": "application/json"});

    //printch
    // ("받은 쓰레기 이름" + TrashType().getTrashName(itemId));
    //print(response.body);
    final jsonData = json.decode(response.body.toString());
    RclDetails data = RclDetails.fromJson(jsonData);
    //rclData = data.rcls[0];
    //print(data.rcls[0].name.toString());

    return data.rcls[0];
    //print("데이터가 잘 전송되고 있어요." + detailData['step2Content']);
  }

  // %% ONLY FOR TEST %% rclDetail
  Future<String> getCameraResultTest() {
    return new Future.delayed(new Duration(seconds: 50), () {
      return '0';
    });
  }

  Future<String> getCameraResult(File image) async {
    print("서버 요청 시작");

    String base64Image = base64Encode(image.readAsBytesSync());
    String fileName = image.path
        .split("/")
        .last;
    Map<String, dynamic> map;

    // !! SAMPLE EMAIL USED
    Map jsondata = {
      'img': '$base64Image',
      'name': '$fileName',
      'userEmail': 'kwonkiseok7@gmail.com'
    };
    //var jsonData = '{ "img": "$base64Image", "name": "$fileName", "userEmail":"kwonkiseok7@gmail.com" }';
    //var gay = json.encode(jsonData);
    //print(jsonData);
    await http.post(base_n + "/api/phone/trash", body: jsondata).then((res) {
      print(res.statusCode);
      print("상욱쨩이 나에게 보낸 이미지에 대한 답장이당 <3 ${res.body.toString()}");
      map = jsonDecode(res.body);
      //return map['trashId'];
    }).catchError((err) {
      print(err);
      return err;
    });

    return map['trashId'];
  }
}
