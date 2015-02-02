var Tours = function(){


  return {
    dashboard: function(){
      if(!$('#dashboard').length){
        return false;
      }

      //var $button
      //$button = $("#make-tour");
      tour = new Tour({
        template: 
          '<div class="popover" role="tooltip">' +
          '	<div class="arrow"></div>' +
          '	<h3 class="popover-title"></h3>' +
          '	<div class="popover-content"></div>' +
          '	<div class="popover-navigation">' +
          '		<div class="btn-group"> <button class="btn btn-sm btn-default blue" data-role="prev">&laquo; Anterior</button> <button class="btn btn-sm btn-default green" data-role="next">Próximo &raquo;</button> <button class="btn btn-sm btn-default" data-role="pause-resume" data-pause-text="Pausar" data-resume-text="Continuar">Pausar</button> </div>' +
          '		<button class="btn btn-sm btn-default red" data-role="end">Terminar</button> ' +
          '	</div>' +
          '</div>',
        backdrop: true,
        //onStart: function() {
        //  return $button.addClass("disabled", true);
        //},
        //onEnd: function() {
        //  return $button.removeClass("disabled", true);
        //},
        debug: false,
        steps: [
          {
          path: "/",
          placement: "left",
          title: "Seja bem-vindo!",
          content: 
            "<p>Olá, </p>" +
            "<p>Este é um sistema ainda experimental, porém totalmente funcional. Diante disso, é muito importante para nós que você, em certas etapas, nos forneça um feedback. Assim poderemos prover mais valor ao sistema e, consequentemente, a você, usuário.</p>" +
            "<p>Mas você não precisa se preocupar com isso agora! Este feedback lhe será solicitado - em dois momentos distintos - na hora apropriada, conforme você for utilizando o sistema.</p>" +
            "<p>É muito importante que você siga este passo-a-passo até o final caso seja seu primeiro acesso. Vocẽ sempre poderá visualizá-lo novamente, conforme lhe mostraremos em breve.</p>" +
            "" +
            "" +
            "" +
            "" +
            "" +
            "" +
            "<p>Obs.: Após algum tempo, temos certeza que ficará muito irritante ter de ver este passo-a-passo sempre que você efetuar login. Você poderá desabilitá-lo ao final dele ou a partir do menu de Configurações.</p>",
          orphan: true
        }, {
          path: "/",
          element: ".page-sidebar",
          placement: "right",
          title: "Menu",
          content: "<p>Este é o menu principal da aplicação. Alguns itens não lhe serão úteis até que você tenha ao menos uma Grade de Tempo criada.</p>",
        }, {
          path: "/",
          element: "#menu-planning",
          placement: "right",
          title: "Planejamento",
          content: "<p>Planejamento...</p>",
          onShow: function(){

          }
        }, {
        path: "/",
        element: ".tasks-widget",
        placement: "right",
        title: "Utilitário de Tarefas",
        content: "<p>Utilitário caso você queira montar uma lista de tarefas.</p>"
        }, {
          path: "/",
          element: "#header-task-bar",
          placement: "bottom",
          title: "Lista de tarefas pendentes",
          content: "<p>Lista para fácil acesso contendo somente suas tarefas pendentes, cadastradas a partir do utilitário mostrado no passo anterior.</p>"
        }, {
          path: "/",
          element: "#header-user-bar",
          placement: "bottom",
          title: "2º Menu",
          content: "<p>Outro menu para facilitar o acesso a alguns itens.</p>"
        }, {
          path: "/",
          element: "#dashboard",
          placement: "top",
          title: "Dashboard",
          content: "<p>Este é o seu Dashboard (Painel). Além do utilitário de Tarefas que já lhe mostramos, aqui também aparecerá sua Grade de Tempo ativa no nomento, caso você já possua uma.</p>"
        }

        ]
      }).init();
      //if (tour.ended()) {
      //  $('<div class="alert alert-info alert-dismissable"><button class="close" data-dismiss="alert" aria-hidden="true">&times;</button>You ended the demo tour. <a href="#" data-demo>Restart the demo tour.</a></div>').prependTo(".content").alert();
      //}
      //$(document).on("click", "#make-tour", function(e) {
      //  e.preventDefault();
      //  if ($(this).hasClass("disabled")) {
      //    return;
      //  }
      //tour.init();
      tour.start();
      tour.restart();
      //});
    }

  };
}();
