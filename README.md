
# TODO List

- [x] ~~Ao passar de página, a página inteira não é recarregada devido ao turbolinks, porém o javascript deve ser recarregado no page:change. Tem que ser verificado o javascript atual, pois em alguns casos ao passar de página algumas funcionalidades javascript não funcionam.~~
- [ ] QUando tentar mudar a data de expiração de uma tarefa, limitar as datas do calendário para o usuário não colocar uma data anterior à de hoje
- [ ] Quando alguma tarefa for concluída, atualizar o widget de tarefas na barra superior
- [ ] Não permitir que uma tarefa seja editada se ela já está concluída.
- [ ] Alterar os models que podem gerar notificação( ex.: Task) e incluir a associação em que podem ter muitas notificações, colocando dependent: destroy
- [ ] Realizar o envio de notificações para as operações que podem receber notificação.
- [ ] Revisar o routes.rb e retirar as rotas não usadas
- [ ] Verificar e retirar os css's e js's que não estão sendo usados pela aplicação (foram copiados do template)
- [x] ~~Verificar se há algum nome melhor para a entidade StudyTime (Tempo de estudo), que corresponde à um determinado horário de estudo do usuário dentro da grade.~~
- [ ] Incluir validações nos models para não incluir valores inválidos
- [ ] Verificar quals tabelas estão com a coluna de ID e se é realmente necessário estarem. Caso não seja, tirar e adicionar outra PK.
- [ ] Definir como será implementado os diversos tipos de fontes de estudo em termos de modelagem: Se irei criar uma tabela para cada tipo diferente ou deixar todos os atributos na mesma tabela. Atualmente a entidade está só com os atributos em comum.
- [x] ~~Rever o conceito da tela de Planos de estudo para que o calendário ocupe todo o espaço, colocando as ações da tela em opções de dropdowns.~~
- [ ] Na tabela de matérias, depois que uma nova for adicionada, recarregar a tabela ou a página. Tem que verificar bem, porque pode ser que eu use a resposta do controller tanto em formato html como js. Se for JS, o esquema de recarregar a página não vai dar certo se estiver no meio da criação de uma timetable. Neste caso, usar a API do dataTable e adicionar a linha no callback de sucesso.
- [ ] Atualmente antes de realizar operações como atualizar ou criar um novo em um modelo, eu estou testando se o usuário é o dono do objeto a ser modificado/criado. Isso seria melhor se fosse feito pelo cancan na classe Ability, ao invés de em cada controller. Lembrar de alterar isso nas telas com nested attributes, como em setting que grava notification_settings (id do notification_setting).
+(http://stackoverflow.com/questions/6323658/how-can-i-allow-a-user-to-only-visit-their-own-show-page-using-cancan)
- [x] ~~Corrigir bug no qual o ajaxRailsUJS não está funcionando quando usado link_to (... remote: true) na página de subject groups. Comentei a integração, porque o callback de ajax:complete não estava executando, o que fazia com que o loading não saísse da tela.~~
- [ ] Na página de criação do timetable, colocar a inicialização dos javascripts de cada etapa conforme eu passar para ela, ao invés de pôr tudo no carregamento da página. Isso deve corrigir o problema com a inicialização do calendário.
- [x] ~~Verificar alguma forma de obter os eventSources do calendário. Pelo que parece, vendo a API do fullcalendar, não daria pra obter todos os event sources a partir de uma única URL. Cada event source deve possuir uma URL. Se realmente não puder ser feito dessa maneira, eu vou ter que obter todos os events mesmo. ~~
- [x] ~~Verificar por que a porra da seleção não aparece corretamente quando insiro o elemento diretamente pelo builder do breadcrumb. O elemento é gerado, mas não aparece na tela por algum motivo. ~~
- [ ] Tratar todas as datas para que a aplicação fique internacionalizada, ou seja, conforme é usado um time zone diferente os padrões de data colocados pelo usuários serão diferentes. Pode ter uma opção também em settings para o timezone e/ou padrão de datas.
- [x] ~~Consertar o input picker de color. O ideal seria colocar pro cara só escolher a cor, e não poder digitar o hexadecimal, pra ficar mais amigável. A cor também deve aparecer no grid. No banco só deverá ser gravado o hexadecimal sem a cerquilha. ~~
- [x] ~~Colocar o evento de day click do calendário junto com o de add event. Os 2 estão em controllers separados, porém os 2 se referem à criação de eventos, devendo ficar portando no controller de calendar_events. A única diferença é que no day click o dia do evento já é enviado. ~~
- [x] ~~Rever os padrões do callback ajax. Colocar o uniform como false pra recarregar. ~~
- [x] ~~Retirar as divs com "ajax-modal" das páginas que usam ajax e modal. ~~
- [ ] Deixar os date e time pickers de uma forma modular, passando todas as opções via input criado do simple_form
- [x] ~~Remover o timezone do calendar_event ~~
- [x] ~~No cadastro do usuário, colocar mais atributos: país, timezone e language ~~
- [x] ~~Escolher as cores da tabelade follow up quando o tempo de estudo tiver débito e quando não tiver débito ~~
- [ ] Mudar o comportamento da seleção do filtro do follow up para funcionar usando ajax ao invés de redirect
- [x] ~~Quando um item já está como estudado, ele não deve aparecer na aba de "para estudar". Porém, devido a um problema na manipulação do timezone dos objetos time, não tá funcionando direito. Verificar depois.~~
- [x] ~~Quando não há nenhuma timetable criada está dando erro quando tento abrir o follow up. Deve ter algum tratamento dizendo que o usuário precisa criar uma timetable, ou então o item nem aparece no menu.~~
- [x] ~~No follow up não deve ser deixado o usuário marcar como completo horários que ainda não aconteceram, e sim somente os que já passaram.~~
- [x] ~~Se o usuário estiver criando a primeira timetable, então esta deverá se tornar ativa por padrão.~~
- [x] ~~Na criação do evento do calendário, no dropdown select2 de event sources, o alinhamento dos itens do select está com problema.~~
- [ ] Mudar a tela de criação da timetable, para que na última etapa o usuário selecione as matérias e para cada matéria selecione as fontes de estudo que ele quer usar para colocar no calendário gerado pelo algoritmo. Tem que pensar em como vai fazer feita a interface, já que uma fonte de estudo pode estar sendo usada em várias matérias. O Algoritmo precisa receber um hash
- [x] ~~Não faz sentido ter tempo de intervalo no study_time, quando o tempo de intervalo é aplicado após um bloco ser concluído e é fixo para toda a Timetable. Neste caso, excluir o tempo de intervalo do study_time, e adicioná-lo na timetable.~~
- [x] ~~Adicionar um atributo em Timetable para armazenar o tamanho do bloco de estudos~~
- [ ] Criar página de profile do usuário (users#show)
- [ ] Usar a gem responders para refatorar as mensagens de flash lançadas pelo controller para não ter que ficar usando vários respond_to
- [ ] Se tiver usando técnica de pomodoro, não usar o campo de block_interval (retirar da tela)
- [ ] Bug quando a normalização dos tempos de estudo é feita usando a técnica de pomodoro. Neste caso, a divisão dos pomodoros está sendo feita de acordo com os tempos de estudos agrupados e separados pela produtividade, quando deveria ser agrupado independente da produtividade, mas mantendo esta quando for gerar o novo bloco.
- [ ] Tratamento para intervalo quando se cria um evento separado pelo calendário. Para o intervalo ter alguma utilidade deveria ser especificado o tamanho do bloco
- [ ] Alterar tela de study times na criação da timetable para usar nested form no portlet de novo study time. Alterar as referências de i18n também.
- [ ] Modificar o breadcrumb para obter o nome da página atual usando i18n. Talvez tenha que mudar a gem.


# Anotações Caderno


### Plano de Estudos

1. Organização  
	1.1) Essencial para conseguir  
	1.2) Dar tiro para todo lado (escolha o oponente certeiro)  
