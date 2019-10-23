import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


const email_uri = 'https://www.googleapis.com/oauth2/v3/userinfo';
const base = 'http://smartcycle.ljhnas.com';
const test_base = "http://172.17.1.172:8080/";

HttpClient client = new HttpClient();
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;




class AuthUtils {
  GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
      'openid',
      'profile',
    ],
  );

//  AuthUtils() {
//    client.badCertificateCallback =
//    ((X509Certificate cert, String host, int port) => true);
//  }

  Future<FirebaseUser> handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser
        .authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential))
        .user;
    print("signed in " + user.displayName);
    return user;
  }

  void signOut() {
    _auth.signOut();
    _googleSignIn.signOut();
  }

  Future<bool> isSignIn() async {
    bool check = await _googleSignIn.isSignedIn();
    print(check);
    return check;
  }

  Future<UserInfo> currentUser() async {
    print(_auth.currentUser().toString());
    return _auth.currentUser();
  }


//  Future<InitUserDTO> getInitialUserData() async {
//    InitUserDTO userDTO = InitUserDTO();
//    await getAccessToken().then((access_token) {
//      if (access_token != null) {
//        userDTO.user_access_token = access_token;
//      }
//    });
//
//    await getUserId().then((userId) {
//      userDTO.user_id = userId;
//    });
//
//    await getUserEmail().then((userEmail) {
//      userDTO.user_email = userEmail;
//    });
//
//    return userDTO;
//  }

//  Future<String> openGoogleSignIn() async {
//    try {
//      //_googleSignIn.
//      GoogleSignInAccount account = await _googleSignIn.signIn();
//      GoogleSignInAuthentication authentication = await account.authentication;
//      String access_token = authentication.accessToken;
//      print(account.toString());
//      print(authentication.toString());
//
//      if (access_token != "INIT") {
//        saveAccessToken(access_token);
//        saveUserId(account.id);
//        return access_token;
//      }
//      return "ERROR";
//    } catch (error) {
//      print(error);
//      return "ERROR";
//    }
//  }


//  // %%%% 사용자 구글 프로필 %%%%
//  Future<GoogleProfileDTO> getUserProfile(String userId,
//      String access_token) async {
//    print("userId" + userId.toString());
//    print("access_token" + access_token);
//    http.Response response = await http.get(
//        "https://www.googleapis.com/plus/v1/people/${userId}?access_token=${access_token}");
//    print(response.body);
//    if (response.statusCode == 401) {
//      return null;
//    }
//
//
//    GoogleProfileDTO googleProfileDTO = json.decode(response.body);
//
//    return googleProfileDTO;
//  }

//  // %% ONLY FOR TEST %% getUserHistoryTest
//  Future<GoogleProfileDTO> getUserProfileTest(InitUserDTO initUserDTO) async {
//    // userId와 access_token은 실질적으로 의미가 없습니다.
//    // JSON 파싱 테스트용
//    http.Response response = await http.get(
//        "${test_base}test/getUserProfile");
//    print(response.body);
//    if (response.statusCode == 401) {
//      return null;
//    }
//
//
//    GoogleProfileDTO googleProfileDTO = json.decode(response.body);
//
//    return googleProfileDTO;
//  }


//  // access_token 불러오기
//  Future<String> getAccessToken() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String accessToken = prefs.getString('access_token');
//    print("엑세스 토큰" + accessToken);
//
//    return accessToken;
//  }
//
//// refresh_token 불러오기
//  Future<String> getRefreshToken() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String refreshToken = prefs.getString('refresh_token');
//    return refreshToken;
//  }
//
//  // userEmail 불러오기
//  Future<String> getUserEmail() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String userEmail = prefs.getString('user_email');
//    return userEmail;
//  }


//  // userId 블러오기
//  Future<String> getUserId() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String userId = prefs.getString('user_id');
//    return userId;
//  }
//
//  // userId 저장하기
//  saveUserId(String userId) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setString('user_id', userId);
//  }
//
//
//  // userEmail 저장하기
//  saveUserEmail(String user_email) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setString('user_email', user_email);
//  }
//
//// access_token 저장
//  saveAccessToken(String token) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setString('access_token', token);
//  }
//
//// refresh_token 저장
//  saveRefreshToken(String token) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setString('refresh_token', token);
//  }

//// 새로운 access_token 가져오기
//  Future<String> getNewAccessTokenByRefreshToken() async {
//    String refreshToken = await getRefreshToken();
//    http.Response response = await http
//        .get(base + "/getNewAccessToken?refresh_token=" + refreshToken);
//    await saveAccessToken(response.body.toString());
//    return response.body.toString();
//  }
//
//// 사용자 프로필 사진 가져오기
//  Future<String> getUserPhoto() async {
//    String access_token;
//    await getAccessToken().then((value) {
//      access_token = value;
//    });
//
//    http.Response response =
//    await http.get(base + "/getGoogleProfile?access_token=" + access_token);
//    //print("엑세스 토큰" + response.body);
//    return response.body;
//  }

//  Future<String> getUserPhotoDir(String access_token) async {
//    http.Response response =
//    await http.get(base + "/getGoogleProfile?access_token=" + access_token);
//    print(response.body);
//    return response.body;
//  }
//
//  Future<String> getGoogleProfile(String access_token) async {
//    //print("받은 액세스 토큰 : " + access_token);
//    HttpClientRequest request = await client.getUrl(Uri.parse(
//        "https://smartcycle.ljhnas.com/getGoogleProfile?access_token=$access_token"));
//    request.headers.set('content-type', 'application/json');
//
//    HttpClientResponse response = await request.close();
//
//    String reply = await response.transform(utf8.decoder).join();
//
//    String code = response.statusCode.toString();
//
//    print("상태 코드 : " + code);
//    if (code == "401") {
//      return code;
//    }
//    return reply;
//  }

//  // SignOut Action
//  signOut() {
//    saveAccessToken("0");
//    saveUserEmail("0");
//    saveRefreshToken("0");
//  }


}
