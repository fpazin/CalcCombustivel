import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora do Combustível',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controllerGasolina = TextEditingController();
  final TextEditingController _controllerAlcool = TextEditingController();
  String gasolina = '';
  String alcool = '';

  double _calcularIMC(int altura, double peso) {
    double alturaCorrigida = altura / 100.0;
    return peso / (alturaCorrigida * alturaCorrigida);
  }

  double _calcularCombustivel(double gasolina, double alcool){
    double resultadoCombustivel = alcool / gasolina;
    return resultadoCombustivel;
  }

  _buildResultado1(BuildContext context) {
    if (gasolina != '' && alcool != '') {
      double indicacao = _calcularCombustivel(double.parse(gasolina), double.parse(alcool));
      String classificacao = '';
      if (indicacao < 0.7) {
        classificacao = 'Abastecer alcool';
      } else {
        classificacao = 'Abastecer gasolina';
      }
      return Column(
        children: [
          Text('O índice é ', style: Theme.of(context).textTheme.headline6),

          Text(
            indicacao.toStringAsFixed(1),
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(classificacao, style: Theme.of(context).textTheme.headline4)
        ],
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'Para calcular qual combustível compensa é necessário '
                'fornecer o valor da gasolina e álcool',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora do Combustível'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child:
                  Text('Forneça sos valores dos combustíveis'),
                ),
              ),
              TextField(
                controller: _controllerGasolina,
                decoration: const InputDecoration(
                  icon: Icon(Icons.local_gas_station),
                  hintText: 'Gasolina',
                  helperText: 'Exemplo: 5.99',
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: _controllerAlcool,
                decoration: const InputDecoration(
                  icon: Icon(Icons.local_gas_station),
                  hintText: 'Álcool',
                  helperText: 'Exemplo: 5.99',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    gasolina = _controllerGasolina.text;
                    alcool = _controllerAlcool.text;
                  });
                },
                child: const Text('CALCULAR'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              _buildResultado1(context),
            ],
          ),
        ),
      ),
    );
  }
}