3. Matérias  
	3.1) Tabela com matérias / peso de cada uma  
4. Tempo  
	4.1) De quanto tempo disponho?  
	4.2) Sinceridade: Feriados? Aniversários? Imprevistos  
	4.3) Se encaixar na rotina  
	4.4) Time Break  
5. Revezar  
	5.1) Vários conteúdos / ciclo para assemelhar ao concurso  
	5.2) Não esquece as matérias mais antigas  
6. Praticar  
	6.1) Importância da prática?  
	
##### Anotações
1.1) Como fazer para o foco se manter nela? Meios para não fugir muito do planejamento inicial  
1.2) Saber o que estudar é muito importante. Compartilhamento, sugestões do que estudar através dos outros planos de estudos cadastrados.  
3.1) O que já conheço dessa matéria? Qual a importância dela no plano de estudos? É difícil? Fazer um cálculo encima disso tudo.  
4.2) Deixar sempre a gordura. Imprevistos acontecem.  
4.3) Nada de plano impossível, pode gerar frustração.  
4.4) Concentração cai depois de muito tempo (pausa/trocar)  
6.1) Reservar um tempo para isso  


### Ciclo Plano de Estudos
1. Fase de otimização  
	1.1) Ajustar facilidade/dificuldade para otimizar o tempo  
