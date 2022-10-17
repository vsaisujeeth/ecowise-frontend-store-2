
import 'dart:convert';
import 'package:ecowise_vendor_v2/Utils/constants.dart';
import 'package:http/http.dart' as http;



class ApiServices {
  final baseUrl = "https://aur5b90lzd.execute-api.ap-south-1.amazonaws.com/dev";

  logIn(String username, String password) async {
    Map<String, dynamic> data = {"username": username, "password": password};
    var res = await http.post(Uri.parse(baseUrl + "/storeSignIn"),
        headers: {"Content-Type": "application/json"}, body: json.encode(data));

    var response = json.decode(res.body);

    print("Response is - $response");

    if (res.statusCode == 200) {
      storeConstants.initiateAuthToken(response['token']);
      bool gotProfile = await getStoreProfile(response['token']);
      return gotProfile;
// =======
//       storeDetails.initiateToken(response['token']);
//       SecureStorage().deleteToken();
//       ecureStorage().saveToken(storeDetails.authToken);

//       return "";
// >>>>>>> main
    } else {
      return false;
    }
  }

  signUp(String name, String username, String password, var address) async {
    Map<String, dynamic> data = {
      "name": name,
      "username": username,
      "password": password,
      "address": address
    };
    var res = await http.post(Uri.parse(baseUrl + "/storeSignUp"),
        headers: {"Content-Type": "application/json"}, body: json.encode(data));

    var response = json.decode(res.body);

    print("Response is - $response");

    if (res.statusCode == 200) {

      //storeConstants.initiateStoreConstants(response);
      return true;

    } else {
      return false;
    }
  }


  getStoreProfile(String token)async{

    print("The token is - $token");

    var res = await http.get(
      Uri.parse(baseUrl + '/admin/getStoreProfile'),
      headers: {
        "Content-Type": "application/json",
        "X-Amz-Security-Token": token,
      },
    );

    var response = json.decode(res.body);

    print("Response on getting store profile - ${response['configurations']}");

    if(res.statusCode == 200){
      storeConstants.initiateStoreConstants(response);

      return true;
    }
    return false;
  }

  getStoreOrders(String token)async{
    var res = await http.get(Uri.parse(baseUrl + "/admin/getPickUpReqStore"),
        headers: {
          "Content-Type": "application/json",
          "X-Amz-Security-Token": token
        }
    );

    var response = json.decode(res.body);

    print("The response on requesting Orders - $response");
    if(res.statusCode == 200){
      //initiateStoreOrders using storeConstants.
      storeConstants.initiateStoreOrders(response);
      return true;
    }
    return false;
  }

  getDefaults(String token) async {
    var res = await http.get(
      Uri.parse(baseUrl + '/api/getDefaults'),
      headers: {
        "Content-Type": "application/json",
        "X-Amz-Security-Token": token
      },
    );

    var response = json.decode(res.body);
    print("Defaults: " + response.toString());
    if (res.statusCode == 200) {
      storeConstants.initiateCategories(response['categories']);

      var data = {for (var v in response['configs']) v['name']: v['value']};
      storeConstants.initiateConfigs(data);

      print("Configurations are - $data");
      return true;
    } else {
      return false;
    }
  }

  editStoreProfile(String token,Map data)async{


    print("Posting on server to change the status ---- ${data['configurations']}");
    var res = await http.post(
        Uri.parse(baseUrl + '/admin/editStoreProfile'),
        headers: {
          "Content-Type": "application/json",
          "X-Amz-Security-Token": token
        },
        body: json.encode(data)
    );

    var response = json.decode(res.body);
    print("Response on posting to server - $response");

    if(res.statusCode == 200 ){
      bool x = await getStoreProfile(token);
      return x;
    }
    return false;
  }

  approveOrder(String token,String orderId,expectedPoints)async{

    Map<String,dynamic> data = {
      "p_id" : orderId,
      "earned_points" : expectedPoints
    };
    print(data);

    var res = await http.post(
        Uri.parse(baseUrl + '/admin/approvePickUpStore'),
        headers: {
          "Content-Type": "application/json",
          "X-Amz-Security-Token": token
        },
        body: json.encode(data)
    );
    var response = json.decode(res.body);
    print("The response on approving the request - $response");
    if(res.statusCode == 200) {
      return true;
    }

    return false;
  }
}

