var I18n = I18n || {};
I18n.translations = {"en":{"date":{"formats":{"default":"%Y-%m-%d","short":"%b %d","long":"%B %d, %Y"},"day_names":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"],"abbr_day_names":["Sun","Mon","Tue","Wed","Thu","Fri","Sat"],"month_names":[null,"January","February","March","April","May","June","July","August","September","October","November","December"],"abbr_month_names":[null,"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"order":["year","month","day"]},"time":{"formats":{"default":"%a, %d %b %Y %H:%M:%S %z","short":"%d %b %H:%M","long":"%B %d, %Y %H:%M"},"am":"am","pm":"pm"},"support":{"array":{"words_connector":", ","two_words_connector":" and ","last_word_connector":", and "}},"number":{"format":{"separator":".","delimiter":",","precision":3,"significant":false,"strip_insignificant_zeros":false},"currency":{"format":{"format":"%u%n","unit":"$","separator":".","delimiter":",","precision":2,"significant":false,"strip_insignificant_zeros":false}},"percentage":{"format":{"delimiter":"","format":"%n%"}},"precision":{"format":{"delimiter":""}},"human":{"format":{"delimiter":"","precision":3,"significant":true,"strip_insignificant_zeros":true},"storage_units":{"format":"%n %u","units":{"byte":{"one":"Byte","other":"Bytes"},"kb":"KB","mb":"MB","gb":"GB","tb":"TB"}},"decimal_units":{"format":"%n %u","units":{"unit":"","thousand":"Thousand","million":"Million","billion":"Billion","trillion":"Trillion","quadrillion":"Quadrillion"}}}},"errors":{"format":"%{attribute} %{message}","messages":{"inclusion":"is not included in the list","exclusion":"is reserved","invalid":"is invalid","confirmation":"doesn't match %{attribute}","accepted":"must be accepted","empty":"can't be empty","blank":"can't be blank","present":"must be blank","too_long":"is too long (maximum is %{count} characters)","too_short":"is too short (minimum is %{count} characters)","wrong_length":"is the wrong length (should be %{count} characters)","not_a_number":"is not a number","not_an_integer":"must be an integer","greater_than":"must be greater than %{count}","greater_than_or_equal_to":"must be greater than or equal to %{count}","equal_to":"must be equal to %{count}","less_than":"must be less than %{count}","less_than_or_equal_to":"must be less than or equal to %{count}","other_than":"must be other than %{count}","odd":"must be odd","even":"must be even","taken":"has already been taken","already_confirmed":"was already confirmed, please try signing in","confirmation_period_expired":"needs to be confirmed within %{period}, please request a new one","expired":"has expired, please request a new one","not_found":"not found","not_locked":"was not locked","not_saved":{"one":"1 error prohibited this %{resource} from being saved:","other":"%{count} errors prohibited this %{resource} from being saved:"},"invalid_date":"não é uma data válida","invalid_time":"não é um horário válido","invalid_datetime":"não são data e horário válidos","is_at":"deve ser igual a %{restriction}","before":"deve ser anterior a %{restriction}","on_or_before":"deve ser igual ou anterior a %{restriction}","after":"deve ser posterior a %{restriction}","on_or_after":"deve ser igual ou posterior a %{restriction}"}},"activerecord":{"errors":{"messages":{"record_invalid":"Validation failed: %{errors}","restrict_dependent_destroy":{"one":"Cannot delete record because a dependent %{record} exists","many":"Cannot delete record because dependent %{record} exist"},"invalid":"is invalid","invalid_event":"cannot transition when %{state}","invalid_transition":"cannot transition via \"%{event}\""}}},"datetime":{"distance_in_words":{"half_a_minute":"half a minute","less_than_x_seconds":{"one":"less than 1 second","other":"less than %{count} seconds"},"x_seconds":{"one":"1 second","other":"%{count} seconds"},"less_than_x_minutes":{"one":"less than a minute","other":"less than %{count} minutes"},"x_minutes":{"one":"1 minute","other":"%{count} minutes"},"about_x_hours":{"one":"about 1 hour","other":"about %{count} hours"},"x_days":{"one":"1 day","other":"%{count} days"},"about_x_months":{"one":"about 1 month","other":"about %{count} months"},"x_months":{"one":"1 month","other":"%{count} months"},"about_x_years":{"one":"about 1 year","other":"about %{count} years"},"over_x_years":{"one":"over 1 year","other":"over %{count} years"},"almost_x_years":{"one":"almost 1 year","other":"almost %{count} years"}},"prompts":{"year":"Year","month":"Month","day":"Day","hour":"Hour","minute":"Minute","second":"Seconds"}},"helpers":{"select":{"prompt":"Please select"},"submit":{"create":"Create %{model}","update":"Update %{model}","submit":"Save %{model}"}},"will_paginate":{"previous_label":"\u0026#8592; Previous","next_label":"Next \u0026#8594;","page_gap":"\u0026hellip;","page_entries_info":{"single_page":{"zero":"No %{model} found","one":"Displaying 1 %{model}","other":"Displaying all %{count} %{model}"},"single_page_html":{"zero":"No %{model} found","one":"Displaying \u003Cb\u003E1\u003C/b\u003E %{model}","other":"Displaying \u003Cb\u003Eall\u0026nbsp;%{count}\u003C/b\u003E %{model}"},"multi_page":"Displaying %{model} %{from} - %{to} of %{count} in total","multi_page_html":"Displaying %{model} \u003Cb\u003E%{from}\u0026nbsp;-\u0026nbsp;%{to}\u003C/b\u003E of \u003Cb\u003E%{count}\u003C/b\u003E in total"}},"devise":{"confirmations":{"confirmed":"Your account was successfully confirmed. You are now signed in.","send_instructions":"You will receive an email with instructions about how to confirm your account in a few minutes.","send_paranoid_instructions":"If your email address exists in our database, you will receive an email with instructions about how to confirm your account in a few minutes.","new":{"title":"Resend confirmation instructions"}},"failure":{"already_authenticated":"You are already signed in.","inactive":"Your account was not activated yet.","invalid":"Invalid email or password.","invalid_token":"Invalid authentication token.","locked":"Your account is locked.","not_found_in_database":"Invalid email or password.","timeout":"Your session expired, please sign in again to continue.","unauthenticated":"You need to sign in or sign up before continuing.","unconfirmed":"You have to confirm your account before continuing."},"mailer":{"confirmation_instructions":{"subject":"Confirmation instructions"},"reset_password_instructions":{"subject":"Reset password instructions"},"unlock_instructions":{"subject":"Unlock Instructions"}},"omniauth_callbacks":{"failure":"Could not authenticate you from %{kind} because \"%{reason}\".","success":"Successfully authenticated from %{kind} account."},"passwords":{"no_token":"You can't access this page without coming from a password reset email. If you do come from a password reset email, please make sure you used the full URL provided.","send_instructions":"You will receive an email with instructions about how to reset your password in a few minutes.","send_paranoid_instructions":"If your email address exists in our database, you will receive a password recovery link at your email address in a few minutes.","updated":"Your password was changed successfully. You are now signed in.","updated_not_active":"Your password was changed successfully."},"registrations":{"destroyed":"Bye! Your account was successfully cancelled. We hope to see you again soon.","signed_up":"Welcome! You have signed up successfully.","signed_up_but_inactive":"You have signed up successfully. However, we could not sign you in because your account is not yet activated.","signed_up_but_locked":"You have signed up successfully. However, we could not sign you in because your account is locked.","signed_up_but_unconfirmed":"A message with a confirmation link has been sent to your email address. Please open the link to activate your account.","update_needs_confirmation":"You updated your account successfully, but we need to verify your new email address. Please check your email and click on the confirm link to finalize confirming your new email address.","updated":"You updated your account successfully."},"sessions":{"signed_in":"Signed in successfully.","signed_out":"Signed out successfully."},"unlocks":{"send_instructions":"You will receive an email with instructions about how to unlock your account in a few minutes.","send_paranoid_instructions":"If your account exists, you will receive an email with instructions about how to unlock it in a few minutes.","unlocked":"Your account has been unlocked successfully. Please sign in to continue."}},"activemodel":{"errors":{"messages":{"invalid":"is invalid","invalid_event":"cannot transition when %{state}","invalid_transition":"cannot transition via \"%{event}\""}}},"gflash":{"titles":{"notice":"Notice","success":"Success","warning":"Warning","error":"Error","progress":"Progress"}},"translation":{"en":"English","pt-BR":"Portuguese"},"routes":null,"simple_form":{"yes":"Yes","no":"No","required":{"text":"required","mark":"*"},"error_notification":{"default_message":"Please review the problems below:"}},"validates_timeliness":{"error_value_formats":{"date":"%d/%m/%Y","time":"%H:%M:%S","datetime":"%d/%m/%y %H:%M:%S"}}},"pt-BR":{"devise":{"confirmations":{"confirmed":"Sua conta foi confirmada com sucesso. Você está logado.","send_instructions":"Dentro de minutos você receberá um e-mail com instruções para confirmar a sua conta.","send_paranoid_instructions":"Caso seu e-mail exista em nossa base, você receberá um e-mail em poucos minutos com instruções sobre como confirmar sua conta.","new":{"title":"Reenviar instruções de confirmação"}},"failure":{"already_authenticated":"Você já está logado.","inactive":"A sua conta não foi ativada ainda.","invalid":"E-mail ou senha inválidos.","invalid_token":"Token de autenticação inválido.","locked":"Sua conta está bloqueada.","not_found_in_database":"Email ou senha inválida.","timeout":"A sua sessão expirou, por favor faça login novamente para continuar.","unauthenticated":"Você precisa registrar-se ou fazer login para continuar.","unconfirmed":"Você deve confirmar sua conta antes de continuar."},"mailer":{"confirmation_instructions":{"subject":"Instruções para confirmação de conta"},"reset_password_instructions":{"subject":"Instruções para reinicialização de senha"},"unlock_instructions":{"subject":"Instruções para desbloqueio de conta"}},"omniauth_callbacks":{"failure":"Não foi possível autorizar você através do %{kind} porque \"%{reason}\".","success":"Autorizado com sucesso pela conta %{kind}."},"passwords":{"no_token":"Você não pode acessar esta página sem que seja a partir de um e-mail de reinicialização de senha. Se você chegou aqui através de um e-mail de reinicialização de senha, por favor verifique se você usou a URL completa que foi informada.","send_instructions":"Você receberá um e-mail com instruções sobre como reinicializar sua senha em poucos minutos.","send_paranoid_instructions":"Caso seu e-mail esteja cadastrado, você receberá um link para recuperação de senha no seu e-mail em poucos minutos.","updated":"Sua senha foi alterada com sucesso. Você está logado agora.","updated_not_active":"Sua senha foi alterada com sucesso."},"registrations":{"destroyed":"Até mais! Sua conta foi cancelada com sucesso. Esperamos vê-lo novamente em breve.","signed_up":"Bem-vindo! Você se registrou com sucesso.","signed_up_but_inactive":"Você se cadastrou com sucesso. Porém, sua conta ainda não está ativada.","signed_up_but_locked":"Você se cadastrou com sucesso. Porém, sua conta está bloqueada.","signed_up_but_unconfirmed":"Uma mensagem com um link de confirmação foi enviado para o seu e-mail. Por favor, abra o link para ativar sua conta.","update_needs_confirmation":"Você atualizou sua conta com sucesso, mas nós precisamos verificar seu endereço de e-mail. Por favor, verifique seus e-mails e clique no link de confirmação para finalizar a criação da sua conta.","updated":"Você atualizou sua conta com sucesso."},"sessions":{"signed_in":"Autenticado com sucesso.","signed_out":"Logout feito com sucesso."},"unlocks":{"send_instructions":"Você receberá um e-mail em poucos minutos com instruções sobre como desbloquear sua conta.","send_paranoid_instructions":"Caso sua e-mail exista em nossa base, você receberá um e-mail em poucos minutos com instruções sobre como desbloqueá-la.","unlocked":"Sua conta foi desbloqueada com sucesso. Por favor, faça login para continuar."},"shared":{"links":{"login":"Login","no_account_text":"Não possui conta ainda?","sign_up":"Criar","forgot_password":"Esqueceu sua senha?","no_confirmation_instructions":"Didn't receive confirmation instructions?","no_unlock_instructions":"Didn't receive unlock instructions?","sign_in_with_provider":"Sign in with %{provider_name}"}}},"errors":{"messages":{"already_confirmed":"já foi confirmado, por favor tente fazer login","confirmation_period_expired":"precisa ser confirmado em %{period}, solicite novamente por favor","expired":"expirou, por favor solicite um novo","not_found":"não encontrado","not_locked":"não estava bloqueado","not_saved":{"one":"1 erro impediu que %{resource} fosse salvo:","other":"%{count} erros impediram que %{resource} fosse salvo:"},"accepted":"deve ser aceito","blank":"não pode ficar em branco","present":"deve ficar em branco","confirmation":"não está de acordo com a confirmação","empty":"não pode ficar vazio","equal_to":"deve ser igual a %{count}","even":"deve ser par","exclusion":"não está disponível","greater_than":"deve ser maior que %{count}","greater_than_or_equal_to":"deve ser maior ou igual a %{count}","inclusion":"não está incluído na lista","invalid":"não é válido","less_than":"deve ser menor que %{count}","less_than_or_equal_to":"deve ser menor ou igual a %{count}","not_a_number":"não é um número","not_an_integer":"não é um número inteiro","odd":"deve ser ímpar","record_invalid":"A validação falhou: %{errors}","restrict_dependent_destroy":{"one":"Não é possível excluir o registro pois existe um %{record} dependente","many":"Não é possível excluir o registro pois existem %{record} dependentes"},"taken":"já está em uso","too_long":"é muito longo (máximo: %{count} caracteres)","too_short":"é muito curto (mínimo: %{count} caracteres)","wrong_length":"não possui o tamanho esperado (%{count} caracteres)"},"format":"%{attribute} %{message}","template":{"body":"Por favor, verifique o(s) seguinte(s) campo(s):","header":{"one":"Não foi possível gravar %{model}: 1 erro","other":"Não foi possível gravar %{model}: %{count} erros."}}},"date":{"abbr_day_names":["Dom","Seg","Ter","Qua","Qui","Sex","Sáb"],"abbr_month_names":[null,"Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez"],"day_names":["Domingo","Segunda","Terça","Quarta","Quinta","Sexta","Sábado"],"formats":{"default":"%d/%m/%Y","long":"%d de %B de %Y","short":"%d de %B"},"month_names":["Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"],"order":["day","month","year"]},"datetime":{"distance_in_words":{"about_x_hours":{"one":"aproximadamente 1 hora","other":"aproximadamente %{count} horas"},"about_x_months":{"one":"aproximadamente 1 mês","other":"aproximadamente %{count} meses"},"about_x_years":{"one":"aproximadamente 1 ano","other":"aproximadamente %{count} anos"},"almost_x_years":{"one":"quase 1 ano","other":"quase %{count} anos"},"half_a_minute":"meio minuto","less_than_x_minutes":{"one":"menos de um minuto","other":"menos de %{count} minutos"},"less_than_x_seconds":{"one":"menos de 1 segundo","other":"menos de %{count} segundos"},"over_x_years":{"one":"mais de 1 ano","other":"mais de %{count} anos"},"x_days":{"one":"1 dia","other":"%{count} dias"},"x_minutes":{"one":"1 minuto","other":"%{count} minutos"},"x_months":{"one":"1 mês","other":"%{count} meses"},"x_seconds":{"one":"1 segundo","other":"%{count} segundos"}},"prompts":{"day":"Dia","hour":"Hora","minute":"Minuto","month":"Mês","second":"Segundo","year":"Ano"}},"helpers":{"select":{"prompt":"Por favor selecione"},"submit":{"create":"Criar %{model}","submit":"Salvar %{model}","update":"Atualizar %{model}"}},"number":{"currency":{"format":{"delimiter":".","format":"%u %n","precision":2,"separator":",","significant":false,"strip_insignificant_zeros":false,"unit":"R$"}},"format":{"delimiter":".","precision":3,"separator":",","significant":false,"strip_insignificant_zeros":false},"human":{"decimal_units":{"format":"%n %u","units":{"billion":{"one":"bilhão","other":"bilhões"},"million":{"one":"milhão","other":"milhões"},"quadrillion":{"one":"quatrilhão","other":"quatrilhões"},"thousand":"mil","trillion":{"one":"trilhão","other":"trilhões"},"unit":""}},"format":{"delimiter":".","precision":2,"significant":true,"strip_insignificant_zeros":true},"storage_units":{"format":"%n %u","units":{"byte":{"one":"Byte","other":"Bytes"},"gb":"GB","kb":"KB","mb":"MB","tb":"TB"}}},"percentage":{"format":{"delimiter":"."}},"precision":{"format":{"delimiter":"."}}},"support":{"array":{"last_word_connector":" e ","two_words_connector":" e ","words_connector":", "}},"time":{"am":"","formats":{"default":"%a, %d de %B de %Y, %H:%M:%S %z","long":"%d de %B de %Y, %H:%M","short":"%d de %B, %H:%M","only_time":"%H:%M"},"pm":""},"activemodel":{"errors":{"format":"%{attribute} %{message}","messages":{"accepted":"deve ser aceito","blank":"não pode ficar em branco","present":"deve ficar em branco","confirmation":"não está de acordo com a confirmação","empty":"não pode ficar vazio","equal_to":"deve ser igual a %{count}","even":"deve ser par","exclusion":"não está disponível","greater_than":"deve ser maior que %{count}","greater_than_or_equal_to":"deve ser maior ou igual a %{count}","inclusion":"não está incluído na lista","invalid":"não é válido","less_than":"deve ser menor que %{count}","less_than_or_equal_to":"deve ser menor ou igual a %{count}","not_a_number":"não é um número","not_an_integer":"não é um número inteiro","odd":"deve ser ímpar","record_invalid":"A validação falhou: %{errors}","restrict_dependent_destroy":{"one":"Não é possível excluir o registro pois existe um %{record} dependente","many":"Não é possível excluir o registro pois existem %{record} dependentes"},"taken":"já está em uso","too_long":"é muito longo (máximo: %{count} caracteres)","too_short":"é muito curto (mínimo: %{count} caracteres)","wrong_length":"não possui o tamanho esperado (%{count} caracteres)"},"template":{"body":"Por favor, verifique o(s) seguinte(s) campo(s):","header":{"one":"Não foi possível gravar %{model}: 1 erro","other":"Não foi possível gravar %{model}: %{count} erros."}}}},"activerecord":{"errors":{"format":"%{attribute} %{message}","messages":{"accepted":"deve ser aceito","blank":"não pode ficar em branco","present":"deve ficar em branco","confirmation":"não está de acordo com a confirmação","empty":"não pode ficar vazio","equal_to":"deve ser igual a %{count}","even":"deve ser par","exclusion":"não está disponível","greater_than":"deve ser maior que %{count}","greater_than_or_equal_to":"deve ser maior ou igual a %{count}","inclusion":"não está incluído na lista","invalid":"não é válido","less_than":"deve ser menor que %{count}","less_than_or_equal_to":"deve ser menor ou igual a %{count}","not_a_number":"não é um número","not_an_integer":"não é um número inteiro","odd":"deve ser ímpar","record_invalid":"A validação falhou: %{errors}","restrict_dependent_destroy":{"one":"Não é possível excluir o registro pois existe um %{record} dependente","many":"Não é possível excluir o registro pois existem %{record} dependentes"},"taken":"já está em uso","too_long":"é muito longo (máximo: %{count} caracteres)","too_short":"é muito curto (mínimo: %{count} caracteres)","wrong_length":"não possui o tamanho esperado (%{count} caracteres)"},"template":{"body":"Por favor, verifique o(s) seguinte(s) campo(s):","header":{"one":"Não foi possível gravar %{model}: 1 erro","other":"Não foi possível gravar %{model}: %{count} erros."}}},"models":{"activity":"Atividade","calendar":"Calendário","calendar_event_source":"Matéria do Calendário","calendar_event":"Evento do Calendário","follow_up_item":"Item de Acompanhamento","group":"Grupo de Estudos","notification":"Notificação","notification_setting":"Configuração de Notificação","setting":"Configuração","study_source":"Fonte de Estudo","study_time":"Tempo de Estudo","subject":"Matéria","task":"Tarefa","timetable":"Grade de Tempo","user":"Usuário"},"attributes":{"activity":{"type":"Tipo"},"calendar":null,"calendar_event_source":{"color":"Cor"},"calendar_event":{"date":"Data","from_time":"Tempo de Início","to_time":"Tempo de Término","repeats":"Repetição","repeats_every_n_days":"Intervalo de dias","repeats_every_n_weeks":"Intervalo de semanas","repeats_weekly_each_days_of_the_week_mask":"Dias da semana a repetir","repeats_every_n_months":"Intervalo de meses","repeats_monthly":"Repete mensalmente","repeats_monthly_each_days_of_the_month_mask":"Dias do mês a repetir","repeats_monthly_on_ordinals_mask":"Repete mensalmente nos","repeats_monthly_on_days_of_the_week_mask":"Dias da semana do mês","repeats_every_n_years":"Intervalo de anos","repeats_yearly_each_months_of_the_year_mask":"Meses do ano","repeats_yearly_on":"Repete anualmente em","repeats_yearly_on_ordinals_mask":"Repete anualmente nos","repeats_yearly_on_days_of_the_week_mask":"Dias da semana do ano","repeat_ends":"Termina","repeat_ends_on":"Data de término","repeat_ends_count":"Quantidade de repetições","interval":"Intervalo"}}},"translation":{"en":"Inglês","pt-BR":"Português"},"buttons":{"back":"Voltar","submit":"Enviar","login":"Login","resend":"Reenviar","close":"Fechar","ok":"Ok","add":"Adicionar","continue":"Continuar"},"shared":{"form_error_messages":{"contains_errors":{"one":"O formulário contém 1 erro","other":"O formulário contém %{count} erros"}}},"enumerize":{"notification_preferences":{"type":null,"send_to":null}},"static_pages":null,"authenticated":{"header":{"new_notifications_count":"Você tem %{count} novas notificações","see_all_notifications":"Ver todas notificações","pending_tasks_count":"Você tem %{count} tarefas pendentes","see_all_tasks":"Ver todas tarefas","my_profile":"Meu Perfil","my_timetables":"Minhas Grades","follow_up":"Acompanhamento","my_settings":"Minhas Configurações","full_screen":"Tela cheia","log_out":"Sair"}},"calendar_event_sources":{"index":{"table_label":{"subject":"Matéria","color":"Cor","edit":"Editar","delete":"Excluir"}}},"calendar_events":{"form_modal":{"title":"Novo Evento","delete":"Excluir","tab":{"general":"Geral","schedule":"Repetições"}},"form_modal_complete":{"title":"Completar Evento","question":"Você estudou todo o conteúdo, conforme o planejado?","answer_yes":"Sim","answer_no":"Não","studied_time_label":"Quanto tempo você estudou?","studied_time_hint":"max. %{meta} mins."},"form_modal_general":{"interval_hint":"Tempo total de intervalo","use_revisions":"Usar revisões espaçadas"},"schedule":{"repeats_monthly_options":{"each":"Cada","on_the":"Nos"},"repeats_weekly_options":{"each":"Cada"},"repeats_yearly_options":{"each":"Cada","on_the":"Nos"}}},"calendars":{"calendar_portlet":{"title":"Calendário","options":"Opções","buttons":{"add_event":"Adicionar Evento","subjects":"Matérias"}}},"dashboard":{"no_timetable":{"no_active_timetable":"It looks like you don't have any active timetable at the moment.","create_click_below":"But don't worry! You can create one clicking below.","tour":"If you want to make a tour through the system, click in the button below.","buttons":{"create_timetable":"Create my timetable!","make_tour":"Make Tour!"}},"stats":{"title":"General Stats"}},"follow_up":{"studied_with_debt":{"table_label":{"date":"Data","subject":"Matéria","meta":"Meta","studied_time":"Tempo Estudado","debt_reason":"Razão do Débito"}},"studied":{"table_label":{"date":"Data","subject":"Matéria","meta":"Meta","studied_time":"Tempo Estudado"}},"to_study":{"table_label":{"date":"Data","time":"Tempo","subject":"Matéria","meta":"Meta","complete":"Completar"}},"index":{"title":"Acompanhamento","tabs":{"studied_with_debt":"Estudado com débito","studied":"Estudado","to_study":"À estudar"},"filter":{"change_range":"Mudar período"}}},"notifications":{"index":{"title":"Notificações"}},"notification":{"task":{"before_overdue":"Sua tarefa %{task} expirará em breve"},"follow_up":{"next_day":"Verifique o que você tem para estudar amanhã na sua timetable %{timetable}","next_month":"Verifique o que você tem para estudar no próximo mês na sua timetable %{timetable}","past_month":"Verifique o que você estudou durante o mês passado na sua timetable %{timetable}"},"group":{"invitation":null}},"reports":{"index":{"results_for":"Mostrando resultados para a grade"},"follow_up_not_studied_reason":{"title":"Razões para não estudar"}},"settings":{"index":{"tabs":{"general":{"label":"Geral","text":"Geral"},"notifications":{"label":"Notificações","text":"Receber notificações quando alguém...","site":"Site","email":"E-Mail","phone":"Celular"}}}},"study_sources":{"form_modal":{"title":"Fonte de Estudo"},"index":{"table_label":{"type":"Tipo","title":"Título","author":"Autor","edit":"Alterar","delete":"Excluir"}},"create":{"create_successful":"A fonte de estudo foi criada com sucesso."},"update":{"update_successful":"A fonte de estudo foi atualizada com sucesso."}},"subject_groups":{"index":{"available_subjects":"Matérias Disponíveis","new_group":"Novo Grupo"},"subject_group":{"delete_confirmation":"Você tem certeza?"}},"subjects":{"index":{"buttons":{"subject_groups":"Grupos","view_study_sources":"Ver (%{count})"},"table_label":{"name":"Nome","importance":"Importância","difficulty":"Dificuldade","study_sources":"Fontes de Estudo","edit":"Alterar","delete":"Excluir"}},"form_modal":{"title":"Matéria"},"study_sources":{"title":"Fontes de Estudo para %{subject}"},"update_study_sources":{"update_successful":"Suas fontes de estudo foram atualizados com sucesso."},"update":{"update_successful":"A matéria foi atualizada com sucesso."}},"tasks":{"form_modal":{"title":"Tarefa"},"index":{"title":"Tarefas","more_options":"Mais","list":{"all":"Todas","pending":"Pendentes","overdue":"Expiradas","completed":"Completas"},"new_task":"Nova Tarefa"},"task":{"delete_task":"Excluir","more_options":"Mais"}},"timetables":{"initial_data":{"title":"Coloque algumas informações gerais sobre a grade"},"study_time":{"title":"Coloque sua disponibilidade de estudo","new_time":"Novo Tempo","study_times":"Tempos de Estudo","options":"Opções","use_pomodoro":"Usar a técnica de Pomodoro","use_repetition":"Usar repetição espaçada"},"subjects_study_sources":{"title":"Matérias e Fontes de Estudo"},"timetable":{"active":" (ativa)","event_sources":"Matérias associadas","make_active":"Fazer desta a grade ativa"},"create":null,"index":{"title":"Grades de Tempo"},"new":{"planning_phase":"Fase de Planejamento -","phases":{"initial_data":{"number":1,"text":"Dados Iniciais"},"availability":{"number":2,"text":"Disponibilidade"},"subjects":{"number":3,"text":"Matérias"},"confirmation":{"number":4,"text":"Confirmação"}}},"no_timetable":{"no_active_timetable":"It looks like you don't have any active timetable at the moment.","create_click_below":"But don't worry! You can create one clicking below.","buttons":{"create_timetable":"Create my timetable!"}}},"navigation":{"items":{"dashboard":"Painel","planning":{"title":"Planejamento","subjects":"Matérias","subject_groups":"Grupos de Matéria","study_sources":"Fontes de Estudo"},"timetables":"Grades de Tempo","follow_up":"Acompanhamento","reports":"Relatórios","groups":"Grupos","settings":"Configurações"}},"datepicker":{"dformat":"%d/%m/%Y","pformat":"dd/mm/yyyy","weekstart":5},"timepicker":{"dformat":"%R","pformat":"hh:mm"},"repetitions":{"options":{"Nunca":"never","Diariamente":"daily","Semanalmente":"weekly","Mensalmente":"monthly","Anualmente":"yearly"},"end_options":{"Nunca":"never","Em":"on","Quantidade":"count"},"monthly_options":{"Cada":"each","Em":"on"},"ordinals":["Primeiro","Segundo","Terceiro","Quarto","Último"]},"routes":{"new":"novo","edit":"editar","destroy":"destruir","about":"sobre","tasks":"tarefas","list_all":"listar_todas","list_pending":"listar_pendentes","list_done":"listar_concluidas","list_overdue":"listar_vencidas","users":"usuarios","register":"registrar"},"simple_form":{"yes":"Sim","no":"Não","required":{"text":"obrigatório","mark":"*"},"error_notification":{"default_message":"Por favor, verifique os problemas abaixo:"},"labels":{"defaults":{"password":"Password"},"user":{"new":{"email":"E-mail to sign in."},"edit":{"email":"E-mail."}}},"hints":{"defaults":{"username":"User name to sign in.","password":"No special characters, please."}},"placeholders":null}}};