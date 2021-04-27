import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojavirtualapp/models/cart_manager.dart';
import 'package:provider/provider.dart';
class CepInputField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    final TextEditingController cepController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextFormField(
          controller: cepController,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'CEP',
            hintText: '74.961-120'
          ),
          inputFormatters: [
            WhitelistingTextInputFormatter.digitsOnly,
            CepInputFormatter(),
          ],
          keyboardType: TextInputType.number,
          validator: (cep){
            if(cep.isEmpty)
              return'Campo obrigatório';
            else if(cep.length != 10)
              return 'CEP Inválido';
            return null;
          },

        ),
        RaisedButton(
          onPressed: (){
            if(Form.of(context).validate()){
              context.read<CartManager>().getAddress(cepController.text);

            }

          },
          textColor: Colors.white,
          color: primaryColor,
          disabledColor: primaryColor.withAlpha(100),
          child: const Text('Buscar CEP'),
        ),
      ],
    );
  }
}