2. Levantamento  
	2.1) Tipo de estudo / matérias / bibliografia / objetivos, etc.  
3. Atualização  
	3.1) Feedback do andamento dos estudos  
	3.2) Notificações  
4. Integração  
	4.1 Google calendar, etc.  

##### Anotações
1) Última fase?  
  1.1) Diminuir desgaste psicológico também  
3.1) Conseguiu cumprir com o planejado? Não? Por quê? Reagendar?  
3.2) Celular, email, facebook, twitter,etc. O que tenho que estudar hoje? Estou atrasado?!  
4.1) Facilitaria a vida? Ele pode ajudar com as notificações...  

### Estudo Dirigido

1. Aluno estuda de acordo com o roteiro elabora pelo professor  
	1.1) Professor estabelece extensão e profundidade do estudo  
	1.2) Define instruções / orientações para o aluno  
	1.3) Respeito ao ritmo de aprendizagem de cada aluno  

##### Anotações
   1. Poderia ser criado diversos roteiros segundo diversos critérios (tempo, conhecimento prévio, nível de aprofundamento, etc).
	Em torno de um plano de estudos é montade uma estratégida de estudo dirigido.
	Vários alunos adentrariam este grupo, que teria um ou mais mentores. Eles trocariam experiências, estudariam juntos, fariam avaliações passadas pelo mentor, etc.
	Similar a um sistema de EAD, só que tudo gira em torno do plano de estudos.   


# Anotações Aleatórias


- [ ] Mostrar frases de motivação todos os dias.

- [ ] Avaliar o conceito de planejamento de estudo como um projeto, no qual eu tenho objetivo, escopo, cronograma e até mesmo o quanto pretendo gastar por mês.

- [ ] Além de definir a dificuldade de cada matéria seria bom também definir a afinidade que possuo com cada uma. Porém, de certa forma, a afinidade com uma matéria e a dificuldade que possuo em relação à mesma estão intimamente relacionadas. O conceito de afinidade pode ser usado também para orientar em que área você pretende se inscrever para um dado concurso, se vale a pena você insistir em um determinado cargo que você tem afinidade, mas é muito concorrido ou estudar pra um que você não tem afinidade, porém não é tão concorrido assim.

- [ ] Quantos % do edital eu tenho de cobrir pra ter um desempeno satisfatório?

- [ ] Avaliar o ambiente de estudo (ônibus, casa, etc) para ter uma idea melhor da produtividade

- [ ] Horas Brutas x Horas Líquidas (considerar pausas, etc)
- [ ] Para ajudar a calcular melhor as horas líquidas, ao final do estudo do dia, o usuário poderia informar quantas pausas inesperadas (não programadas) a mais ele teve.

- [ ] Ciclo PDCA para estudos (projetos)

- [ ] Usuário poderá ter a opção de escolher opções avançadas para geração do calendário, de acordo com preferências de estudo pessoais.

- [ ] Considerar o tipo de estudo a ser realizado: leitura corrida, resumo, revisão, resolução de exercícios, etc.

- [ ] Reservar um tempo para verificar se o planejamento está andando conforme o planejado (ciclo check do PDCA)

- [ ] Considerar que na fase inicial do planejamento, o mesmo está em adequação, então é provável que nem tudo o que está planejado será cumprido. A fase de "testes" poderia ser útil para definir inicialmente o quanto o usuário é capaz de estudar. Esta fase poderia ser opcional, para usuários mais iniciantes, como por exemplo.

- [ ] "a ênfase em ir marcando o completamento de cada tarefa ao longo do dia, não apenas porque oferece oportunidade de colocar o restante do dia em perspectiva, mas também porque é um grande motivador a produzir mais." <- Interessante, principalmente se eu disponibilizar vários meios para se marcar a tarefa como concluída (celular, tablet, etc), assim com o Wunderlist.

