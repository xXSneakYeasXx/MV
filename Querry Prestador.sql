SELECT
  M.Nm_Prestador                AS Prestador_Nome,
  M.Nr_Cpf_Cgc                  AS Prestador_CPF,
  M.Nr_Documento                AS Prestador_RG,
  M.Ds_Om_Identidade            AS Prestador_RG_Orgao_Emissor,
  M.Cd_Uf_Orgao_Emissor         AS Prestador_RG_Estado_Orgao_Emissor,
  M.Nm_Mae                      AS Prestador_Nome_Mae,
  M.Nm_Pai                      AS Prestador_Nome_Pai,
  RC.Nm_Raca_Cor                AS Prestador_Cor,
  M.Nr_Cns                      AS Prestador_CNS,
  M.ds_codigo_conselho          AS Prestador_Conselho_Numero,
  Cons.Ds_Conselho              AS Prestador_Conselho_Descricao,
  Cidn.Ds_Cidadania             AS Prestador_Cidadania,
  M.Ds_Bairro                   AS Prestador_Bairro,
  M.Ds_Complemento              AS Prestador_Complemento,
  M.Nr_Cep                      AS Prestador_CEP,
  CidPrest.Nm_Cidade            AS Prestador_Cidade,
  CidPrest.Cd_Uf                AS Prestador_Estado,
  CidPais.Nm_Pais               AS Prestador_Pais,
  TS.Nm_Sexo                    AS Prestador_Sexo,
  RC.Nm_Raca_Cor                AS Paciente_Raca,
  Cons.Cd_UF                    AS Prestador_Conselho_Estado,
  F.Nm_Fornecedor               AS Prestador_Razao_Social,
  F.Nr_Cgc_Cpf                  AS Prestador_CNPJ,
  CidNat.Nm_Cidade              AS Prestador_Nascimento_Cidade,
  PaisNat.Nm_Pais               AS Prestador_Nascimento_Pais,
  EstNat.Nm_Estado              AS Prestador_Nascimento_Estado,
-- LISTAGG (lista uma por linha)
(SELECT LISTAGG(PC.Cd_Cbo, CHR(10)) WITHIN GROUP (ORDER BY PC.Cd_Cbo)
  FROM dbamv.Prestador_CBO PC
WHERE PC.Cd_Prestador = M.Cd_Prestador) AS Prestador_CBO_Codigos,

(SELECT LISTAGG(C.Ds_Cbos, CHR(10)) WITHIN GROUP (ORDER BY PC.Cd_Cbo)
  FROM dbamv.Prestador_CBO PC
  LEFT JOIN dbamv.CBO C ON C.Cd_Cbos = PC.Cd_Cbo
WHERE PC.Cd_Prestador = M.Cd_Prestador) AS Prestador_Especialidades,

(SELECT LISTAGG(PC.Qt_Horas_Sia, CHR(10)) WITHIN GROUP (ORDER BY PC.Cd_Cbo)
  FROM dbamv.Prestador_CBO PC
WHERE PC.Cd_Prestador = M.Cd_Prestador) AS Prestador_Horas_SIA,

(SELECT LISTAGG(PC.Qt_Horas_Sih, CHR(10)) WITHIN GROUP (ORDER BY PC.Cd_Cbo)
  FROM dbamv.Prestador_CBO PC
WHERE PC.Cd_Prestador = M.Cd_Prestador) AS Prestador_Horas_SIH,

(SELECT LISTAGG(NVL(PC.Qt_Horas_Outros, 0), CHR(10)) WITHIN GROUP (ORDER BY PC.Cd_Cbo)
  FROM dbamv.Prestador_CBO PC
WHERE PC.Cd_Prestador = M.Cd_Prestador) AS Prestador_Horas_Outros,
--Select MAX
(SELECT MAX(VC.Ds_Vinculo_Cnes)
  FROM dbamv.Prestador_CBO PC
  LEFT JOIN dbamv.Vinculo_Cnes VC
  ON VC.Cd_Vinculo_Cnes = PC.Cd_Vinculo_Cnes
WHERE PC.Cd_Prestador = M.Cd_Prestador) AS Prestador_Vinculo,
-- Diretos
  DBAMV.Fn_Idade(M.Dt_Nascimento,'a') || ' anos' AS Prestador_Idade_Curta,
