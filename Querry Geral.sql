SELECT
  Tpa.Ds_Tip_Acom               AS Acomodacao_Tipo,
  CA.Ds_Carater_Atendimento     AS Atendimento_Carater,
  Esp.Ds_Especialid             AS Atendimento_Especialidade,
  Ai.Ds_Info_Atendimento        AS Atendimento_Informacao,
  OA.ds_ori_ate                 AS Atendimento_Origem,
  Ca.Nm_Titular                 AS Carteira_Nome_Titular,
  Ca.Nr_Carteira                AS Carteira_Numero,
  Cd.Cd_Cid                     AS CID_Codigo,
  Cd.Ds_Cid                     AS CID_Descricao,
  P.nr_cns                      AS CNS_Numero,
  Co.Nm_Convenio                AS Convenio_Nome,
  G.Nr_Guia                     AS Guia_Numero,
  G.Cd_Senha                    AS Guia_Senha,
  TI.Ds_Tipo_Internacao         AS Internacao_Tipo,
  unid.ds_unid_int              AS Internacao_Unidade,
  L.Ds_resumo                   AS Paciente_Acomodacao,
  P.Nm_Bairro                   AS Paciente_Bairro,
  P.Nr_Cep                      AS Paciente_CEP,
  C.Nm_Cidade                   AS Paciente_Cidade,
  C.cd_ibge || C.nr_digito_ibge AS Paciente_Cidade_IBGE,
  P.Nr_Cpf                      AS Paciente_CPF,
  P.Dt_Nascimento               AS Paciente_Data_Nascimento,
  P.Ds_Endereco                 AS Paciente_Endereco,
  C.Cd_Uf                       AS Paciente_Estado,
  P.Nr_Identidade               AS Paciente_Identidade,
  P.Ds_Complemento              AS Paciente_Logradouro,
  P.Nm_Conjuge                  AS Paciente_Nome_Conjuge,
  P.Nm_Mae                      AS Paciente_Nome_Mae,
  P.Nm_Pai                      AS Paciente_Nome_Pai,
  P.Nm_social_paciente          AS Paciente_Nome_Social,
  P.Nr_Endereco                 AS Paciente_Numero_Endereco,
  P.Ds_Om_Identidade            AS Paciente_Orgao_Emissor,
  Pr.Nm_Profissao               AS Paciente_Profissao,
  A.Cd_Paciente                 AS Paciente_Prontuario,
  RC.Nm_Raca_Cor                AS Paciente_Raca,
  TS.Nm_Sexo                    AS Paciente_Sexo,
  TP.Ds_Tip_Paren               AS Paciente_Tipo_Parente,
  CP.Ds_Con_Pla                 AS Plano_Descricao,
  M.Nr_cns                      AS Prestador_CNS,
  M.ds_codigo_conselho          AS Prestador_Conselho_codigo,
  Cons.Ds_Conselho              AS Prestador_Conselho_Descricao,
  M.Nm_Prestador                AS Prestador_Nome,
  Pro.Cd_Pro_Fat                AS Procedimento_Codigo,
  Pro.Ds_Pro_Fat                AS Procedimento_Descricao,
  R.Nr_Fone                     AS Responsavel_Telefone2,
  A.Nm_Usuario                  AS Usuario_Recepcao,
  --Novos
  M.Nr_Cpf_Cgc                  AS Prestador_CPF,
  M.Nr_Documento                AS Prestador_RG,
  M.Cd_Uf_Orgao_Emissor         AS Prestador_RG_UF_Orgao_Emissor,
  M.Ds_Om_Identidade            AS Prestador_RG_Orgao_Emissor,
  M.Dt_Expedicao_Orgao_Emissor  AS Prestador_RG_Data_Expedicao,
  M.Nm_Mae                      AS Prestador_Nome_Mae,
  M.Nm_Pai                      AS Prestador_Nome_Pai,
  M.Dt_Nascimento               AS Prestador_Data_Nascimento,
  M.Cd_Naturalidade             AS Prestador_Codigo_Naturalidade,
  M.Tp_Sexo                     AS Prestador_Sexo,
  M.Tp_Cor                      AS Prestador_Cor,
  M.Nr_Cns                      AS Prestador_CNS,
  M.Ds_Endereco                 AS Prestador_Endereco,
  M.Nr_Endereco                 AS Prestador_Numero_Endereco,
  M.Ds_Bairro                   AS Prestador_Bairro,
  CidPrest.Nm_Cidade             AS Prestador_Cidade,
  M.Ds_Complemento              AS Prestador_Complemento,
  M.Nr_Cep                      AS Prestador_CEP,
  Cidn.Ds_Cidadania              AS Prestador_Cidadania,
  CidPrest.Cd_Uf                AS Prestador_Estado,
  CidPais.Nm_Pais               AS Prestador_Pais,
