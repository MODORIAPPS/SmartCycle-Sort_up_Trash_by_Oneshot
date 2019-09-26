import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const email_uri = 'https://www.googleapis.com/oauth2/v3/userinfo';
const base = 'https://smartcycle.ljhnas.com';

class AuthUtils {
// access_token 불러오기
  Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token');
    return accessToken;
  }

// refresh_token 불러오기
  Future<String> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String refreshToken = prefs.getString('refresh_token');
    return refreshToken;
  }

// access_token 저장
  saveAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', token);
  }

// refresh_token 저장
  saveRefreshToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('refresh_token', token);
  }

// 새로운 access_token 가져오기
  Future<String> getNewAccessTokenByRefreshToken() async {
    String refreshToken;
    await getRefreshToken().then((value) {
      refreshToken = value;
    });

    http.Response response = await http
        .get(base + "/getNewAccessToken?refresh_token=" + refreshToken);

    return response.body.toString();
  }

// 사용자 프로필 사진 가져오기
  Future<String> getUserPhoto() async {
    String access_token;
    await getAccessToken().then((value) {
      access_token = value;
    });

    http.Response response = await http
        .get(base + "/getPhotoByAccessToken?access_token=" + access_token);
    return response.body;
  }
}
