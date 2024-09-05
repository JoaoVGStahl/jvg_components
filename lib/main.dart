import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jvg_components/autocomplete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> principaisCidadesDoBrasil = [
    'Ananindeua',
    'Aparecida de Goiânia',
    'Aracaju',
    'Belém',
    'Belo Horizonte',
    'Brasília',
    'Campinas',
    'Campo Grande',
    'Caxias do Sul',
    'Contagem',
    'Cuiabá',
    'Curitiba',
    'Duque de Caxias',
    'Feira de Santana',
    'Florianópolis',
    'Fortaleza',
    'Goiânia',
    'Guarulhos',
    'João Pessoa',
    'Joinville',
    'Jaboatão dos Guararapes',
    'Londrina',
    'Macapá',
    'Maceió',
    'Manaus',
    'Mauá',
    'Mogi das Cruzes',
    'Natal',
    'Niterói',
    'Nova Iguaçu',
    'Osasco',
    'Porto Alegre',
    'Porto Velho',
    'Recife',
    'Ribeirão Preto',
    'Rio de Janeiro',
    'Salvador',
    'São Bernardo do Campo',
    'São Gonçalo',
    'São João de Meriti',
    'São José dos Campos',
    'São Luís',
    'São Paulo',
    'Serra',
    'Sorocaba',
    'Santo André',
    'Teresina',
    'Uberlândia',
    'Vila Velha'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAutocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) async {
                if (textEditingValue.text.isEmpty) {
                  return principaisCidadesDoBrasil;
                }
                return await _obterCidades(textEditingValue.text);
              },
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: Container(
                      width: 400,
                      constraints: const BoxConstraints(maxHeight: 250),
                      child: options.isNotEmpty
                          ? ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: options.length,
                              itemBuilder: (BuildContext context, int index) {
                                final String option = options.elementAt(index);
                                return InkWell(
                                  onTap: () {
                                    onSelected(option);
                                  },
                                  child:
                                      Builder(builder: (BuildContext context) {
                                    final bool highlight =
                                        AutocompleteHighlightedOption.of(
                                                context) ==
                                            index;
                                    if (highlight) {
                                      SchedulerBinding.instance
                                          .addPostFrameCallback(
                                              (Duration timeStamp) {
                                        Scrollable.ensureVisible(context,
                                            alignment: 0.5);
                                      });
                                    }
                                    return Container(
                                      color: highlight
                                          ? Theme.of(context).focusColor
                                          : null,
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(option),
                                    );
                                  }),
                                );
                              },
                            )
                          : Container(
                              padding: const EdgeInsets.all(16.0),
                              child: const Text("Nenhum item encontrado..."),
                            ),
                    ),
                  ),
                );
              },
              fieldViewBuilder: (context, ctrl, focus, function) {
                return TextFormField(
                  style: const TextStyle(fontSize: 16),
                  expands: false,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    counterText: "",
                    isDense: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                    ),
                    suffixIconConstraints: BoxConstraints(maxHeight: 35),
                    contentPadding:
                        EdgeInsets.only(left: 5, top: 12, bottom: 12, right: 0),
                    fillColor: Colors.white,
                    filled: true,
                    hoverColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(177, 177, 177, 1), width: 10),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(177, 177, 177, 1)),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(177, 177, 177, 1)),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  keyboardType: TextInputType.text,
                  controller: ctrl,
                  focusNode: focus,
                  onFieldSubmitted: (value) => function.call(),
                );
              },
              loadingViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: Container(
                      width: 400,
                      constraints: const BoxConstraints(maxHeight: 250),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: const Text("Carregando..."),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 500,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "$i - Produto número $i",
                                style: const TextStyle(fontSize: 18),
                              ),
                              subtitle: Row(
                                children: [
                                  const Row(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          "Preço venda: R\$ 100,00",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                      "Estoque: ${i * 10} KG",
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    width: 200,
                                    child: Text(
                                      "Custo: R\$ 100,00",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<String>> _obterCidades(String pattern) async {
    await Future.delayed(const Duration(seconds: 1));

    return principaisCidadesDoBrasil
        .where((c) => c.toLowerCase().startsWith(pattern.toLowerCase()))
        .toList();
  }
}
