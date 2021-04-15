import 'package:get/get.dart';

// App translations 
class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>{
    'es_MX':{
      // Login
      "login.form.submit.label":"Iniciar sesión",
      "login.form.email.label": "Correo electrónico",
      "login.form.password.label":"Contraseña",
      // Home
      "home.appbar.title.label":"Inicio",
      "home.body.empty.label":"Crea un nuevo servicio para comenzar",
      "home.dialog.title.label":"¿Desea finalizar su sesión?",
      "home.delete-dialog.title.label":"¿Desea eliminar este reporte?",
      "home.dialog.confirm-button.label":"Confirmar",
      "home.dialog.cancel-button.label":"Cancelar",
      "home.drawer.items.settings.label": " Ajustes",
      "home.drawer.items.logout.label":"Cerrar sesión",
      // Screening
      "screening.appbar.title.label":"Nuevo servicio",
      "screening.field_category.question.label":"¿Qué categoría de servicio de campo se realizará?",
      "screening.field_category.answer.generic.label":"Genérico",
      "screening.field_category.answer.marine.label":"Marino",
      "screening.report.question.label":"¿Qué tipo de reporte deseas iniciar?",
      "screening.service_type.answer.on_site.label":"En sitio",
      "screening.service_type.answer.field.label":"En campo",
      'screening.field_category.answer.warehouse.label': "Almacen",
      "screening.service_type.question.label":"¿Qué tipo de servicio?",
      "screening.next_button.label":"Siguiente",
      "screening.loading.label":"Cargando formulario...",
      "screening.report.success.label":"Exito",
      "screening.report.success.content.label":"Formulario subido exitosamente",
      "screening.report.error.label":"Error",
      "screening.report.error.content.label": "Formulario incompleto",
      "screening.report.bad_connection.content.label": "Consulte su conexión a internet",
      //Report handler
      "report_handler.title.label":"Vista de reporte",
      "report_handler.local_report.success.label":"Formulario incompleto",
      "report_handler.local_report.success.content.label": "Formulario guardado de forma local",
      "report_handler.submit.label":"Enviar",
      "report_handler.back.label":"Atrás",
      // Settings
      "settings.appbar.title.label":"Ajustes",
      "settings.form.language.label":"Lenguage",
    },
    'pt_BR':{
      // Login
      "login.form.submit.label":"Iniciar sessão",
      "login.form.email.label": "Correio eletrônico",
      "login.form.password.label":"Senha",
      // Home
      "home.appbar.title.label":"Começar",
      "home.body.empty.label":"Crie um novo serviço para começar",
      "home.dialog.title.label":"Quer terminar a sua sessão?",
      "home.delete-dialog.title.label":"Você quer deletar este relatório?",
      "home.dialog.confirm-button.label":"Confirme",
      "home.dialog.cancel-button.label":"Cancelar",
      "home.drawer.items.settings.label": " Definições",
      "home.drawer.items.logout.label":"Fechar Sessão",
      // Screening
      "screening.appbar.title.label":"Novo serviço",
      "screening.field_category.question.label":"Que categoria de serviço de campo será executado?",
      "screening.field_category.answer.generic.label":"Genérico",
      "screening.field_category.answer.marine.label":"Marinho",
      "screening.report.question.label":"Que tipo de relatório você deseja iniciar?",
      "screening.service_type.answer.on_site.label":"No site",
      "screening.service_type.answer.field.label":"Em campo",
      'screening.field_category.answer.warehouse.label': "Armazém",
      "screening.service_type.question.label":"Que tipo de serviço?",
      "screening.next_button.label":"Próximo",
      "screening.loading.label":"Carregando formulário...",
      "screening.report.success.label":"Sucesso",
      "screening.report.success.content.label":"Formulário carregado com sucesso",
      "screening.report.error.label":"Erro",
      "screening.report.error.content.label": "Formulário incompleto",
      "screening.report.bad_connection.content.label": "Verifique sua conexão com a internet",
      //Report handler
      "report_handler.title.label":"Visualização de relatório",
      "report_handler.local_report.success.label":"Formulário incompleto",
      "report_handler.local_report.success.content.label": "Formulário salvo localmente",
      "report_handler.submit.label":"Enviar",
      "report_handler.back.label":"Atrás",
      // Settings
      "settings.appbar.title.label":"Definições",
      "settings.form.language.label":"Linguagem",
    }
  };
}