-- Diretos
  LPAD(A.Cd_Atendimento, 8, '0') AS Atendimento_Codigo,
  dbamv.Fn_Idade(P.Dt_Nascimento, 'a A m M d D') AS Paciente_Idade,
  DBAMV.Fn_Idade(P.Dt_Nascimento, 'a') || ' anos' AS Paciente_Idade_Curta,
-- To CHARS
  TO_CHAR(A.DT_Alta, 'DD/MM/YYYY')        AS Atendimento_Data_Alta_Hospitalar,
  TO_CHAR(A.DT_Alta_Medica, 'DD/MM/YYYY') AS Atendimento_Data_Alta_Medica,
  TO_CHAR(A.DT_ATENDIMENTO, 'DD/MM/YYYY') AS Atendimento_Data,
  TO_CHAR(A.Hr_Atendimento, 'HH24:MI')    AS Atendimento_Hora,
  TO_CHAR(Ca.Dt_Validade, 'DD/MM/YYYY')   AS Carteira_Validade,
  TO_CHAR(SYSDATE, 'DD/MM/YYYY') AS Data_Atual,
  TO_CHAR(SYSDATE, 'DD/MM/YYYY - HH24:MI:SS') AS Data_Hora_Atual,
  TO_CHAR(SYSDATE, 'HH24:MI:SS') AS Hora_Atual,
  TO_CHAR(P.Dt_Nascimento, 'DD/MM/YYYY') AS Paciente_Data_Nascimento_Curta,
  --Novos
  TO_CHAR(M.Dt_Nascimento, 'DD/MM/YYYY') AS Prestador_Data_Nascimento_Curta,
-- COALESCE
  COALESCE(R.Nm_Responsavel, P.Nm_Paciente) AS Responsavel_Nome,
  COALESCE('(' || P.Nr_Ddd_Celular || ')' || ' ' || P.Nr_Celular,'(' || P.Nr_Ddd_Fone || ')' || ' ' || P.Nr_Fone
  ) AS Responsavel_Tel,
-- CASES
CASE 
  WHEN A.DT_ATENDIMENTO IS NOT NULL AND A.DT_Alta_medica IS NOT NULL 
  THEN TO_CHAR(A.DT_ATENDIMENTO, 'DD/MM/YYYY') || ' á ' || TO_CHAR(A.DT_Alta_medica, 'DD/MM/YYYY')
  WHEN A.DT_ATENDIMENTO IS NOT NULL AND A.DT_Alta_medica IS NULL 
  THEN TO_CHAR(A.DT_ATENDIMENTO, 'DD/MM/YYYY')
  WHEN A.DT_ATENDIMENTO IS NULL AND A.DT_Alta_medica IS NOT NULL 
  THEN TO_CHAR(A.DT_Alta_medica, 'DD/MM/YYYY')
  ELSE NULL
END AS Atendimento_Periodo,
CASE 
  WHEN Cd.Cd_Cid IS NOT NULL AND Cd.Ds_Cid IS NOT NULL 
  THEN '[' || Cd.Cd_Cid || '] - ' || Cd.Ds_Cid
ELSE NULL
END AS CID_Completo,
CASE A.Tp_Carater_Internacao 
  WHEN 'E' THEN 'ELETIVO' 
  WHEN 'U' THEN 'URGENCIA' 
END AS Internacao_Carater,
CASE 
  WHEN P.Nr_Ddd_Celular IS NOT NULL AND P.Nr_Celular IS NOT NULL 
  THEN '(' || P.Nr_Ddd_Celular || ') ' || P.Nr_Celular
ELSE NULL
END AS Paciente_Celular,
CASE P.Tp_Estado_Civil
  WHEN 'C' THEN 'CASADO'
  WHEN 'S' THEN 'SOLTEIRO'
  WHEN 'V' THEN 'VIUVO'
  WHEN 'D' THEN 'DESQUITADO'
  WHEN 'I' THEN 'DIVORCIADO'
  WHEN 'U' THEN 'UNIÃO ESTAVEL'
END AS Paciente_Estado_Civil,
CASE 
  WHEN P.sn_utiliza_nome_social = 'S' THEN P.Nm_Social_Paciente 
  ELSE P.Nm_Paciente 
