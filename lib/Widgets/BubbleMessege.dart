import 'package:flutter/material.dart';

class BubbleMessege extends StatelessWidget {
  final messege;
  final isMe;
  final name;
  final url;
  final type;
  BubbleMessege({this.name, this.messege, this.isMe, this.url, this.type});
  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width / 2;
    return Stack(overflow: Overflow.visible, children: [
      Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Container(
              width: widthScreen,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              //   constraints: BoxConstraints(maxWidth: 170),
              decoration: BoxDecoration(
                  color: isMe ? Colors.grey[300] : Colors.cyanAccent,
                  borderRadius: BorderRadius.only(
                      topLeft: isMe ? Radius.circular(10) : Radius.circular(0),
                      topRight: isMe ? Radius.circular(0) : Radius.circular(10),
                      bottomLeft:
                          isMe ? Radius.circular(10) : Radius.circular(0))),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  FittedBox(
                    child: Text(
                      name,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  type == 0
                      ? Text(
                          messege,
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: isMe ? Colors.redAccent : Colors.purple),
                        )
                      : Container(
                          height: 100,
                          width: 170,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              messege,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ]),
      Positioned(
        top: 0,
        left: isMe ? widthScreen - 20 : null,
        right: !isMe ? widthScreen - 20 : null,
        // right: 0,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.deepPurple,
          backgroundImage: NetworkImage(url),
        ),
      ),
    ]);
  }
}
