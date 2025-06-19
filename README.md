# 📁 Show-Tree

`Show-Tree` é uma função personalizada para PowerShell que exibe a estrutura de diretórios e arquivos no estilo de árvore, semelhante ao comando `tree` do Linux, com suporte a um arquivo `.treeignore`, inspirado no `.gitignore`, permitindo ignorar arquivos e pastas específicos com suporte a *wildcards*.

---


teste .gitgnore

## ✅ Funcionalidades

- 📂 Visualização hierárquica da estrutura de arquivos e pastas
- 🔍 Leitura automática de um arquivo `.treeignore` para ignorar itens
- ⚙️ Fácil integração com seu perfil do PowerShell (`Microsoft.PowerShell_profile.ps1`)
- 📄 Suporte a **`.treeignore`** para exclusão de arquivos/diretórios da visualização
-- ✨ Suporte a *wildcards* no `.treeignore`
  - `*` — qualquer parte de um nome (sem `/`)
  - `?` — um único caractere
  - `**` — qualquer profundidade de pastas

---

## 📦 Instalação

1. **Abra seu perfil PowerShell:**

   ```powershell
   notepad $PROFILE
   ```

   Caminho padrão:
   ```
   C:\Users\SeuNome\OneDrive\Documentos\PowerShell\Microsoft.PowerShell_profile.ps1
   ```

2. **Cole a função `Show-Tree` no final do arquivo e salve.**

3. **Recarregue o perfil (ou reinicie o terminal):**

   ```powershell
   . $PROFILE
   ```

---


## 🛠️ 📄  Suporte a Arquivo `.treeignore`

Você pode criar um arquivo `.treeignore` na raiz do seu projeto com os padrões de arquivos e pastas que deseja ocultar na exibição da árvore.

### 🔹 Exemplo `.treeignore`

```plaintext
# Ignorar pastas comuns
.git/
venv/
__pycache__/

# Ignorar arquivos específicos
database.db
.DS_Store
README.md

# Usando wildcards
*.log                # Todos os arquivos .log
static/img/**/*.jpg  # Todos os .jpg dentro de static/img e subpastas
```

---

## 🔎 Suporte a Wildcards, Padrões de Ignore (.treeignore)


Abaixo estão os padrões que você pode usar no arquivo `.treeignore` para ignorar arquivos e pastas no comando `Show-Tree`:

| Padrão          | Significado                                                | Exemplo prático                                 |
|-----------------|------------------------------------------------------------|--------------------------------------------------|
| `*`             | Qualquer sequência de caracteres (exceto separador `/`)    | `*.log` → ignora todos os arquivos `.log`        |
| `?`             | Corresponde a um único caractere                           | `file?.py` → ignora `file1.py`, `fileA.py`       |
| `**`            | Corresponde a qualquer número de diretórios intermediários | `static/**/fotos` → ignora `static/a/b/fotos`    |
| `nome.ext`      | Arquivo específico                                         | `README.md` → ignora exatamente esse arquivo     |
| `pasta/`        | Ignora a pasta e tudo que está dentro dela                | `venv/` → ignora todo o conteúdo de `venv/`      |
| `pasta/*.txt`   | Todos os `.txt` dentro da pasta indicada                   | `docs/*.txt` → ignora todos `.txt` em `docs/`    |
| `**/*.jpg`      | Todos os `.jpg` em qualquer subdiretório                   | `**/*.jpg` → ignora todos `.jpg` do projeto      |
| `.git/`         | Diretório `.git` e todo o conteúdo dentro dele             | `.git/` → ignora repositório Git                 |
| `.git`          | Também ignora o diretório `.git` (equivalente a `.git/`)   | `.git` → ignora repositório Git                  |
| `*.git`         | Arquivos com extensão `.git` (ou diretórios, dependendo da implementação) | `repo.git` → ignora pasta ou arquivo `repo.git` |




---

### 🔹 Modelo ultilizado `.treeignore`

```
.treeignore
*.git
__pycache__
database.db
.DS_Store
README.md
```

## 📂 Exemplo de Saída



---

## Observações

> **PS:** Os comandos apresentados são executados no terminal Linux dentro do `WSL` (Windows Subsystem for Linux) via PowerShell no Windows.

> 🗂️ **Importante:** Esses comandos servem apenas para **organizar e visualizar a estrutura de arquivos e pastas no terminal**, dando ao usuário uma noção do que está sendo manipulado.

> ⚙️ A funcionalidade principal e os objetivos de organização e exibição são realizados pela aplicação **Show-Tree**, executada no PowerShell. Os comandos mostrados aqui são apenas auxiliares para facilitar a visualização.

## Com WLS ou bash
Sem `.treeignore` apenas o comado `ls -1AfA`:
```
ls -1AfA
```
```
.git
.treeignore
app.py
models.py
README.md
requirements.txt
static
templates
```
## Com PowerShell
Com `.treeignore` corretamente configurado:

```
├── app.py
├── models.py
├── requirements.txt
├── static/
│   ├── login.css
│   ├── style.css
│   └── img/
│       └── fundo.jpg
├── templates/
│   ├── editar.html
│   ├── index.html
│   ├── login.html
│   └── registros.html
└── instance/
    └── database.db
```


---

## 🛠️ Como Usar

1. **Abra seu PowerShell:** Dentro de qualquer pasta do seu projeto, execute:

```powershell
Show-Tree
```
- Mostra a estrutura de arquivos e pastas a partir do diretório atual.
- Respeita as regras do arquivo `.treeignore` se existir na raiz do projeto.
---
Para salvar a árvore diretamente no `README.md` com blocos de código formatados:

```powershell
'```' | Out-File README.md; Show-Tree >> README.md; '```' >> README.md
```

## 🤝 Contribuições

Sinta-se à vontade para ajustar a função ou melhorar o suporte a padrões. Sugestões de melhorias são bem-vindas!

---

## 📄 Licença

Este projeto está licenciado sob a **GNU General Public License v3.0 (GPLv3)**.

Você pode encontrar o texto completo da licença no arquivo [`LICENSE`](./LICENSE) na raiz deste repositório.

Para mais detalhes sobre a GPLv3, visite: [https://www.gnu.org/licenses/gpl-3.0.html](https://www.gnu.org/licenses/gpl-3.0.html)

---
