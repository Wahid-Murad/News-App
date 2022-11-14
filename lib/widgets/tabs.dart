import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TabsWidget extends StatelessWidget {
  const TabsWidget({super.key, required this.text, required this.color, required this.function, required this.fontSize});
  final String text;
  final Color color;
  final Function function;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
                    onTap: (){
                      function();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: color,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(text,style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.w500),),
                      )
                      ),
                  );
  }
}