END AS Paciente_Nome,
CASE 
  WHEN P.Nr_Ddd_Fone IS NOT NULL AND P.Nr_Fone IS NOT NULL 
  THEN '(' || P.Nr_Ddd_Fone || ') ' || P.Nr_Fone
  ELSE NULL
END AS Paciente_Telefone_Fixo,
CASE 
  WHEN Pro.Cd_Pro_Fat IS NOT NULL AND Pro.Ds_Pro_Fat IS NOT NULL 
  THEN '[' || Pro.Cd_Pro_Fat || '] - ' || Pro.Ds_Pro_Fat
  ELSE NULL
END AS Procedimento_Completo,
CASE 
  WHEN R.Nm_Responsavel IS NOT NULL 
  THEN R.Ds_Endereco || ' ,' || R.Nr_Endereco || ' - ' || R.Nm_Bairro || ' - ' || Cdd.Nm_Cidade || ' ' || Cdd.Cd_Uf
  ELSE P.Ds_Endereco || ' ,' || P.Nr_Endereco || ' - ' || P.Nm_Bairro
END AS Responsavel_Endereco
-- JOINS
FROM dbamv.Atendime A
LEFT JOIN dbamv.Paciente P ON P.Cd_Paciente = A.Cd_Paciente
LEFT JOIN dbamv.Carteira Ca ON Ca.Cd_Paciente = A.Cd_Paciente 
AND Ca.Cd_Convenio = A.Cd_Convenio 
AND Ca.Cd_Con_Pla = A.Cd_Con_Pla
LEFT JOIN dbamv.Profissao Pr ON Pr.Cd_Profissao = P.Cd_Profissao
LEFT JOIN dbamv.Cidade C ON C.Cd_Cidade = P.Cd_Cidade
LEFT JOIN dbamv.Responsa R ON R.Cd_Atendimento = A.Cd_Atendimento
LEFT JOIN dbamv.Cidade Cdd ON Cdd.Cd_Cidade = R.Cd_Cidade
LEFT JOIN dbamv.Leito L ON L.Cd_Leito = A.Cd_Leito
LEFT JOIN dbamv.Unid_int unid ON unid.cd_unid_int = L.cd_unid_int
LEFT JOIN dbamv.Prestador M ON M.Cd_Prestador = A.Cd_Prestador
LEFT JOIN dbamv.Cidade CidPrest ON CidPrest.Cd_Cidade = M.Cd_Cidade
LEFT JOIN dbamv.Pais CidPais ON CidPais.Cd_Pais = CidPrest.Cd_Pais
LEFT JOIN dbamv.Cidadanias Cidn ON Cidn.Cd_Cidadania = M.Cd_Cidadania
LEFT JOIN dbamv.conselho Cons ON Cons.Cd_Conselho = M.Cd_conselho
LEFT JOIN dbamv.Cid Cd ON Cd.Cd_Cid = A.Cd_Cid
LEFT JOIN dbamv.Convenio Co ON Co.Cd_Convenio = A.Cd_Convenio
LEFT JOIN dbamv.Guia G ON G.Cd_Atendimento = A.Cd_Atendimento
LEFT JOIN dbamv.Tip_Acom Tpa ON Tpa.Cd_Tip_Acom = L.Cd_Tip_Acom
LEFT JOIN dbamv.Especialid Esp ON Esp.Cd_Especialid = A.Cd_Especialid
LEFT JOIN dbamv.Atendime_Info Ai ON Ai.Cd_Atendimento = A.Cd_Atendimento
LEFT JOIN dbamv.Pro_Fat Pro ON Pro.Cd_Pro_Fat = A.Cd_Pro_Int
LEFT JOIN dbamv.Tip_Paren TP ON TP.Cd_Tip_Paren = R.Cd_Tip_Paren
LEFT JOIN dbamv.Ori_ate OA ON OA.Cd_Ori_ate = A.Cd_Ori_ate
LEFT JOIN dbamv.Tipo_Sexo TS ON TS.Tp_sexo = P.Tp_sexo
LEFT JOIN dbamv.Raca_Cor RC ON RC.Tp_Cor = P.Tp_Cor
LEFT JOIN dbamv.Carater_atendimento CA ON CA.Cd_Carater_atendimento = A.Cd_Carater_Atendimento
LEFT JOIN dbamv.Tipo_internacao TI ON TI.Cd_Tipo_Internacao = A.Cd_Tipo_Internacao
LEFT JOIN dbamv.Con_Pla CP ON CP.Cd_Convenio = A.Cd_Convenio 
AND CP.Cd_Con_Pla = A.Cd_Con_Pla
WHERE A.Cd_Atendimento = {(cdAtendimento)}