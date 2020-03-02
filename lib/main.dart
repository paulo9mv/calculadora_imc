import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculadora de IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _altura = 170;
  double _peso = 70;
  String _resultado = "";
  String _imc = '0';
  Color _cor;

  //#4CAF50 verde
  //#FFEB3B amarelo
  //#F44336 vermelho
  List<Color> colors = [
    Color(0xFF4CAF50),
    Color(0xFFFFEB3B),
    Color(0xFFF44336),
  ];

  var imageAssets = {
    "feliz": "assets/feliz.png",
    "medio": "assets/medio.png",
    "triste": "assets/triste.png",
  };

  String _imagem = "assets/feliz.png";
  List<String> mensagens = [
    "Muito abaixo do peso",
    "Abaixo do peso",
    "Peso normal",
    "Acima do peso",
    "Obesidade I",
    "Obesidade II (severa)",
    "Obesidade III (mórbida)"
  ];

/*
  Muito abaixo do peso
  Abaixo do peso
  Peso normal
  Acima do peso
  Obesidade I
  Obesidade II (severa)
  Obesidade III (mórbida)
 */

  //#4CAF50 verde
  //#FFEB3B amarelo
  //#F44336 vermelho

  double calculaIMC(double altura, double peso) {
    double alturaEmMetros = altura / 100;
    return peso / (alturaEmMetros * alturaEmMetros);
  }

  void analisaIMC(altura, peso) {
    double imc = calculaIMC(altura, peso);

    String resultado;
    Color cor;
    String imagem;
    _imc = imc.toStringAsFixed(2);

    if (imc < 17) {
      resultado = mensagens[0];
      cor = colors[2];
      imagem = imageAssets["triste"];
    } else if (imc >= 17 && imc < 18.5) {
      resultado = mensagens[1];
      cor = colors[1];
      imagem = imageAssets["medio"];
    } else if (imc >= 18.5 && imc < 25) {
      resultado = mensagens[2];
      cor = colors[0];
      imagem = imageAssets["feliz"];
    } else if (imc >= 25 && imc < 30) {
      resultado = mensagens[3];
      cor = colors[1];
      imagem = imageAssets["medio"];
    } else if (imc >= 30 && imc < 35) {
      resultado = mensagens[4];
      cor = colors[2];
      imagem = imageAssets["triste"];
    } else if (imc >= 35 && imc < 40) {
      resultado = mensagens[5];
      cor = colors[2];
      imagem = imageAssets["triste"];
    } else {
      resultado = mensagens[6];
      cor = colors[2];
      imagem = imageAssets["triste"];
    }

    setState(() {
      _resultado = resultado;
      _cor = cor;
      _imagem = imagem;
    });
  }

  Widget cardInput() {
    var textStyle = new TextStyle(
      fontFamily: 'CircularStd',
      fontSize: 20,
      color: Colors.black,
    );

    var alturaWidget = new Container(
        child: new Row(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            "Altura",
            style: textStyle,
          ),
        ),
        Expanded(
          child: Slider(
            value: _altura,
            label: _altura.toInt().toString() + " cm",
            divisions: (220 - 130),
            min: 130,
            max: 220,
            onChanged: (double newValue) {
              setState(() {
                _altura = newValue;
              });
            },
            onChangeEnd: (double newValue) {
              setState(() {
                _altura = newValue;
              });
              analisaIMC(_altura, _peso);
            },
          ),
        ),
        new Padding(
          padding: EdgeInsets.only(right: 15),
          child: Text(_altura.toInt().toString() + " cm"),
        ),
      ],
    ));

    var pesoWidget = new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: new Padding(
              padding: EdgeInsets.only(left: 15, top: 15),
              child: Text(
                "Peso",
                style: textStyle,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Slider(
                  value: _peso,
                  label: _peso.toInt().toString() + " kg",
                  divisions: (170 - 40),
                  min: 40,
                  max: 170,
                  onChanged: (double newValue) {
                    setState(() {
                      _peso = newValue;
                    });
                  },
                  onChangeEnd: (double newValue) {
                    analisaIMC(_altura, _peso);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right : 15),
                child: Text(_peso.toInt().toString() + ' kg'),
              ),
            ],
          ),
        ],
      ),
    );

    return Card(
      child: Column(
        children: <Widget>[
          alturaWidget,
          pesoWidget,
        ],
      ),
    );
  }

  Widget cardOutput() {
    var textStyle = new TextStyle(
      fontFamily: 'CircularStd',
      fontSize: 20,
      color: Colors.black,
    );
    var pesoWidget = new Container(
      child: new Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Image(
              height: 100,
              width: 100,
              image: new AssetImage(_imagem),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("IMC $_imc", style: textStyle,),
              new Text(
                _resultado,
                style: textStyle,
              ),
            ],
          )
        ],
      ),
    );

    return Center(
      child: Card(
          color: _cor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[pesoWidget],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: cardInput(),
                    ),
                    Container(
                      child: cardOutput(),
                    )
                  ],
                )),
            Card(
              margin: EdgeInsets.only(top: 10),
              elevation: 10,
            )
          ],
        ),
      ),
    );
  }
}
