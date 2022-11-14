import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app/consts/api_consts.dart';
import 'package:news_app/consts/http_exceptions.dart';
import 'package:news_app/models/bookmarks_model.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/provider/bookmarks_provider.dart';

class NewsAPiServices{
  static Future<List<NewsModel>> getAllNews({required int page,required String sortBy})async{
// var url = Uri.parse("https://newsapi.org/v2/everything?q=bitcoin&pageSize=5&apiKey=d5bca5e9dc8f4147bffa9e6868295c92");
  try{
    var uri=Uri.https(BASEURL,"v2/everything",{
  "q" : "bitcoin",
  "pageSize" : "5",
  "domains" : "bbc.co.uk,techcrunch.com,engadget.com",
  "page" : page.toString(),
  "sortBy" : sortBy
});
var response = await http.get(uri, 
headers: {
  "X-Api-Key": API_KEY
}
);
//print('Response status: ${response.statusCode}');
//log('Response body: ${response.body}');
  Map data=jsonDecode(response.body);
  List newsTempList=[];

  if(data['code']!=null){
   // throw data['message'];
   throw HttpException(data['code']);
  }
  for(var v in data["articles"]){
    newsTempList.add(v);
    // log(v.toString());
    // print(data["articles"].length.toString());
  }
   return NewsModel.newsFromSnapshot(newsTempList);
  }
  catch(error){
    throw error.toString();
  }
  }

  static Future<List<NewsModel>> getTopHeadlines()async{
  try{
    var uri=Uri.https(BASEURL,"v2/top-headlines",{
    "country": 'us'  
});
var response = await http.get(uri, 
headers: {
  "X-Api-Key": API_KEY
}
);
//print('Response status: ${response.statusCode}');
//log('Response body: ${response.body}');
  Map data=jsonDecode(response.body);
  List newsTempList=[];

  if(data['code']!=null){
   // throw data['message'];
   throw HttpException(data['code']);
  }
  for(var v in data["articles"]){
    newsTempList.add(v);
    // log(v.toString());
    // print(data["articles"].length.toString());
  }
   return NewsModel.newsFromSnapshot(newsTempList);
  }
  catch(error){
    throw error.toString();
  }
  }

  static Future<List<NewsModel>> searchNews({required String query})async{

  try{
    var uri=Uri.https(BASEURL,"v2/everything",{
  "q" : query,
  "pageSize" : "5",
  "domains" : "bbc.co.uk,techcrunch.com,engadget.com",
});
var response = await http.get(uri, 
headers: {
  "X-Api-Key": API_KEY
}
);
//print('Response status: ${response.statusCode}');
//log('Response body: ${response.body}');
  Map data=jsonDecode(response.body);
  List newsTempList=[];

  if(data['code']!=null){
   // throw data['message'];
   throw HttpException(data['code']);
  }
  for(var v in data["articles"]){
    newsTempList.add(v);
    // log(v.toString());
    // print(data["articles"].length.toString());
  }
   return NewsModel.newsFromSnapshot(newsTempList);
  }
  catch(error){
    throw error.toString();
  }
  }

  static Future <List<BookmarksModel>?> getBookmarks() async {
    try {
      var uri = Uri.https(BASEURL_FIREBASE, "bookmarks.json");
      var response = await http.get(uri,
          );
      // log('Response status: ${response.statusCode}');
      // log('Response body: ${response.body}');
      Map data = jsonDecode(response.body);
      List allKeys = [];

      if (data['code'] != null) {
        throw HttpException(data['code']);
        // throw data['message'];
      }
      for (String key in data.keys) {
        allKeys.add(key);
      }
      log("allKeys $allKeys");
      return BookmarksModel.bookmarksFromSnapshot(json: data, allKeys: allKeys);
    }
    catch (error) {
    }
  }

}