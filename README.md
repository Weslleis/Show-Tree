# 📁 Show-Tree

`Show-Tree` é uma função personalizada para PowerShell que exibe a estrutura de diretórios e arquivos no estilo de árvore, semelhante ao comando `tree` do Linux, com suporte a um arquivo `.treeignore`, inspirado no `.gitignore`, permitindo ignorar arquivos e pastas específicos com suporte a *wildcards*.

---

## ✅ Funcionalidades

- 📂 Visualização hierárquica da estrutura de arquivos e pastas
- 🔍 Leitura automática de um arquivo `.treeignore` para ignorar itens
- ⚙️ Fácil integração com seu perfil do PowerShell (`Microsoft.PowerShell_profile.ps1`)
- 📄 Suporte a **`.treeignore`** para exclusão de arquivos/diretórios da visualização  
  -- ✨ Suporte a *wildcards* no `.treeignore`
  - `*` — qualquer parte de um nome (sem `/`)
  - `?` — um único caractere
  - `**` — qualquer profundidade de pastas
- 🔐 **Novo:** Suporte ao parâmetro `-Checksum` para exibir o **hash MD5** de arquivos  
  - Ideal para verificar integridade ou mudanças nos arquivos  
  - Mostra o hash ao lado do nome de cada arquivo
- 🛡️ **Modificável:** Possibilidade de alterar o algoritmo para `SHA256` com ajuste simples no código

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

---

## 📂 Exemplo de Saída

### ✅ Sem `-Checksum`

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

### ✅ Com `-Checksum`

```
├── 019109307b8d4570bcff77dff4317487  app.py
├── 29fd9e07a4908e7a2994b525fa09eed0  models.py
├── 7de7c781d9881a461fa0c01cae1e0691  requirements.txt
├── static/
│   ├── 4c3be7136a869413052b19e15695f5b0  login.css
│   ├── dd2786d5f8b22ab8abe4c007e548ad0b  style.css
│   └── img/
│       └── e554b7e7a6f133508ed0e4d4a2cdadd3  fundo.jpg
├── templates/
│   ├── abd3d1925da7c6c045be7af550ff051a  editar.html
│   ├── c90811b752da6ac242677954e381daf6  index.html
│   ├── 7b1a69e3d98693d72ada5b271bdb6850  login.html
│   └── a8f64e78749e275c489dc9f40ab7800c  registros.html
└── instance/
    └── 94a84716621b7cb8ea79be5f3ef01257  database.db
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

### 📌 Modo com `-Checksum`:

```powershell
Show-Tree -Checksum
```

- Exibe a estrutura com o hash MD5 dos arquivos
- Útil para verificar integridade e alterações em arquivos

---

### 🔁 Alterando para SHA256

Por padrão, a função usa MD5. Se quiser usar SHA256 (mais seguro), basta alterar **uma linha** da função `Show-Tree`:

```powershell
# De:
(Get-FileHash -Algorithm MD5 -Path $FilePath).Hash

# Para:
(Get-FileHash -Algorithm SHA256 -Path $FilePath).Hash
```

Assim, o parâmetro `-Checksum` exibirá hashes SHA256 em vez de MD5.

---

### 💾 Salvar estrutura no README.md

Para salvar a árvore diretamente no `README.md` com blocos de código formatados:

```powershell
'```' | Out-File README.md; Show-Tree >> README.md; '```' >> README.md
```

---

## 🤝 Contribuições

Sinta-se à vontade para ajustar a função ou melhorar o suporte a padrões. Sugestões de melhorias são bem-vindas!

---

## 📄 Licença

Este projeto está licenciado sob a **GNU General Public License v3.0 (GPLv3)**.

Você pode encontrar o texto completo da licença no arquivo [`LICENSE`](./LICENSE) na raiz deste repositório.

Para mais detalhes sobre a GPLv3, visite: [https://www.gnu.org/licenses/gpl-3.0.html](https://www.gnu.org/licenses/gpl-3.0.html)

---
