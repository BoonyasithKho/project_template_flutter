import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project_template_flutter/utils/my_constant.dart';
import 'package:project_template_flutter/widgets/show_image.dart';

import '../widgets/show_title.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShowTitle(
          title: 'First Screen',
          textStyle: Theme.of(context).textTheme.displayLarge,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  print('Your Name');
                },
                child: Container(
                  color: Colors.yellow,
                  width: 200,
                  height: 200,
                  child: Center(
                    child: Text('Your Name'),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                child: ShowImage(path: MyConstant.image1),
              ),
              Container(
                width: 100,
                height: 100,
                child: ShowImage(path: MyConstant.image2),
              ),
              Container(
                width: 100,
                height: 100,
                child: ShowImage(path: MyConstant.image3),
              ),
              Container(
                width: 100,
                height: 100,
                child: ShowImage(path: MyConstant.image4),
              ),
            ],
          )
        ],
      ),
    );
  }
}
