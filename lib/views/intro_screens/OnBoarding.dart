import 'package:better_self/model/myColors.dart';
import 'package:better_self/model/onboard_model.dart';
import 'package:better_self/views/intro_screens/intro_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  int currentIndex = 0;
  late PageController _pageController;


  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnBoardInfo() async{
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mc_vanilya,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            child: Text("Skip",style: TextStyle(color: Colors.lightBlueAccent),),
            onPressed: () async {
              await _storeOnBoardInfo();
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> IntroName()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child:PageView.builder(
          itemCount: screens.length,
          controller: _pageController,
          onPageChanged:(int index){
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context,index){
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height:300,
                    child: Image.asset(screens[index].image!)),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 4,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.brown,
                    dotColor: MyColors.mc_sienna,
                    dotHeight: 12,
                    dotWidth: 12,
                  ),
                ),
                Text(screens[index].text!,style: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                  color: MyColors.mc_peru,
                  fontFamily: 'NotoSerif'
                ),
                textAlign: TextAlign.center),
                InkWell(
                  onTap: () async{
                    if(index == screens.length-1){
                      await _storeOnBoardInfo();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>IntroName()));
                    }
                    _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.bounceIn );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
                    decoration: BoxDecoration(
                      color: MyColors.mc_sienna,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Next",style: TextStyle(fontSize: 16.0,color: Colors.white),),
                        SizedBox(width: 15.0,),
                        Icon(Icons.arrow_forward_sharp,color: Colors.white,),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
