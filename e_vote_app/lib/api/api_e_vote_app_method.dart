import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_vote_app/api/config.dart';
import 'package:e_vote_app/public/globals.dart' as globals;


Map<String, dynamic> api_e_vote_app_post_response_sync(String url, String unencodedPath , Map<String, String> header,Map<String,dynamic> requestBody) { 

    Map<String, dynamic> response_list={
    '1': {'title':'1عنوان1','by_user_name':'اسم مستخدم11','is_checked':true},
    '2': {'title':'عنوان22','by_user_name':'اسم مستخدم22','is_checked':false},
    };
    
    http.post(
      Uri.http(url,unencodedPath),
      headers: header,
      body: jsonEncode(requestBody),
      ).then((response) {
        
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");
        
        if (response.statusCode == 200) {
            response_list = jsonDecode(response.body);
            //return response_list;    
          } else
            throw Exception('We were not able to successfully download the json data.');
            
            
        
    });
    



    return response_list;  
}

Future<Map<String, dynamic>> api_e_vote_app_post_request_custom(String url, String unencodedPath , Map<String, String> header,Map<String,dynamic> post_data) async { 
      
      
      final response = await http.post(
        Uri.http(url,unencodedPath),
        headers: header,
        body: jsonEncode(post_data),
      );
      print(response.statusCode);
      print(response.body);
      
      if (response.statusCode == 200) {
        Map<String, dynamic> response_list = jsonDecode(response.body);
        return response_list;    
      } else
        throw Exception('We were not able to successfully download the json data.');
        
}


Future<Map<String, dynamic>> api_e_vote_app_post_request(Map<String,dynamic> post_data) async { 

      final response = await http.post(
        Uri.http(config_URL,config_unencodedPath),
        headers: config_post_headers,
        body: jsonEncode(post_data),
      );
      print(response.statusCode);
      print(response.body);
      
      if (response.statusCode == 200) {
        Map<String, dynamic> response_list = jsonDecode(response.body);
        return response_list;    
      } else
        throw Exception('We were not able to successfully download the json data.');
        
}




Future<http.Response> api_e_vote_app_http_post_response(Map<String,dynamic> post_data) async{
    final response = await http.post(
        Uri.http(config_URL,config_unencodedPath),
        headers: config_post_headers,
        body: jsonEncode(post_data),
      );
    return response;
}


Future<http.Response> api_e_vote_app_http_get_response(String url_parameters) {
  return http.get(Uri.parse(config_URL+config_unencodedPath+url_parameters));
}



Future<int> uploadImage(String image_path)async{
  final uri = Uri.parse(config_URL+config_unencodedPath_upload_img);
  var request = http.MultipartRequest('POST',uri);
  request.fields['current_user_id'] = globals.current_user_id.toString();
  var pic = await http.MultipartFile.fromPath("image", image_path);
  request.files.add(pic);
  var response = await request.send();

  if (response.statusCode == 200) {
    print('Image Uploded');
    return 1;
  }else{
    print('Image Not Uploded');
    return 0;
  }
  
}


  



