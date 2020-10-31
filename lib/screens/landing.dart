import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_tree/screens/style/text_style.dart';

import 'home/home_scan.dart';
import 'utils/navigator.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> with TickerProviderStateMixin {

  TabController tabController;
  int tabIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this );
    tabController.addListener(() {
      setState(() {
        tabIndex = tabController.index;
      });
    });
    super.initState();
  }

  Widget secondTab(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            '¡Con solo una foto te informas y ayudas a la comunidad!',
            style: getTextStyle(true, 40, 'b', Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        Image.asset(
          'assets/screens/land2.png',
          height: 250,
        ),
        Text(
          '¡Empecemos!',
          style: getTextStyle(false, 29, 'b', Colors.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget firstTab(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            '¿Necesitas conocer que arbol te está brindando la naturaleza?',
            style: getTextStyle(true, 40, 'b', Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        Align(
          alignment: Alignment(1, 0),
          child: Image.asset(
            'assets/screens/land1.png'
          ),
        ),
      ],
    );
  }

  Widget tabView(){
    return DefaultTabController(
      length: 2,
      child: TabBarView(
        controller: tabController,
        children: [
          firstTab(),
          secondTab()
        ],
      ),

    );
  }

  Widget navButtoms(){
    return Row(
      children: [
        tabIndex == 1 ?
          Expanded(
            child: InkWell(
              onTap: () => tabController.animateTo(0),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  '< Anterior',
                  style: getTextStyle(false, 18, 'r', Colors.black),
                ),
              ),
            ),
          ):
          Expanded(child: Center(),),
        tabIndex == 0 ? 
          InkWell(
            onTap: () => tabController.animateTo(1),
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                'Siguiente >',
                style: getTextStyle(false, 18, 'r', Colors.black),
              ),
            ),
          ):
          InkWell(
            onTap: () => navigateTo( TakePictureScreen(), context ),
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                '¡Vamos! >',
                style: getTextStyle(false, 18, 'r', Colors.black),
              ),
            ),
          )
      ],
    );
  }

  Widget tabIndicator(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: tabIndex == 0 ? Colors.black : Color(0xFFC4C4C4)
            ),
          ),
          Container(
            width: 10,
            height: 10,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: tabIndex == 1 ? Colors.black : Color(0xFFC4C4C4)
            ),
          )
        ],
      ),
    );
  }

  Widget body(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: SvgPicture.asset(
            'assets/screens/nuves.svg'
          ),
        ),
        Expanded(
          child: tabView()
        ),
        tabIndicator(),
        navButtoms(),
        SvgPicture.asset(
          'assets/screens/base-montanas.svg',
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
      backgroundColor: Color(0xFFE2EAE4),
    );
  }
}