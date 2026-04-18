
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
        children: [
          Text('Users: 10'),
          SizedBox(height: 20,),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Icon(Icons.person, size: 50,),
              itemCount: 10,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => UserContainer(),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }

}

class UserContainer extends StatelessWidget {
  const UserContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          right: 20,
          left: 10
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 10,
                spreadRadius: 1
            )
          ]

      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey
            ),
            child: Icon(Icons.person),
          ),

          SizedBox(width: 20,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Text('Welcome',style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold
              ),),
              Text('Ahmed saber',style: TextStyle(
                  fontSize: 20
              ),),

            ],
          )

        ],
      ),
    );
  }
}































