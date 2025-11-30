# 💻 Sistema de Gestão de Pagamentos de Inquilinos - Scripts SQL (DML)

Este repositório contém os scripts de manipulação de dados (DML - Data Manipulation Language) para o banco de dados relacional do projeto "Sistema de Gestão de Pagamentos de Inquilinos".

O modelo lógico foi rigorosamente normalizado até a **Terceira Forma Normal (3FN)** garantindo a integridade dos dados, eliminando redundâncias e preparando o sistema para a implementação física.

## 🎯 Objetivo

O objetivo principal desta etapa foi aplicar a Linguagem SQL (DML) para:
* **Aplicar:** Executar comandos SQL para manipular dados reais.
* **Criar:** Desenvolver scripts SQL estruturados para um banco de dados funcional.
* **Integração:** Combinar o conhecimento de modelagem lógica, normalização e integridade referencial com o uso da DML.

## 📊 Modelo Lógico Relacional (Entidades)

O sistema é construído sobre cinco entidades principais, todas em 3FN

* **ADMINISTRADOR** 
* **INQUILINO** 
* **IMÓVEL** 
* **CONTRATO** (Relaciona Imóvel, Inquilino e Administrador)
* **PAGAMENTO** (Histórico de transações por Contrato) 

A separação clara entre estas entidades permite consultas eficientes, histórico completo de locações e fácil manutenção do sistema

## ⚙️ Instruções de Execução

Para testar e utilizar os scripts DML contidos neste repositório:

1.  **Pré-requisito (DDL):** Execute o script DDL (Data Definition Language - `CREATE TABLE`s e restrições) para criar as 5 tabelas no seu SGBD (ex: MySQL, PostgreSQL, etc.).
2.  **Ambiente:** Utilize uma ferramenta de desenvolvimento SQL (como **Workbench** ou **PGAdmin**).
3.  **Execução do DML:**
    * Execute os comandos `INSERT` para popular as tabelas principais.
    * Execute os comandos `SELECT` (com `JOIN`, `WHERE`, `ORDER BY`) para realizar consultas gerenciais.
    * Execute os comandos `UPDATE` e `DELETE` com condições para testar a integridade referencial e a manipulação dos dados.

---

**Autor:** Stephany Roberta
