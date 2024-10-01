import 'package:flutter/material.dart';

void main() {
  runApp(IMCCalculator());
}
// gerenciamento de estato do widget
class IMCCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: IMCHomePage(),
    );
  }
}

class IMCHomePage extends StatefulWidget {
  @override
  _IMCHomePageState createState() => _IMCHomePageState();
}

class _IMCHomePageState extends State<IMCHomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  String _resultado = '';

  void _calcularIMC() {
    if (_formKey.currentState!.validate()) {
      double peso = double.parse(_pesoController.text);
      double altura = double.parse(_alturaController.text) / 100; // Convertendo para metros
      double imc = peso / (altura * altura);
      setState(() {
        _resultado = 'Seu IMC é: ${imc.toStringAsFixed(2)}';
      });
      //reconstrói a interface do usuário com o novo
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Calcule seu IMC',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                SizedBox(height: 20),
                _buildTextField('Peso (kg)', _pesoController),
                SizedBox(height: 16),
                _buildTextField('Altura (cm)', _alturaController),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _calcularIMC,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal, // Cor do botão
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Bordas arredondadas
                    ),
                  ),
                  child: Text('Calcular IMC', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 20),
                Text(
                  _resultado,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.teal, width: 2),
        ),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira seu $label';
        }
        return null;
      },
    );
  }
}
