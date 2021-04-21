import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}
class Home extends StatefulWidget{
  // aqui vamos criar o estado da aplicação
  @override
  _HomeState createState() => _HomeState();
}

// essa classe controla o estado da aplicação (State)
class _HomeState extends State<Home>{
  //configurando os nosso 
  TextEditingController alcoolContoller = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();
  String _resultado = ''; // receber o resultado 
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

// metodos para calcular combustível e resetar a aplicação 

  void _reset() {
  alcoolContoller.text = '';
  gasolinaController.text = '';
    setState(() {
    _resultado = '';
    _formkey = GlobalKey<FormState>(); //resetou o estado do form.
    });

  }

  void _calculaCombustivelIdeal(){
    setState(() {
      double varAlcool = double.parse(alcoolContoller.text.replaceAll(',', '.'));
      double varGasolina = double.parse(gasolinaController.text.replaceAll(',', '.'));

      double proporcao = varAlcool / varGasolina;

      _resultado = (proporcao < 0.7) ? 'Abasteça com Álcool' : 'Abasteça com Gasolina';
    });
  }

  // criar a interface
  @override
  Widget build(BuildContext context){ // build é o construtor da interce
    return Scaffold(
      appBar: AppBar(
        title: Text(
        'Álcool ou Gasolina?',
        style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[200],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh), 
            onPressed: (){_reset();}),
        ],
      ),
        body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
        child: Form(
          key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(Icons.local_gas_station,
            size: 150.00,
            color: Colors.lightBlue[800]
            ),

            TextFormField(
              controller: alcoolContoller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              validator: (value) => 
              value.isEmpty ? 'Informe o valor do álcool' : null,
              decoration: InputDecoration(
                labelText: 'Valor do Álcool',
                labelStyle: TextStyle(color: Colors.lightBlue[900]),
              ),
              style: TextStyle(
                color: Colors.lightBlue[900],
                fontSize: 25.00,),
            ),

            TextFormField(
              controller: gasolinaController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              validator: (value) => 
              value.isEmpty ? 'Informe o valor da gasolina' : null,
              decoration: InputDecoration(
                labelText: 'Valor da gasolina',
                labelStyle: TextStyle(color: Colors.lightBlue[900]),
              ),
              style: TextStyle(
                color: Colors.lightBlue[900],
                fontSize: 25.00,),
            ),
            Padding(padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
            child: Container(
              height: 50.0,
              child: RawMaterialButton(
                onPressed: () {
                  if(_formkey.currentState.validate())
                  _calculaCombustivelIdeal();
                },
                child: Text(
                  'Verificar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                  ),
                  fillColor: Colors.lightBlue[900]
              ),
            ),
            ),
            Text(
              _resultado,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.lightBlue[900], fontSize: 25.00),
            )
          ],
        ),
        ),
      ),
    );
  }
}