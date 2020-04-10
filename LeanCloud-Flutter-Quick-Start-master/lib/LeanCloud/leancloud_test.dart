import 'package:leancloud_storage/leancloud.dart';

class LeanCloudTest{
  // LeanCloud Setup
  String _appID = 'mscpCUgWqeI2RdYhrkgHF4ab-gzGzoHsz';
  String _appKey = 'Iy6NnNNybR7SPMNG06pknoY2';
  String _server = 'https://mscpcugw.lc-cn-n1-shared.com';

  LeanCloudTest(){
    LeanCloud.initialize(_appID, _appKey, server: _server);
    LCLogger.setLevel(LCLogger.DebugLevel);
  }

  void signUpTest(){
    // Test Data
    String username = 'testUser1';
    String mobile = '13601797352';
    String password = 'password';

    // Create LC User
    LCUser newUser = new LCUser();
    newUser.username = username;
    newUser.password = password;
    newUser.mobile = mobile;

    // Sign Up
    // LCSMSClient.requestSMSCode(mobile);
    // signUp(newUser);
  }

  signUp(LCUser newUser) async {
    try {
      LCUser result = await newUser.signUp();
    } on LCException catch (e) {
      switch (e.code){
        case 202: {
          print("Username Used");
        }
        break;
        default: {
          print(e.message);
        }
        break;
      }
    }
  }

  static logIn(String phoneNumber, String password){
  }

  void saveTest(){
    LCObject testObject = new LCObject("Tddo");

    testObject.add("title", "马拉松报名");
    testObject.add("priority", 2);

    testObject.save();
  }
}