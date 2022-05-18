import 'dart:convert';

import 'package:web_api_revista/model/revista_model.dart';

import 'package:http/http.dart' as http;

class WebApiService {
  String url = "http://jonathanperez-001-site1.ftempurl.com/";
  Map<String, String> header = {"Content-Type": "application/json"};

  Future<bool> insertRegister(RevistaModel revista) async {
    bool insertado = false;
    try {
      final res = await http.post(Uri.parse('${url}api/Revista'),
          body: json.encode({
            "tipo": revista.tipo,
            "titulo": revista.titulo,
            "periodicidad": revista.periodicidad
          }),
          headers: header);
      if (res.statusCode > 199 && res.statusCode < 300) {
        insertado = true;
      }
    } catch (e) {
      rethrow;
    }
    return insertado;
  }

  Future<bool> updateRegister(RevistaModel revista) async {
    bool actualizado = false;
    try {
      final res =
          await http.put(Uri.parse('${url}api/Revista/${revista.numReg}'),
              body: json.encode({
                "numReg": revista.numReg,
                "tipo": revista.tipo,
                "titulo": revista.titulo,
                "periodicidad": revista.periodicidad
              }),
              headers: header);
      if (res.statusCode > 199 && res.statusCode < 300) {
        actualizado = true;
      }
    } catch (e) {
      rethrow;
    }
    return actualizado;
  }

  Future<bool> deleteRegister(int numReg) async {
    bool actualizado = false;
    try {
      final res = await http.delete(Uri.parse('${url}api/Revista/$numReg'),
          headers: header);
      if (res.statusCode > 199 && res.statusCode < 300) {
        actualizado = true;
      }
    } catch (e) {
      rethrow;
    }
    return actualizado;
  }

  Future<RevistaModel> getRevista(int numReg) async {
    RevistaModel revistaModel = RevistaModel();
    try {
      final res = await http.get(Uri.parse('${url}api/Revista/$numReg'));
      if (res.statusCode > 199 && res.statusCode < 300) {
        final decodeRes = json.decode(res.body);
        print(decodeRes);
        revistaModel = RevistaModel(
            numReg: decodeRes['numReg'],
            tipo: decodeRes['tipo'],
            periodicidad: decodeRes['periodicidad'],
            titulo: decodeRes['titulo']);
      }
    } catch (e) {
      rethrow;
    }
    return revistaModel;
  }

  Future<List<Map<String, dynamic>>> getRevistas() async {
    List<Map<String, dynamic>> revistaModel = [];
    try {
      final res = await http.get(Uri.parse('${url}api/Revista'));
      if (res.statusCode > 199 && res.statusCode < 300) {
        final list = json.decode(res.body);
        for (var i = 0; i < list.length; i++) {
          revistaModel.add(list[i]);
        }
        print(revistaModel);
      }
    } catch (e) {
      rethrow;
    }
    return revistaModel;
  }
}
