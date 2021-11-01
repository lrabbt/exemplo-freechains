# Exemplo Freechains

## Como usar

Execute o arquivo `simul.sh`.

## Limpeza

Por padrão, os arquivos dos nós do Freechains seguem o padrão `/tmp/fchs-*`.

Para parar os processos e remover os arquivos:

```bash
pkill -f Freechains
rm -r /tmp/fchs-*
```

## Fórum

O fórum será um fórum de culinária, voltado para receitas caseiras.

## Usuários

- Alisses - Pioneiro da cadeia, usuário ativo
- Bianca - Usuário ativo
- Charlotte - Usuário ativo com pouco conhecimento
- Diano - Usuário troll
- Elísio - Usuário pouco ativo

## Distribuição

Os usuários Alisses e Bianca acessarão o fórum do nó N, enquanto Charlotte e Diano usarão um nó M, Elísio usará um nó O.

## Interações

A dinâmica do fórum baseia-se em Alisses, Bianca e Charlotte conversando sobre receitas que encontraram e querem compartilhar.

Diano se acha um chefe profissional e não vê o porquê desses amadores discutirem receitas tão simples.

Elísio é um usuário que observa mais que interage, mas se mantém atualizado com as postagens.

## Problemas

Tive problemas ao executar o `peer recv` no final do arquivo de simulação, a corrente que deveria receber atualizações não dá erro para o cliente diretamente, mas dá erro no servidor. Após essa requisição, qualquer requisição para a corrente no servidor que tentou receber os blocos diz que a corrente não existe. Eu verifiquei a pasta (nesse caso, `/tmp/fchs-o/chains/\#receitas`) e a pasta ainda está lá.