- [ ] O usuário deve gerenciar sua base de conhecimento. Quem não registra o que aprendeu, acaba condenado a pesquisar/estudar tudo de novo. Isso em concurso é ainda mais importante. Seria bom o sistema atuar também como gerenciador de conhecimento adquirido, disponibilizando meios de organização, como anotações para o dia de estudo tal, mapa mental (bem ousada essa), etc.

- [ ] Atalhos de teclado para facilitar tarefas durante o uso do sistema, assim com o Banking do Bradesco e o Wunderlist.

- [ ] David Allen sobre o GTD: "As pessoas mantêm coisas em suas cabeças. Elas não decidem o que precisam fazer sobre coisas que elas sabem que terão que fazer algo a respeito. Elas não organizam lembretes de ações e material de apoio em categorias funcionais. Elas não mantêm nem analisam uma lista completa e objetiva de seus compromissos. Aí elas desperdiçam energia e se desgastam, deixando suas atividades serem conduzidas pelo que for mais recente e estridente, esperando que seja a coisa certa a fazer mas sem nunca ter o alívio da certeza."
	"Tire tudo de sua cabeça. Tome decisões sobre cada coisa no momento em que toma conhecimento dela, sem esperar elas explodirem. Organize lembretes de seus projetos e das próximas ações em cada um deles em categorias apropriadas. Mantenha seu sistema atualizado, completo e analisado com uma freqüência suficiente para ter confiança em suas escolhas intuitivas sobre o que você está fazendo (ou deixando de fazer) a cada momento."

- [ ] O autor do GTD recomenda que dediquemos 2 dias a fase inicial de coleta quando estamos iniciando a usar a técnica. Achei interessante, considerando que um planejamento de estudos as vezes pode demorar para ser feito (add materias, add fontes, etc). Tudo a seu tempo!

- [ ] Na fase de monitoramento e análise, seria interessante ter um medidor que mostra a quantos % o usuário está de completar todo o projeto, ou um ciclo menor (uma semana por exemplo). Também seria legal alguma forma de estabelecer pontos de ranking, como um jogo, acho que é um excelente motivador.

- [ ] Após cumprimir o meu cronograma de estudos e realizar a prova, como foi o meu resultado na prova? Quantos % de tal materia acertei? No que fui pior? No que devo me focar mais da próxima vez

- [ ] Reaproveitar coisas de um planejamento meu (matérias, fontes, etc) para outro planejamento

- [ ] Fazer todo o planejamento do concurseiro de uma vez só é no mínimo ingênuo. Talvez seja bom trabalhar com "doses de tempo" mais palatáveis. Estive pensando em ter categorias de planejamento diário, ou seja, planejo o que vou estudar para o meu dia, sendo mais útil para concurseiros que tem uma carga muito dinâmica. Este planejamento diário tem os contra-pontos também, como não conseguir visualizar o longo prazo num estágio inicial, etc. Posso ir um pouco mais além também e planejar o amanhã a cada dia. Indo mais além posso fazer toda semana meu planejamento semanal, no qual já defino de cara o que vou estudar para a semana inteira; ou então o mensal ou até mesmo anual. E claro, a opção mais interessante seria o planejamento híbrido: Posso definir um dia hoje, mas amanhã decido fazer um ciclo mensal, e depois um semanal. De repente, surge o edital e quero ter mais granularidade sobre o que estou estudando, então volto para os ciclos diários. Sendo que também eu poderia interromper um ciclo mensal no meio dele para voltar a um diário, isso é importante.
	Uma coisa a se considerar é que os planejamentos a longo prazo (ex. um ano) são sempre mais difíceis, pois requerem uma disciplina muito maior do usuário e um tempo inicial bem gasto pra fazer ele certo. Os a curto prazo, entretanto, são mais dinâmicos, mas requerem também uma disciplina diária de estar sempre fazendo-os. São mais úteis também pra quem tem tempos variáveis para estudar, seja devido ao trabalho, etc.
	Outra coisa em relação à planos híbridos seria a possibilidade de eu estar em um plano a longo prazo, interrompê-lo em caráter de urgência, porque surgiu um edital novo, por exemplo, e eu preciso me focar mais no que é cobrado nele, e depois desse período voltar ao ritmo do meu planejamento a longo prazo. Neste sentido, quando um concurso surge durante meu planejamento tenho de me perguntar: "Vou interromper meu planejamento temporariamente pra atender este concurso em específico?".
	Levar em consideração que estudar só o que surge nos editais (ter uma planejamento super dinamico) nem sempre é bom, pois você acaba não aprendendo as matérias de base, ou matérias que possam ser reaproveitadas para o concurso seguinte.
	Um planejamento a longo prazo também é interessante no sentido de que pode ser considerado um planejamento se não passar, simplismente porque caso você não passe em um concurso que surgiu enquanto você estava estudando em um escopo maior, você não fica desnorteado, afinal você ainda tem um planejamento para completar. Caso contrário, você fez o concurso, agora você tá perdido, sem planejamento, tendo que meio que recomeçar do zero.

