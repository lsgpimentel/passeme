# PasseMe

###################
# TODO List
###################
- ~~Ao passar de página, a página inteira não é recarregada devido ao turbolinks, porém o javascript deve ser recarregado no page:change. Tem que ser verificado o javascript atual, pois em alguns casos ao passar de página algumas funcionalidades javascript não funcionam.~~
- QUando tentar mudar a data de expiração de uma tarefa, limitar as datas do calendário para o usuário não colocar uma data anterior à de hoje
- Quando alguma tarefa for concluída, atualizar o widget de tarefas na barra superior
- Não permitir que uma tarefa seja editada se ela já está concluída.
- Alterar os models que podem gerar notificação( ex.: Task) e incluir a associação em que podem ter muitas notificações, colocando dependent: destroy
- Realizar o envio de notificações para as operações que podem receber notificação.
- Revisar o routes.rb e retirar as rotas não usadas
- Verificar e retirar os css's e js's que não estão sendo usados pela aplicação (foram copiados do template)
- Verificar se há algum nome melhor para a entidade StudyTime (Tempo de estudo), que corresponde à um determinado horário de estudo do usuário dentro da grade.
- Incluir validações nos models para não incluir valores inválidos
- Verificar quals tabelas estão com a coluna de ID e se é realmente necessário estarem. Caso não seja, tirar e adicionar outra PK.
- Definir como será implementado os diversos tipos de fontes de estudo em termos de modelagem: Se irei criar uma tabela para cada tipo diferente ou deixar todos os atributos na mesma tabela. Atualmente a entidade está só com os atributos em comum.
- Rever o conceito da tela de Planos de estudo para que o calendário ocupe todo o espaço, colocando as ações da tela em opções de dropdowns.
- Na tabela de matérias, depois que uma nova for adicionada, recarregar a tabela ou a página. Tem que verificar bem, porque pode ser que eu use a resposta do controller tanto em formato html como js. Se for JS, o esquema de recarregar a página não vai dar certo se estiver no meio da criação de uma timetable. Neste caso, usar a API do dataTable e adicionar a linha no callback de sucesso.
- Atualmente antes de realizar operações como atualizar ou criar um novo em um modelo, eu estou testando se o usuário é o dono do objeto a ser modificado/criado. Isso seria melhor se fosse feito pelo cancan na classe Ability, ao invés de em cada controller. Lembrar de alterar isso nas telas com nested attributes, como em setting que grava notification_settings (id do notification_setting).
  +(http://stackoverflow.com/questions/6323658/how-can-i-allow-a-user-to-only-visit-their-own-show-page-using-cancan)
- Corrigir bug no qual o ajaxRailsUJS não está funcionando quando usado link_to (... remote: true) na página de subject groups. Comentei a integração, porque o callback de ajax:complete não estava executando, o que fazia com que o loading não saísse da tela.





###################
# Anotações
###################



Copyright 2013 @ Leonardo Pimentel
