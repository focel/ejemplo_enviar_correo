import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  launchMailto() async {
    final mailtoLink = Mailto(
      to: [
        'jalarcon@mavesa.com.ec',
        'pchalem@qualityseguros.com.ec',
        'copy@gestionpublicidad.com',
      ],
      subject: 'Formulario enviado',
      body: 'Nombres y Apellidos: ${_fbKey.currentState!.value['nombre_apellido']}\nCédula o Pasaporte: ${_fbKey.currentState!.value['cedula_pasaporte']}\nEmail: ${_fbKey.currentState!.value['email']}\nNúmero Celular: ${_fbKey.currentState!.value['numero_celular']}\nCiudad: ${_fbKey.currentState!.value['ciudad']}',
    );
    await launch('$mailtoLink');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _fbKey,
          child: Column(
            children: <Widget>[
              FormBuilderTextField(
                name: 'nombre_apellido',
                decoration: InputDecoration(
                  labelText: 'Nombres y Apellidos',
                ),
              ),
              FormBuilderTextField(
                name: 'cedula_pasaporte',
                decoration: InputDecoration(
                  labelText: 'Cédula o Pasaporte',
                ),
              ),
              FormBuilderTextField(
                name: 'email',
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              FormBuilderTextField(
                name: 'numero_celular',
                decoration: InputDecoration(
                  labelText: 'Número Celular',
                ),
              ),
              FormBuilderTextField(
                name: 'ciudad',
                decoration: InputDecoration(
                  labelText: 'Ciudad',
                ),
              ),
              SizedBox(height: 20),
              MaterialButton(
                child: Text('Enviar'),
                onPressed: () {
                  if (_fbKey.currentState!.saveAndValidate()) {
                    print('result: ${_fbKey.currentState!.value}');
                    launchMailto();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
