import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtest/theme.dart';
import 'package:newtest/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';

import '../../../routes/app_pages.dart';

class HomeView2 extends StatelessWidget {
  const HomeView2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _AppBar(), body: _FormHome());
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(140);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: preferredSize,
        child: Container(
          decoration: BoxDecoration(
              color: bgRed,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              50.heightBox,
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  suffixIcon: Icon(
                    Remix.search_2_line,
                    color: bgRed,
                  ),
                  fillColor: Colors.grey[200],
                  hintText: 'Enter text here ...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class _FormHome extends StatelessWidget {
  const _FormHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          20.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               _HomeButton(imagePath:    'assets/img/gate.png', tittle:  'Event', fuction: () {
                
                  Get.toNamed(Routes.EVENT_LIST);
               }),
                 _HomeButton(imagePath:  'assets/img/costume.png', tittle:  'Cosplay', fuction: () {
                  Get.toNamed(Routes.COSTUME_RENT);
                
              },),
                _HomeButton(imagePath: 'assets/img/comunt.png', tittle:  'Commun', fuction: () {
                
              },)
                     ],
          ),
        ],
      ),
    );
  }
}

class _HomeButton extends StatelessWidget {
  const _HomeButton({super.key, required this.imagePath, required this.tittle, required this.fuction});
  final String imagePath;
  final String tittle;
  final VoidCallback fuction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fuction,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Card(
          elevation: 2,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(300)),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            height: 115,
            width: 70,
            child: Column(
              children: [
                Image.asset(
                 imagePath,
                  height: 72,
                  width: 72,
                  fit: BoxFit.contain,
                ),
                Expanded(
                  child: Text(
                   tittle,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: generalBody),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
