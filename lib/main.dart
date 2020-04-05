import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controladoraPeso = new TextEditingController();
  TextEditingController controladoraAltura = new TextEditingController();

  GlobalKey<FormState> _form = new GlobalKey<FormState>();

  String _infoText = "Informe seus dados !";

  void _resetarCampos() {
    controladoraPeso.text = "";
    controladoraAltura.text = "";
    setState(() {
      _infoText = "Informe seus dados !";
      _form = GlobalKey<FormState>();
    });
  }

  void _calcular() {
    setState(() {
      double peso = double.parse(controladoraPeso.text);
      double altura = double.parse(controladoraAltura.text) / 100;

      double imc = peso / (altura * altura);

      if (imc < 18.6) {
        _infoText = "Abaixo do peso(${imc.toStringAsPrecision(3)}) ";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal(${imc.toStringAsPrecision(3)}) ";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levente acima do peso(${imc.toStringAsPrecision(3)}) ";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade grau I(${imc.toStringAsPrecision(3)}) ";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade grau II(${imc.toStringAsPrecision(3)}) ";
      } else if (imc > 40.0) {
        _infoText = "Obesidade grau III(${imc.toStringAsPrecision(3)}) ";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetarCampos,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: controladoraPeso,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu peso";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: controladoraAltura,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu altura";
                    }
                  }
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if(_form.currentState.validate()){
                         _calcular();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
