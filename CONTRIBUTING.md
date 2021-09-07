# Buildando o projeto

Usamos o [XcodeGen](https://github.com/yonaskolb/XcodeGen) para gerar os arquivos de projeto. Para isso, basta executar (com a ferramenta já instalada) `make`
na raiz do projeto.

Se algo não estiver funcionando direito por algum motivo, existe também a opção de executar `make remake` para apagar todos os arquivos gerados e fazer tudo
do início novamente. Mas atenção: executar esse procedimento implica em buildar o projeto do zero novamente, o que leva alguns minutos.

# Fluxo de desenvolvimento

Convencionou-se que usaremos o [_gitflow_](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) durante o desenvolvimento do projeto.
Existem [ferramentas de extensão](https://github.com/nvie/gitflow) ao `git` que nos ajudam a aplicar essa metodologia durante o desenvolvimento,
mas em termos gerais o _workflow_ funciona da seguinte maneira:

### Verificar o tipo de trabalho que será desenvolvido

Quando trabalhamos em desenvolvimento de software, podemos fazer diversos tipos de alterações e contribuições para o projeto. A referência de gitflow acima
define algumas categorias, mas a principal com a qual vamos nos preocupar é a _feature_.

### Criar uma nova branch a partir da `develop`

Após realizar o `pull` e atualizar a cópia local da branch `develop`, criamos uma nova branch a partir dela, para a qual daremos um nome breve e descritivo 
seu objetivo. Por exemplo, para criar uma branch para trabalhar em uma feature que implementa a tela de configurações, podemos fazer algo do tipo:

```
git switch -c feature/settings
```

Nota: Lembre que a execução desse comando parte do princípio que você está em uma cópia atualizada da branch `develop`

Isso vai criar uma nova branch, ou cópia do projeto, onde poderemos fazer modificações livremente e salvar o progresso por meio de `commit`s. 

### Concluir as alterações e integrar na `develop`

Quando a nova feature estiver concluída, basta realizar um `push` para trazer as alterações para o repositório. A partir desse momento, poderemos abrir
um `pull request` que integra as modificações da nossa branch `feature/settings` à branch principal de desenvolvimento `develop`.
Dessa maneira, os próximos trabalhos desenvolvidos já terão sua feature integrada ao projeto.

Sobre Pull Requests: Pull Request (comumente abreviado para PR) é o nome que se dá à solicitação de realizar um `merge` entre duas branches
(normalmente algo como `feature/*`e `develop` ou `release/*`e `master`).

# Dependências do projeto

Outra convenção que surgiu durante o desenvolvimento foi a utilização de algumas dependências para auxiliar no desenvolvimento do código.
Com exceção de `xcodegen` e CocoaPods, que devem estar instaladas no sistema, todas as ferramentas são instaladas automaticamente ao
gerar os arquivos de projeto com `make`.

### SwiftGen

[SwiftGen](https://github.com/SwiftGen/SwiftGen) é uma ferramenta que gera código automaticamente para recursos de projeto (como imagens, fontes, strings, etc),
trazendo _type safety_ para o projeto. No momento, utilizamos essa ferramenta da seguinte maneira:

- Assets: Para cada asset dentro de `Assets.xcassets` a ferramenta gera um atributo dentro de um `enum` acessível a nivel de projeto. 
Por exemplo, para fazer uma instância de uma imagem presente na pasta `Images` e de nome `teste.png`, fazemos `UIImage(asset: Assets.Images.teste)`.
Dessa forma, garantimos que a imagem com o nome especificado realmente existe, pois se não existir o valor `Assets.Images.teste` não existirá
e teremos um erro de *compilação*. Funciona de maneira similar para cores (`Assets.Colors.*`).

- Localizable strings: São strings que ficam dentro dos arquivos `Localizable.strings` presentes em `Resources`. Essas strings representam
texto que será mostrado para o usuário, e traduzido automaticamente de acordo com a linguagem do dispositivo (se houver um arquivo `Localizable.strings` correspondente).
O fallback (ou seja, se o usuário selecionar uma linguagem não suportada, é inglês). Um exemplo é `Strings.Localizable.MapScene.SearchBar.placeholder`.

- Names strings: Essas são strings que representam "constantes" que usamos no código (como nomes de ícones de sistema, por exemplo).
Como esses valores não são traduzidos, ficam armazenados separadamente. Um exemplo é `Strings.Names.Icons.map`.

- Fontes: As fontes (que devem estar presentes em `Resources/Fonts`) e podem ser usadas como `Fonts.SpriteGraffiti.regular`.

Uma dica é usar sempre o _auto completion_ do Xcode para usar essas variáveis. Como elas são geradas `on build`, essas variáveis vão existir e
a IDE te ajuda a encontrar o nome exato delas.

### SwiftLint

Essa é a ferramenta mais chata, e também a que mais aparece. Seu objetivo é apontar "erros" e _smelly code_ de acordo com um conjunto de regras
(as configurações de todas as ferramentas ficam na pasta `config` na raiz do projeto). A maneira que a ferramenta nos avisa sobre esses acidentes
na nossa _codebase_ é por meio de uma multidão de warnings e errors levantados pela ferramenta com a finalidade  de diminuir sua visibilidade até que
você ceda à pura pressão de corrigir para ter paz de espirito. 

Mais detalhes sobre a ferramenta em [SwiftLint](https://github.com/realm/SwiftLint).

Os avisos, apesar de chatos, nos ajudam a manter o código mais limpo e organizado, e ajudam a criar o hábito de boas práticas. Sempre que possível, 
dê algumas migalhas de atenção pra pobre da ferramenta.

### SwiftFormat

O objetivo dessa [ferramenta](https://github.com/nicklockwood/SwiftFormat) é manter o código formatado de acordo, também, com um conjunto de regras.
Dessa maneira, independente da quantidade de desenvolvedores trabalhando, podemos manter nossa codebase limpa, organizada e uniforme.

Temos duas opções para usar essa ferramenta: server ou client side. Vamos falar sobre server side mais adiante.

Client side quer dizer que a ferramenta vai rodar em seu computador, localmente. A maneira que encontramos de fazer isso ocorrer da maneira mais
transparente é formatar o código antes de todo commit. Então por mais desorganizado que estejam suas alterações, ao realizar um commit a ferramenta vai formatar tudo
para a nossa alegria. Dessa maneira, todo código que chega no repositório remoto já foi formatado.

Para usar essa ferramenta dessa maneira, precisamos configurar um [git hook](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks).
Por motivos de praticidade, executar `make hooks` na raiz do projeto faz isso por nós.

### SnapKit

[SnapKit](https://github.com/SnapKit/SnapKit) introduz uma linguagem própria e facilitada para trabalhar com _constraints_. É só o que utilizamos para
criar constraints programaticamente e tem sido um grande facilitador. No próprio repositório da ferramenta tem um [exemplo](https://github.com/SnapKit/SnapKit#usage)
simples ilustrando seu funcionamento.



