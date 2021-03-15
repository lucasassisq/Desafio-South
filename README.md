# Desafio South
 Desafio utilizando a API pública de Breaking Bad!

Api utilizada: https://breakingbadapi.com/documentation

# Metodologias utilizadas para desenvolvimento:
- View Model
- RxSwift
- RxCocoa
- Storyboard
- Xib's
- View Code

Queria fazer o desafio para Android também, mas como o tempo é muito curto (peguei na sexta à tarde) e a previsão para entrega já era hoje (segunda), não teria tempo hábil para entregar o desafio nas duas plataformas. Portanto, fiz apenas de acordo com a vaga que estou pleiteando.

Sem mais delongas, vamos lá aos comentários de desenvolvimento!

Primeiramente, achei super interessante a ideia de poder escolher o meu próprio tema para desenvolvimento. Confesso que perdi um pouco de tempo tentanto definir o que iria fazer, mas após algumas pesquisas, acabei encontrando esta API do Breaking Bad (minha série favorita :D) e desenvolvi em cima disso. Gostei bastante do desafio, não é um desafio longo e cansativo, mas ao mesmo tempo é bem objetivo e deixa claro desde o início o que precisa ser feito.



# Objetivo/Funcionalidades 

A proposta do aplicativo é bem simples! Primeiramente, vamos listar alguns personagens da série ordenados de Z-A, porquê eu quero que o Walter White fique em um dos primeiros, hahaha! Ao usuário escolher algum desses personagens, abre um modal mostrando a foto do personagem e algumas citações/frases ditas por ele no decorrer da série. 
Para pegarmos as citações/frases, fazemos uma outra requisição para API onde obtemos as informações e mostramos ao usuário.

Além disso, há também uma listagem de episódios. Os episódios estão sendo ordenados por episodesID e por eles não possuírem nenhuma outra informação que eu julguei ser relevante, não há nenhuma ação quando o usuário escolhe um episódio.


Interface adaptável: Optei por utilizar storyboard, xibs e view code para demonstrar que estou habituado para trabalhar em diversas maneiras. Embora, deixo bem claro que a minha maneira preferida é view code.

View Model: Estou acostumado a trabalhar com View Model desde outras plataformas, como C#/Xamarin e Android utilizando DataBinding. É de longe a maneira que sinto mais confortável em relação a padrão de arquitetura.

RxSwift: Ferramenta extremamente poderosa e robusta. Embora seja algo um pouco complicado de aprender no início, a longo prazo se torna um grande ganho se implementado corretamente no projeto. 

A minha ideia inicial era realizar uma listagem de episódios de Breaking Bad de forma paginada. Entretanto, quando já estava quaaaaaaase acabando o desafio (deixei a parte de episódios por último), eu observei que o endpoint de episódios não possuia paginação na API, aí acabou que não deu para implementar o que queria 100%. 


RxCocoa: Na hora que vi que precisava trabalhar com listas e tive a ideia de listar episódios, personagens e verificar as citações de cada um da API de Breaking Bad, já pensei em RxSwift junto com RxCocoa na hora! Lindo a maneira onde a implementação ocorre na tableView, deixa o código muito mais clean e fica bem simples de entender! Acho uma ótima ferramenta.


