import 'package:exercicio_app/contacto.dart';
import 'package:flutter/material.dart';

class ContactoHome extends StatefulWidget {
  const ContactoHome({super.key});

  @override
  State<ContactoHome> createState() => _ContactoHomeState();
}

class _ContactoHomeState extends State<ContactoHome> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();

  List<Contacto> Contactos = List.empty(growable: true);

  int SelectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('Lista de Contactos')),
        body: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                  hintText: 'Nome',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: numeroController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                  hintText: 'Numero',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            SizedBox(height: 10),
            TextField(
              controller: enderecoController,
              decoration: InputDecoration(
                  hintText: 'Endereco',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //botao para adicionar
                ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () {
                    //metodo para gravar os contactos recebendo os dados dos textfield
                    String nome = nomeController.text
                        .trim(); //remove qualquer espaçamento numa string
                    String numero = numeroController.text.trim();
                    String endereco = enderecoController.text.trim();
                    if (nome.isNotEmpty &&
                        numero.isNotEmpty &&
                        endereco.isNotEmpty) {
                      setState(() {
                        Contactos.add(new Contacto(nome, numero, endereco));
                      });
                    }
//para limpar os campos apos insercao
                    nomeController.text = '';
                    numeroController.text = '';
                    enderecoController.text = '';
                  },
                ),
                //
                //botao para actualizar
                ElevatedButton(
                  child: Text('Update'),
                  onPressed: () {
                    String nome = nomeController.text.trim();
                    String numero = numeroController.text.trim();
                    String endereco = enderecoController.text.trim();
                    if (nome.isNotEmpty &&
                        numero.isNotEmpty &&
                        endereco.isNotEmpty) {
                      setState(() {
                        //limpa os textfield e depois faz a insercao
                        nomeController.text = '';
                        numeroController.text = '';
                        enderecoController.text = '';
                        Contactos[SelectedIndex].nome = nome;
                        Contactos[SelectedIndex].numero = numero;
                        Contactos[SelectedIndex].endereco = endereco;
                        SelectedIndex = -1;
                      });
                    }
                  },
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Contactos.isEmpty
                ? const Text(
                    'Nenhum contacto gravado...',
                    style: TextStyle(fontSize: 22),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: Contactos.length,
                        itemBuilder: ((context, index) => getRow(index))))
          ], //para preencher os dados no card com base no numero de elementos na lista
          //
        ));
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
          //Campo do circulo com 1a letra do contacto
          leading: CircleAvatar(
            backgroundColor: index % 2 == 0
                ? Colors.lightBlue
                : Color.fromARGB(255, 109, 203, 2),
            foregroundColor: Colors.white,
            child: Text(Contactos[index].nome[0],
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          //
          //Campo dos dados dos contactos
          title: Column(
            crossAxisAlignment: CrossAxisAlignment
                .start, //start - faz o alinhamento do texto na esquerda
            children: [
              Text(
                Contactos[index].nome,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(Contactos[index].numero),
              Text(Contactos[index].endereco),
            ],
          ),
          //
          //campo dos icons
          trailing: SizedBox(
            width: 70,
            child: Row(
              children: [
                //
                //metodo do icon para update
                InkWell(
                  child: const Icon(Icons.edit),
                  onTap: () {
                    //
                    nomeController.text = Contactos[index].nome;
                    numeroController.text = Contactos[index].numero;
                    enderecoController.text = Contactos[index].endereco;
                    setState(() {
                      SelectedIndex = index; //recebe o index
                    });
                    //
                  },
                ),
                //
                //metodo do icon para Delete
                InkWell(
                  child: const Icon(Icons.delete),
                  onTap: () {
                    //
                    setState(() {
                      Contactos.removeAt(index);
                    });
                  },
                ),
              ],
            ),
          )),
    );
  }
}
