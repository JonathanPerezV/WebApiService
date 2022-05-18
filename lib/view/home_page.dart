// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:web_api_revista/controller/web_api_service.dart';
import 'package:web_api_revista/model/revista_model.dart';
import 'package:web_api_revista/view/components/alertas.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WebApiService was = WebApiService();
  RevistaModel? revista;

  final formKey = GlobalKey<FormState>();
  final key = GlobalKey<ScaffoldState>();

  final controllerIdRevista = TextEditingController();
  final controllerTipo = TextEditingController();
  final controllerTitulo = TextEditingController();
  final controllerPeriodicidad = TextEditingController();

  bool visibilitySearchId = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: key,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Operaciones CRUD'),
          centerTitle: true,
          actions: [
            PopupMenuButton<int>(onSelected: (value) {
              switch (value) {
                case 0:
                  initComponets();
                  break;
                case 1:
                  functionInsert();
                  break;
                case 2:
                  functionUpdate();
                  break;
                case 3:
                  functionDelete();
                  break;
                default:
              }
            }, itemBuilder: (itemBuilder) {
              final list = <PopupMenuEntry<int>>[];
              list.add(const PopupMenuItem(value: 0, child: Text('Nuevo')));
              list.add(const PopupMenuDivider());
              list.add(const PopupMenuItem(value: 1, child: Text('Insertar')));
              list.add(const PopupMenuDivider());
              list.add(
                  const PopupMenuItem(value: 2, child: Text('Actualizar')));
              list.add(const PopupMenuDivider());
              list.add(const PopupMenuItem(value: 3, child: Text('Eliminar')));
              return list;
            })
          ],
        ),
        body: listOptions(),
      ),
    );
  }

  Widget listOptions() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            contentSearchRegister(),
            const SizedBox(height: 15),
            dataForm(),
            const SizedBox(height: 15),
            tableData(),
          ],
        ),
      ),
    );
  }

  Widget contentSearchRegister() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              SizedBox(
                width: 150,
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      visibilitySearchId = true;
                    });
                  },
                  child: const Text('Buscar por id'),
                ),
              ),
              const SizedBox(width: 10),
              Visibility(
                visible: visibilitySearchId,
                child: Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: controllerIdRevista,
                    decoration: const InputDecoration(hintText: 'id Revista'),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Visibility(
                visible: visibilitySearchId,
                child: Expanded(
                  flex: 1,
                  child: RaisedButton(
                    onPressed: () => searchRegister(),
                    child: const Text('Buscar'),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget dataForm() {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  height: 45,
                  width: 80,
                  child: const Text('Tipo:')),
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: controllerTipo,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obligatorio *';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: 'Ingrese el tipo de revista'),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  height: 45,
                  width: 80,
                  child: const Text('Titulo')),
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: controllerTitulo,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obligatorio *';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: 'Ingrese el titulo de la revista'),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  height: 45,
                  width: 80,
                  child: const Text('Periodicidad:')),
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: controllerPeriodicidad,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obligatorio *';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: 'Ingrese la periodicidad de la revista'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget tableData() {
    return FutureBuilder(
        future: was.getRevistas(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          final list = snapshot.data;
          if (snapshot.hasData) {
            return Table(
              border: TableBorder.all(width: 0.5, color: Colors.black),
              children: [
                const TableRow(children: [
                  TableCell(
                    child: Center(child: Text('Numero R.')),
                  ),
                  TableCell(
                    child: Center(
                      child: Text('Tipo'),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text('Titulo'),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text('Periodicidad'),
                    ),
                  ),
                ]),
                for (var i = 0; i < list!.length; i++)
                  TableRow(children: [
                    TableCell(child: Text("${list[i]["numReg"]}")),
                    TableCell(child: Text(list[i]['tipo'])),
                    TableCell(child: Text(list[i]['titulo'])),
                    TableCell(child: Text(list[i]['periodicidad']))
                  ]),
              ],
            );
          } else {
            return Center(
              child: Text("Cargando..."),
            );
          }
        });
  }

  void functionInsert() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      } else {
        final revista = RevistaModel(
            periodicidad: controllerPeriodicidad.text,
            tipo: controllerTipo.text,
            titulo: controllerTitulo.text);

        final res = await was.insertRegister(revista);
        if (res) {
          showSnackBar('Revista ingresada correctamente');
          initComponets();
        } else {
          showSnackBar('La revista no pudo ser ingresada');
        }
      }
    } catch (e) {
      debugPrint('Error insert: $e');
    }
  }

  void functionUpdate() async {
    if (controllerIdRevista.text.isEmpty) {
      showAlertIdIsEmpty(context, 'Actualizar');
    } else {
      try {
        if (!formKey.currentState!.validate()) {
          return;
        } else {
          final revista = RevistaModel(
              numReg: int.parse(controllerIdRevista.text),
              periodicidad: controllerPeriodicidad.text,
              tipo: controllerTipo.text,
              titulo: controllerTitulo.text);

          final res = await was.updateRegister(revista);
          if (res) {
            showSnackBar('Revista actualizada correctamente');
            initComponets();
          } else {
            showSnackBar('La revista no pudo ser actualizada');
          }
        }
      } catch (e) {
        debugPrint('Error update: $e');
      }
    }
  }

  void functionDelete() async {
    if (controllerIdRevista.text.isEmpty) {
      showAlertIdIsEmpty(context, 'Eliminar');
    } else {
      try {
        final res =
            await was.deleteRegister(int.parse(controllerIdRevista.text));
        if (res) {
          showSnackBar('Revista eliminada correctamente');
          initComponets();
        } else {
          showSnackBar('La revista no pudo ser eliminada');
        }
      } catch (e) {
        debugPrint('Error delete: $e');
      }
    }
  }

  void searchRegister() async {
    if (controllerIdRevista.text.isEmpty) {
      showSnackBar(
          'Primero debe llenar el campo id para realizar la busqueda.');
    } else {
      try {
        setState(() {
          controllerPeriodicidad.clear();
          controllerTipo.clear();
          controllerTitulo.clear();
        });
        revista = await was.getRevista(int.parse(controllerIdRevista.text));
        if (revista!.numReg == null &&
            revista!.periodicidad == null &&
            revista!.tipo == null &&
            revista!.titulo == null) {
          showRevistaNoEncontrada(context);
          controllerIdRevista.clear();
        } else {
          FocusScope.of(context).unfocus();
          setState(() {
            controllerIdRevista.text = revista!.numReg.toString();
            controllerPeriodicidad.text = revista!.periodicidad!;
            controllerTipo.text = revista!.tipo!;
            controllerTitulo.text = revista!.titulo!;
          });
        }
      } catch (e) {
        debugPrint('Error delete: $e');
      }
    }
  }

  void initComponets() {
    setState(() {
      formKey.currentState!.reset();
      revista = RevistaModel();
      controllerIdRevista.clear();
      controllerPeriodicidad.clear();
      controllerTipo.clear();
      controllerTitulo.clear();
      visibilitySearchId = false;
    });
  }

  void showSnackBar(String content) {
    key.currentState!.showSnackBar(SnackBar(
      content: Text(content),
      duration: const Duration(seconds: 3),
    ));
  }
}
