import 'dart:ui';

import 'package:better_self/model/myColors.dart';
import 'package:better_self/views/profil/Profil.dart';
import 'package:better_self/views/anasayfa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CurvedNavigationBar extends StatefulWidget {
  const CurvedNavigationBar({super.key});

  @override
  State<CurvedNavigationBar> createState() => _CurvedNavigationBarState();
}

class _CurvedNavigationBarState extends State<CurvedNavigationBar> {

  var sayfaListesi = [Anasayfa(),Profil()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sayfaListesi[_currentIndex],
      bottomNavigationBar:GNav(
        backgroundColor: MyColors.mc_pureWhite,
        haptic: true, // haptic feedback
        curve: Curves.decelerate, // tab animation curves
        duration: Duration(milliseconds: 300), // tab animation duration
        gap: 8, // the tab button gap between icon and text
        color: MyColors.mc_silverChalice, // unselected icon color
        activeColor: MyColors.mc_copperRed, // selected icon and text color
        iconSize: 24, // tab button icon size
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5), // navigation bar padding
        onTabChange: (index){
          setState(() {
            _currentIndex= index;
          });
        },
        tabs: [
          GButton(
            icon: Icons.home,
            text: "Anasayfa",
          ),
          GButton(
            icon: Icons.person,
            text: "Profil",
          ),
        ],
      ) ,
    );
  }
}