- [ ] No planejamento definir quanto tempo gasto em possíveis distrações no meu dia antes mesmo dele começar (pausas não contam como distrações).

- [ ] Um simulador de prova seria uma coisa muito de legal de ser fazer. Quem sabe se der tempo eu penso nisso. Poderia até fornecer as questões, conforme num banco de dados e faria uma mistura, geraria uma prova, colocaria um timer e deixaria o cara fazendo. Bem interessante!

- [ ] Sempre considerar um tempo para revisão do que já se estudou, principalmente em ciclos mais longos.

- [ ] Eu nem sempre consigo atender completamente o escopo do meu projeto, então estratégias de priorização de matérias são muito importantes. Tenho que definir qual será minha estratégia de priorização, ex.: Pela matéria que sempre é mais cobrada em tal concurso, pela dificuldade/afinidade que tenho com determinada matéria, etc

- [ ] Usar a técnica de pomodoro para cronometrar as horas líquidas estudadas. Poderia ser feito um cronômetro bem simples que o usuário acionaria via web para cronometrar o tempo de estudo. O ideal mesmo seria via celular, mas isso pode ficar pro futuro.

- [ ] Bom dar uma olhada forte na parte de estudo dirigido, to pensando aqui que isso seria muito mais útil do que uma ferramenta só para planejamento. Geralmente as pessoas conseguem fazer um planejamento bom até mesmo no excel. Essa parte de estudo dirigido e compartilhamento de planos dá mais margem pra coisas mais interessantes.

- [ ] O sistema tem de dar orientações o tempo todo para o usuário sobre o processo que ele utiliza, como o planejamento vai ser feito e dicas importantes para que tudo seja feito e principalmente seguido com sucesso pelo usuário.

- [ ] Possibilidade de usar tags para algumas coisas, como o planejamento que foi feito, e outras coisas que o usuário talvez possa achar util classificar usando tags.

- [ ] Um planejamento de projetos antevê riscos. Como o planejamento de estudo pode antever os riscos envolvidos neste processo de estudo?

- [ ] Em relação ao estudo dirigido, to pensando em fazer algo parecido com o github. É mostrado quantos usuários fizeram "fork" daquele plano de estudos, etc. Além disso, eu posso montar um grupo com um número determinado de usuários, onde um determinado usuário convida outros, montando o grupo e é feito uma estratégia para eles estudarem juntos, como cada um revisa o que o outro fez, ou algo do tipo.

- [ ] O livro do Neiva ("COMO SE PREPARAR PARA CONCURSOS PÚBLICOS COM ALTO RENDIMENTO") parece ter uma ponte entre os "estilos de aprendizagem" e a preparação para concursos públicos. Pelo menos é o que parece, já que ele possui um artigo bem interessante sobre o tema, destacando quais ferramentas são mais interessantes de se usar de acordo com cada estilo.

- [ ] O usuário vai poder criar mais de um plano de estudos, mas só vai poder ter 1 ativo de cada vez. Isso é importante, até mesmo por questão de monitoramento (envio de e-mail, notificações, etc) e conflito de horários. E isso é legal, porque ele repentinamente pode mudar seu plano de estudos ativo pra outro pré-cadastrado.

- [ ] Ponderar sobre a divisão do estudo em fases diferentes, assim como consta no livro do Neiva, em que ele divide em duas fases, sendo a primeira de assimilação do conteúdo geral, ou seja, estudo bibliográfico, e a segunda de melhor assimilação para suprir o que ficou faltando, indo para assuntos mais específicos que não constavam nas fontes de estudo da primeira fase, e revisar os conceitos estudados na primeira fase.

