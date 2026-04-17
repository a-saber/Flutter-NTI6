
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeView(),
  ));
}


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: Icon(Icons.arrow_back, color: Colors.white,),
        title: Text('Home Screen'),
        // centerTitle: false,
        actions: [
          Icon(Icons.add),
          Icon(Icons.search),
          SizedBox(width: 10,),
          Text('Add'),
          SizedBox(width: 10,)
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Hello Flutter Flutter '),
          Icon(Icons.warning),
          Icon(Icons.warning, size: 50,),
          SizedBox(height: 100,),
          Row(
            children: [
              Text('row'),
              Icon(Icons.warning, size: 50,),

            ],
          )

        ],
      ),
    );
  }

}