-- To CHARS
  TO_CHAR(M.Dt_Nascimento,'DD/MM/YYYY') AS Prestador_Data_Nascimento,
  TO_CHAR(M.Dt_Expedicao_Orgao_Emissor,'DD/MM/YYYY') AS Prestador_RG_Data_Expedicao,
  TO_CHAR(SYSDATE,'DD/MM/YYYY') AS Data_Atual,
  TO_CHAR(SYSDATE,'DD/MM/YYYY - HH24:MI:SS') AS Data_Hora_Atual,
  TO_CHAR(SYSDATE,'HH24:MI:SS') AS Hora_Atual,
  TO_CHAR(M.Dt_Inicio_Contrato, 'DD/MM/YYYY') AS Prestador_Inicio_Contrato,
  TO_CHAR(M.Dt_Final_Contrato, 'DD/MM/YYYY') AS Prestador_Fim_Contrato,
-- CASES
CASE
  WHEN TelPrest.Nr_Ddd_Celular IS NOT NULL AND TelPrest.Ds_Tip_Comun_Prest IS NOT NULL
  THEN '(' || TelPrest.Nr_Ddd_Celular || ') ' || TelPrest.Ds_Tip_Comun_Prest
  ELSE TelPrest.Ds_Tip_Comun_Prest
END AS Prestador_Celular,
CASE
  WHEN TelComer.Nr_Ddd_Celular IS NOT NULL AND TelComer.Ds_Tip_Comun_Prest IS NOT NULL
  THEN '(' || TelComer.Nr_Ddd_Celular || ') ' || TelComer.Ds_Tip_Comun_Prest
  ELSE TelComer.Ds_Tip_Comun_Prest
END AS Prestador_Telefone_Comercial,
CASE
  WHEN TelRes.Nr_Ddd_Celular IS NOT NULL AND TelRes.Ds_Tip_Comun_Prest IS NOT NULL
  THEN '(' || TelRes.Nr_Ddd_Celular || ') ' || TelRes.Ds_Tip_Comun_Prest
  ELSE TelRes.Ds_Tip_Comun_Prest
END AS Prestador_Telefone_Residencial,
CASE
  WHEN M.Ds_Endereco IS NOT NULL
   AND M.Nr_Endereco IS NOT NULL
  THEN M.Ds_Endereco || ', ' || M.Nr_Endereco
  WHEN M.Ds_Endereco IS NOT NULL
  THEN M.Ds_Endereco
  ELSE M.Nr_Endereco
END AS Prestador_Endereco,
CASE
  WHEN EXISTS (SELECT 1 FROM dbamv.Prestador_CBO PC
  WHERE PC.Cd_Prestador = M.Cd_Prestador)
  THEN 'SIM' ELSE 'NÃO'
END AS Prestador_Atende_SUS
-- JOINS
FROM dbamv.Prestador M
LEFT JOIN dbamv.Cidade CidNat ON CidNat.Cd_Cidade = M.Cd_Naturalidade
LEFT JOIN dbamv.Pais PaisNat ON PaisNat.Cd_Pais = CidNat.Cd_Pais
LEFT JOIN dbamv.Estado EstNat ON EstNat.Cd_Estado = CidNat.Cd_Estado
LEFT JOIN dbamv.Empresa_Prestador EP ON EP.Cd_Prestador = M.Cd_Prestador
LEFT JOIN dbamv.Fornecedor F ON F.Cd_Fornecedor = EP.Cd_Fornecedor
LEFT JOIN dbamv.Cidade CidPrest ON CidPrest.Cd_Cidade = M.Cd_Cidade
LEFT JOIN dbamv.Pais CidPais ON CidPais.Cd_Pais = CidPrest.Cd_Pais
LEFT JOIN dbamv.Cidadanias Cidn ON Cidn.Cd_Cidadania = M.Cd_Cidadania
LEFT JOIN dbamv.Conselho Cons ON Cons.Cd_Conselho = M.Cd_Conselho
LEFT JOIN dbamv.Tipo_Sexo TS ON TS.Tp_Sexo = M.Tp_Sexo
LEFT JOIN dbamv.Raca_Cor RC ON RC.Tp_Cor = M.Tp_Cor
LEFT JOIN dbamv.Prestador_Tip_Comun TelPrest ON TelPrest.Cd_Prestador = M.Cd_Prestador AND TelPrest.Cd_Tip_Comun = 3
LEFT JOIN dbamv.Prestador_Tip_Comun EmailPrest ON EmailPrest.Cd_Prestador = M.Cd_Prestador AND EmailPrest.Cd_Tip_Comun = 7
LEFT JOIN dbamv.Prestador_Tip_Comun TelComer ON TelComer.Cd_Prestador = M.Cd_Prestador AND TelComer.Cd_Tip_Comun = 1
LEFT JOIN dbamv.Prestador_Tip_Comun TelRes ON TelRes.Cd_Prestador = M.Cd_Prestador AND TelRes.Cd_Tip_Comun = 2
LEFT JOIN dbamv.Multi_Empresas ME ON ME.cd_Multi_Empresa = M.cd_Multi_Empresa
WHERE M.Cd_Prestador = {(cdPrestador)}