- [ ] No final de um dia de estudo, apresentar ao concurseiro o que ele tem de estudar no próximo dia, assim ele pode se organizar e organizar seu ambiente, preparando-o já para receber o estudo desta matéria (separar materiais, etc).

- [ ] Poder consultar um dicionário online enquanto usa o software. Colocar na fase de execução. Verificar se é realmente interessante ter isso, já que nem sempre o estudo é online e nem sempre vou estar com o sistema aberto. Seria mais interessante se eu colocasse minhas revisões no sistema.

- [ ] Após cadastrar gerar o plano de estudos, o usuário teria a opção de deixar o mapa como público para acesso ou privado.
Se o plano é público ele pode ser visualizado por pessoas externas, o que não acontece no privado, que só pode ser visualizado pelo próprio usuário.
Além disso, no caso dos planos públicos, o usuário também tem a opção de colocar uma senha de acesso nele, permitindo o acesso somente a pessoas que possuem esta senha compartilhada.

- [ ] Nessa questão de medir o desempenho, seria bom avaliar até que ponto eu posso acelerar meu aprendizado - acelerando leitura, resumo, exercicios, etc - sem perder a capacidade de aprendizado. A intenção seria chegar na melhor medida velocidade de aprendizado X qualidade do aprendizado.
Alguns gráficos mostrando essa relação seriam interessantes.

- [ ] Não esquecer de usar o conceito da aprendizagem espaçada (revisões, etc).

- [ ] O usuário tem de ter a possibilidade de escolher quanto tempo ele quer planejar. Ele pode começar planejando 6 meses a frente, assim como 1 dia a frente.
Já discuti sobre as vantagens e desvantagens de cada caso. Quando o tempo que ele planejou acaba, ele pode planejar mais tempo a frente, sendo novamente quanto tempo ele desejar.
Um problema de planejar logo de cara a longo termo é que você tem que considerar os compromissos que vão surgindo conforme o tempo. Ou seja, conforme o tempo vai passando vc inevitavelmente vai acabar adicionando compromissos, tirando tempo de estudo.

- [ ] Em http://www.studygs.net/schedule/calendar.htm é reiterado que o ideal é marcar primeiro no calendário as datas importantes (marcos/milestones em projetos), marcar os feriados, os dias com compromissos já definidos (de família, amigos, etc).

- [ ] Uma coisa muito importante é a impressão do calendário diário, semanal, mensal com as tarefas do cara. É bem provável que ele não vá estudar com o calendário aberto no computador, então a impressão do calendário tem que ficar boa e clara no papel (css p/ impressão)

- [ ] Importação de compromissos do google calendar ou de um ics e exportação em ics, podendo ser jogado no Google Calendar (ver case do coolendar)

- [ ] Colocar objetivos em termos de prazo (bem distante, médio e imediato) e dar prioridade pra cada um deles. Lembrando que esses obejtivos seriam em termos de aprendizado, já que o objetivo principal é passar em um determinado concurso ou conjunto de concursos.

- [ ] Os integrantes do grupo devem preencher suas expectativas com este, em termos de aprendizado. O que eu desejo aprender? O que eu espero? Quais os meus interesses e qualificações em relação à este grupo?
  Os objetivos dos membros são comparados e tenta-se chegar a um denominador comum (comparação, extração de palavras-chaves e priorização) . Lembrando que isso vai depender muito da estratégia do grupo, ou seja, se tenho grupos homogêneos em termos de conhecimento (ex.: todo mundo sabe bem direito administrativo e quer discutir sobre isso, fazendo exercícios, por exemplo) a intenção vai ser diferente de quando eu tiver grupos heterogêneos, no qual geralmente cada um tem uma especialidade principal e tenta-se equalizar o conhecimento de todos em relação à todas as especialidades (eu passo conhecimento no que sou muito bom e recebo conhecimento de outros integrantes que são bons em suas respectivas áreas)

- [ ] Para o usuário não ter que ficar indo todo dia no sistema e marcando os horários de início e término do estudo, o sistema poderia imprimir para este um calendário semanal e no fim do ciclo (que pode ser no fim de semana), o usuário marcar se seguiu os horários ou não. Assim evitaria deste ter que ficar todo dia abrindo a aplicação para informar horários.
Na impressão teria de ter campos já separados para ele anotar os horários à caneta, etc, para depois transpor para a aplicação.



Copyright 2013 @ Leonardo Pimentel
