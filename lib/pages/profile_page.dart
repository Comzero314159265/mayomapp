import 'package:flutter/material.dart';
import 'package:mayom_app/utils/spider-chart.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {  
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Me"),
        elevation: 0.0,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
                icon: Icon(Icons.notifications),
                tooltip: 'Notifications',
                onPressed: () {
                  print("Click!!");
                },
              ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          _buildCoverImage(screenSize),
          _buildContent()
        ],
      )
    );
  }

  Widget _buildContent(){
    return Center(
      child: Container(
        width: 200,
        height: 200,
        child: SpiderChart(
          data: [
            7,
            5,
            10,
            7,
            4,
            8,
            4,
          ],
          maxValue: 10,
          colors: <Color>[
            Colors.blue,
            Colors.blue,
            Colors.blue,
            Colors.blue,
            Colors.blue,
            Colors.blue,
            Colors.blue,
          ],
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.w700
    );
    return Text(
      "John Doe",
      style: _nameTextStyle,
    );
  }

  Widget _buildCoverImage(Size screenSize) {
    return Stack(
      children: <Widget>[
        Container(
          height: screenSize.height / 5.0,
          decoration: BoxDecoration(color: Colors.blue),
        ),
        Container(
          padding: EdgeInsets.only(left: 5.0, right: 5.0),
          child: Row(
            children: <Widget>[
              _buildProfileImage(),
              SizedBox(width: 5.0,),
              Column(
                children: <Widget>[
                  _buildFullName(),
                  _buildFullName()
                ],
              )
            ],
          ) ,
        )

      ],
    );
  }

  Widget _buildProfileImage () {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/profile.jpg'),
            fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.circular(80.0),
          // border: Border.all(
          //   color: Colors.white,
          //   width: 2.0,
          // )
        ),
      ),
    );
  }
}