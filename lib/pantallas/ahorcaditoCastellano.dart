import 'dart:convert';
import 'dart:math';

import 'package:ahorcadito/colors.dart';
import 'package:ahorcadito/figura.dart';
import 'package:ahorcadito/letras.dart';
import 'package:ahorcadito/palabras.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AhorcadoCastellano extends StatefulWidget {
  const AhorcadoCastellano({Key? key}) : super(key: key);

  @override
  _AhorcadoCastellano createState() => _AhorcadoCastellano();
}

class _AhorcadoCastellano extends State<AhorcadoCastellano> {
  String palabra = "Flutter".toLowerCase();
  List<String> alfabetos = [
    "a",
    "á",
    "b",
    "c",
    "d",
    "e",
    "é",
    "f",
    "g",
    "h",
    "i",
    "í",
    "j",
    "k",
    "l",
    "m",
    "n",
    "ñ",
    "o",
    "ó",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "ú",
    "v",
    "w",
    "x",
    "y",
    "ý",
    "z"
  ];

  Future<String> seleccinarPalabra() async {
    List<Palabra> palabras = [];
    var data;

    var response = await rootBundle.loadString('bdd/palabra.json');
    var datasJson = json.decode(response);
    /*
    Future<String> loadString =
        DefaultAssetBundle.of(context).loadString("bdd/palabra.json");

    loadString.then((String value) {
      // Notifique al marco que el estado interno de este objeto ha cambiado
      //setState((){
      // Asigna parámetros a variables que almacenan clics
      data = json.decode(value);
      //});
    });
    */
    print(datasJson);
    for (var dataJson in datasJson) {
      print(Palabra.fromJson(dataJson));
      palabras.add(Palabra.fromJson(dataJson));
    }

    Random azar = new Random();
    int pos = azar.nextInt(palabras.length);
    print(palabras[pos].castellano);
    return palabras[pos].castellano;
  }

  void convertFuture() async {
    String aux = await seleccinarPalabra();
    setState(() {
      palabra = aux.toLowerCase();
    });
  }

  Widget Adivinacion() {
    if (Game.vidas < 6) {
      return Wrap(
        direction: Axis.horizontal,
        children: palabra
            .split('')
            .map((e) => letra(e.toLowerCase(),
                !Game.caracterSeleccionado.contains(e.toLowerCase())))
            .toList(),
      );
    } else {
      return Wrap(
        direction: Axis.horizontal,
        children: palabra
            .split('')
            .map((e) => letra(e.toLowerCase(), false))
            .toList(),
      );
    }
  }

  @override
  void initState() {
    convertFuture();
    Game.caracterSeleccionado = [];
    Game.vidas = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
          title: Text("Ahorcadito"),
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColor.primaryColor),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Figura del ahorcdito
            Center(
              child: Stack(
                children: [
                  //Haremos el widget de figura segun la vida
                  figuraImage(Game.vidas >= 0, "figura/hang.png"),
                  figuraImage(Game.vidas >= 1, "figura/head.png"),
                  figuraImage(Game.vidas >= 2, "figura/body.png"),
                  figuraImage(Game.vidas >= 3, "figura/ra.png"),
                  figuraImage(Game.vidas >= 4, "figura/la.png"),
                  figuraImage(Game.vidas >= 5, "figura/rl.png"),
                  figuraImage(Game.vidas >= 6, "figura/ll.png"),
                ],
              ),
            ),
            //La palabra a adiinar del juego
            Adivinacion(),
            //SizedBox(height: 12,),
            //Botones de los caracteres
            SizedBox(
              width: double.maxFinite,
              height: 250,
              child: GridView.count(
                crossAxisCount: 8,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                padding: EdgeInsets.all(8),
                children: alfabetos.map((e) {
                  return RawMaterialButton(
                    onPressed: Game.caracterSeleccionado.contains(e)
                        ? null //Se chequea si el boton fue plsado anteriormente
                        : () {
                            setState(() {
                              Game.caracterSeleccionado.add(e);
                              print(Game.caracterSeleccionado);
                              if (!palabra
                                  .split('')
                                  .contains(e.toLowerCase())) {
                                Game.vidas++;
                              }
                            });
                          },
                    child: Text(e,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    fillColor: Game.caracterSeleccionado.contains(e)
                        ? Colors.black87
                        : Colors.blue,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Game {
  static int vidas = 0;
  static List<String> caracterSeleccionado = [];
}
