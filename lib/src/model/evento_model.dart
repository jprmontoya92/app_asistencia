import 'dart:convert';

EventoModel eventoModelFromJson(String str) => EventoModel.fromJson(json.decode(str));

String eventoModelToJson(EventoModel data) => json.encode(data.toJson());

class EventoModel {
    String tipoMarcaje;
    String fecha;
    String mes;

    EventoModel({
        this.tipoMarcaje,
        this.fecha,
        this.mes
    });

    factory EventoModel.fromJson(Map<String, dynamic> json) => EventoModel(
        
        tipoMarcaje : json["even_tipo"],
        fecha       : json["even_fecha"],
        mes         : json["even_mes"]
    );

    Map<String, dynamic> toJson() => {
        
        "tipo_marcaje"  : tipoMarcaje,
        "fecha"         : fecha,
        "mes"           : mes
    };
}
