
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Center(
            child: Text(
              'Hello ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w900,
                // backgroundColor: Colors.grey,
                // decoration: TextDecoration.lineThrough,
                // decorationColor: Colors.white,
                // decorationThickness: 2,
                // decorationStyle: TextDecorationStyle.dotted,
                // overflow: TextOverflow.fade,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 50,
                    offset: Offset(0, 0)
                  )
                ]

              ),

              textAlign: TextAlign.end,
              maxLines: 2,
            ),
          ),

          // Center(
          //   child: Container(
          //     height: 200,
          //     width: 200,
          //     decoration: BoxDecoration(
          //       color: Colors.grey,
          //       // borderRadius: BorderRadius.circular(20),
          //       border: Border.all(
          //         color: Colors.black,
          //         width: 5
          //       ),
          //       shape: BoxShape.circle,
          //       gradient: LinearGradient(
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         colors: [
          //           Colors.black,
          //           Colors.black,
          //           Colors.white,
          //
          //         ]
          //       ),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.blue,
          //           blurRadius: 50,
          //           spreadRadius: 15,
          //           offset: Offset(10, 0)
          //         ),
          //         BoxShadow(
          //           color: Colors.green,
          //           blurRadius: 50,
          //           spreadRadius: 15,
          //           offset: Offset(-10, 0)
          //         ),
          //
          //       ]
          //       // shape: BoxShape.circle
          //     )
          //   ),
          // ),


        ],
      ),
    );
  }

}

// rectangle
// color white
// border grey
// border radius 20
// shadow black
// gradient [blue, green]
//
//
// Circle
// color grey
// border black
// shadow grey
// gradient [blue, green]

