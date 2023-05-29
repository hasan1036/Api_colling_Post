import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import 'model/post_model.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if(snapshot.hasData){

          return ListView.builder(
              itemCount: postModel.length,
              itemBuilder: (context, index){
                return Container(
                  height:  130,
                  color: Color(0xff23ff11),
                  padding:  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text('User id: ${postModel[index].userId}', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),),
                      Text('Id: ${postModel[index].id}', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),),
                      Text('Title: ${postModel[index].title}', maxLines: 1, style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),),
                      Text('Body:${postModel[index].body}', maxLines: 1, style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),),

                    ],
                  ),
                );
              });
        }

      else{
             return Center(child: CircularProgressIndicator(),);
        }



      }
    );
  }
  /*
  ===================================
  ====================================
  */
      List<PostModel>postModel = [];
      Future<List<PostModel>> getData() async{
        final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
        var data = convert.jsonDecode(response.body.toString());
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
