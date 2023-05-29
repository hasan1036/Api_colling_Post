import 'package:api_colling_provider/utils.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'model/post_model.dart';

class ApiTest extends StatefulWidget {
  const ApiTest({Key? key}) : super(key: key);

  @override
  State<ApiTest> createState() => _ApiTestState();
}

class _ApiTestState extends State<ApiTest> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getApi(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: postModel.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                        height: 130,
                        width:double.infinity,
                        color: Color(0xff0eed36),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("userId: ${postModel[index].userId}", style: appTitle,),
                            Text("Id: ${postModel[index].id}", style: appTitle,),
                            Text("Title:${postModel[index].title}",maxLines: 1, style: appTitle,),
                            Text("body: ${postModel[index].body}",maxLines: 1, style: appTitle,),
                          ],
                        ),
                      ),
                  );


                });
          }else{
            return CircularProgressIndicator();
          }

    });

  }

  List<PostModel>postModel = [];
  Future<List<PostModel>> getApi() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    final data = convert.jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map index in data){
        postModel.add(PostModel.fromJson(index));
      }
      return postModel;
    }else{
      return postModel;
    }
  }
}
