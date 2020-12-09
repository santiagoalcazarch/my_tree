import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_tree/screens/style/text_style.dart';
import 'package:my_tree/services/images.dart';

class ScanResults extends StatefulWidget {

  final String imagePath;
  final String normalName = "Planta";

  const ScanResults({Key key, this.imagePath}) : super(key: key);

  @override
  _ScanResultsState createState() => _ScanResultsState();
}

class _ScanResultsState extends State<ScanResults> {

  int similitude;
  String scientificName;
  List<String> images;
  bool initLoading;

  Future<void> getImages() async {
    final responseMap = await ImageServices.sendImage( widget.imagePath );
    setState(() {
      this.images = List.from( responseMap["images"] );
      this.scientificName = responseMap["imageName"];
      this.similitude = responseMap["similitude"];
      this.initLoading = false;
    });
    return;
  }

  Widget appBar(){
    return Column(
      children: [
        Container(
          height: 155,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage( 
                    image: FileImage(File(widget.imagePath)), 
                    fit: BoxFit.cover, 
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, 99), BlendMode.darken) 
                  )
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      margin: EdgeInsets.only(left: 11),
                      width: 52,
                      height: 52,
                      alignment: Alignment(-1, 0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Align(
                        alignment: Alignment(0.3,0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFF388125),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment(0,0),
                    child: Text(
                      widget.normalName,
                      style: getTextStyle(false, 36, 'l', Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Color(0xFF6A8164),
          padding: EdgeInsets.symmetric( vertical: 6 ),
          child: Text(
            this.scientificName,
            textAlign: TextAlign.center,
            style: getTextStyle(false, 18, 'l', Colors.white),
          ),
        )
      ],
    );
  }

  Widget similarPictures(){
    return Column(
      children: [
        Container(
          alignment: Alignment(-1, 0),
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment(-1, 0),
              image: AssetImage('assets/screens/fotos-select.png'),
              scale: 1.1
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 0, 15),
            child: Text(
              "Fotos",
              style: getTextStyle(true, 30, 'b', Colors.white),
            ),
          ),
        ),
        Container(
          height: 100,
          margin: EdgeInsets.only(left: 15),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: this.images.map(
              ( stringImg ){
                //final bytesImage = Base64Decoder().convert(stringImg);
                Uint8List _bytes = base64.decode(stringImg.split(',').last);

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.memory( _bytes ),
                  ),
                );
              }
            ).toList(),
          ),
        )
      ],
    );
  }

  Widget mainInfo(){
    return Stack(
      fit: StackFit.expand,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: SvgPicture.asset(
            "assets/screens/base_tres.svg",
            fit: BoxFit.cover,
          ),
        ),
        ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric( horizontal: 21, vertical: 21 ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
                boxShadow: [ BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 9, offset: Offset(2, 2) ) ]
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 5),
                    child: Text(
                      "La foto que has compartidotiene una similitud del",
                      style: getTextStyle(false, 14, 'l', Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    this.similitude.toString() + "%",
                    style: getTextStyle(false, 36, 'b', Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.only( bottom: 20, top: 5 ),
                    child: Text(
                      "Con el arbol de Guadua, según nuestro\nprocesamiento y la base de datos ",
                      style: getTextStyle(false, 14, 'l', Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            similarPictures()
          ],
        ),
      ],
    );
  }
  
  Widget body(){
    return Column(
      children: [
        appBar(),
        initLoading ? 
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                "Realizando la consulta...",
                style: getTextStyle(false, 14, 'l', Colors.black),
              ),
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation( Color(0xFF6A8164) ),
            )
          ],
        ):
        Expanded(
          child: mainInfo()
        )
      ],
    );
  }

  @override
  void initState() {
    this.initLoading = true;
    this.scientificName = "";
    getImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        body: body(),
      ),
    );
  }
}