import 'package:better_self/model/myColors.dart';
import 'package:better_self/views/anasayfa.dart';
import 'package:better_self/views/intro_screens/logo_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroName2 extends StatefulWidget {

  @override
  State<IntroName2> createState() => _IntroName2State();

}

class _IntroName2State extends State<IntroName2> with TickerProviderStateMixin {

  String? name;

  Future<void> veriOkuma() async{
    var sp = await SharedPreferences.getInstance();
    setState(() {
      name = sp.getString("isim") ?? "kullanıcı adı yok";
    });
  }

  late AnimationController _animationController;
  late AnimationController _animationController2;
  late AnimationController _animationController3;
  late AnimationController _animationController4;

  late Animation<double> _alphaAnimationValues;
  late Animation<double> _alphaAnimationValues2;
  late Animation<double> _alphaAnimationValues3;
  late Animation<double> _alphaAnimationValues4;

  void initState() {
    super.initState();
    veriOkuma();
    _animationController = AnimationController(duration: Duration(milliseconds: 1500), vsync:this );
    _alphaAnimationValues = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController2 = AnimationController(duration: Duration(milliseconds: 1000), vsync:this );
    _alphaAnimationValues2 = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController2)
      ..addListener(() {
        setState(() {});
      });
    _animationController3 = AnimationController(duration: Duration(milliseconds: 1500), vsync:this );
    _alphaAnimationValues3 = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController3)
      ..addListener(() {
        setState(() {});
      });
    _animationController4 = AnimationController(duration: Duration(milliseconds: 1500), vsync:this );
    _alphaAnimationValues4 = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController4)
      ..addListener(() {
        setState(() {});
      });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController2.forward();
      }
    });
    _animationController2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController3.forward();
      }
    });
    _animationController3.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController4.forward();
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _animationController2.dispose();
    _animationController3.dispose();
    _animationController4.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: MyColors.mc_pureWhite,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FadeTransition(
                  opacity: _alphaAnimationValues,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Tanıştığımıza memnun oldum $name",
                      style: TextStyle(fontFamily: 'NotoSerif',fontSize: 25,color: MyColors.mc_cadetGrey),
                      textAlign: TextAlign.center,),
                  ),
                ),
              ),
              SizedBox(
                width:250,
                child: FadeTransition(
                  opacity: _alphaAnimationValues2,
                  child: Image.asset("images/intro_name2.png"))),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FadeTransition(
                  opacity: _alphaAnimationValues3,
                  child: Text("Kendinin en iyi versiyonu olmaya hazır mısın?",
                    style: TextStyle(fontFamily: 'NotoSerif',fontSize: 25,color: MyColors.mc_cadetGrey),
                    textAlign: TextAlign.center,),
                ),
              ),
              FadeTransition(
                opacity: _alphaAnimationValues4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.mc_cadetGrey
                  ),
                  child: Text("Hadi Başlayalım",style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> LogoScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
