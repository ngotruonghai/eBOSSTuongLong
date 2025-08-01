import 'package:flutter/material.dart';

class UserinfoListTileComponent extends StatefulWidget  {

  final double screenWidth;
  final String icon;
  final String text;
  final String subText;
  final List<String> data;
  final bool containSubtext;

  const UserinfoListTileComponent({
    required this.screenWidth,
    required this.icon,
    required this.text,
    required this.subText,
    required this.data,
    required this.containSubtext,
    super.key
  });

  @override
  State<UserinfoListTileComponent> createState() => _UserinfoListTileComponent();
}

class _UserinfoListTileComponent extends State<UserinfoListTileComponent> with SingleTickerProviderStateMixin {

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero, 
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(left: widget.screenWidth * 0.04),
                    child: Image.asset(
                    widget.icon,
                    width: widget.screenWidth * 0.05, 
                    height: widget.screenWidth * 0.05,
                  )
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: widget.screenWidth * 0.04),
                        child: Text(
                          widget.text,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, 
                          ),
                          textAlign: TextAlign.left,
                        )
                      )
                    ),
                    if (widget.containSubtext == true)
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: widget.screenWidth * 0.04),
                          child: Text(
                            widget.subText,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 80, 80, 80),
                            ),
                          ),
                        )
                      ),                 
                  ],
                )
              ),
            ],
          ),
          // trailing: Icon(
          //   !isExpanded ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_down,
          // ),
          // onTap: () {
          //   setState(() {
          //     isExpanded = !isExpanded;
          //   });
          // },
        ),
        if (isExpanded) 
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(left: widget.screenWidth * 0.04),
                  child: SizedBox(
                    width: widget.screenWidth * 0.05, 
                    height: widget.screenWidth * 0.05, 
                  )
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: widget.screenWidth * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "dsd",
                            style: TextStyle(
                              color: Colors.black
                            ),
                            textAlign: TextAlign.left,
                          )
                        ]
                      ),
                    ), 
                  ],
                ),
              )
            ]
          )
      ]
    );   
  }
}
