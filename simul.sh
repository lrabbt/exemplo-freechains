#!/bin/sh

update_all_servers_time() {
  local time=$1

  for port in $ALISSES_PORT $BIANCA_PORT $CHARLOTTE_PORT $DIANO_PORT $ELISIO_PORT; do
    freechains-host --port=$port now $time
  done
}

# Nó N
N="34578"
N_PATH="/tmp/fchs-n"
freechains-host --port="$N" start "$N_PATH" &

# Nó M
M="34579"
M_PATH="/tmp/fchs-m"
freechains-host --port="$M" start "$M_PATH" &

# Nó O
O="34580"
O_PATH="/tmp/fchs-o"
freechains-host --port="$O" start "$O_PATH" &

sleep 1

# Update all servers time to 2021-01-01 18:00
update_all_servers_time 1609534800

# Alisses
ALISSES_PUB=$(freechains --port=$N crypto pubpvt "alisson-pwd" | cut -d' ' -f1)
ALISSES_PVT=$(freechains --port=$N crypto pubpvt "alisson-pwd" | cut -d' ' -f2)

# Bianca
BIANCA_PUB=$(freechains --port=$N crypto pubpvt "bianca-pwd" | cut -d' ' -f1)
BIANCA_PVT=$(freechains --port=$N crypto pubpvt "bianca-pwd" | cut -d' ' -f2)

# Charlotte
CHARLOTTE_PUB=$(freechains --port=$M crypto pubpvt "charlotte-pwd" | cut -d' ' -f1)
CHARLOTTE_PVT=$(freechains --port=$M crypto pubpvt "charlotte-pwd" | cut -d' ' -f2)

# Diano
DIANO_PUB=$(freechains --port=$M crypto pubpvt "diano-pwd" | cut -d' ' -f1)
DIANO_PVT=$(freechains --port=$M crypto pubpvt "diano-pwd" | cut -d' ' -f2)

# Elísio
ELISIO_PUB=$(freechains --port=$O crypto pubpvt "elisio-pwd" | cut -d' ' -f1)
ELISIO_PVT=$(freechains --port=$O crypto pubpvt "elisio-pwd" | cut -d' ' -f2)

# Alisses cria fórum
freechains --port="$N" chains join '#receitas' "$ALISSES_PUB"
freechains --port="$N" chain '#receitas' post - <<EOF
Boa noite!

Este fórum será usado para compartilhar receitas caseiras.

Compartilhe suas melhores receitas :)
EOF

freechains --port="$N" chain '#receitas' post - <<EOF
# Pizza brotinho de calabresa:

## MASSA:

- 450 gramas de farinha de trigo (aproximadamente)
- 200 mililitros de água morna
- 10 gramas de fermento biológico seco
- ¼ xícara de óleo ou azeite de oliva
- 1 colher de chá de sal
- ½ colher de chá de açúcar

## COBERTURA:

- 300 gramas de queijo muçarela ralado
- 1½ linguiça calabresa
- ½ xícara de molho de tomate
- ½ cebola média em rodelas
- orégano (a gosto)
- azeitonas pretas (a gosto)
- folhas frescas de manjericão
EOF

# Update all servers time to 2021-02-01 18:00
update_all_servers_time 1612213200

# Bianca se junta e posta uma receita
freechains --port="$N" chain '#receitas' post - <<EOF
# Arroz de Brócolis

## Ingredientes
    
- 500 g de arroz refogado em alho cozido
- 100 g de alho
- 3 colheres de azeite
- 2 maços de brócolis fresco
- 20 g de bicabornato de sódio
- 3 litros água fervente
- Sal a gosto

## Modo de Preparo

- Limpe o brócolis descascando os talos (retirando a pele com a faca).
- Aproveite talos e folhas. Cozinhe o brócolis na água com sal e o bicabornato até que o talo fique macio. Escorra e reserve.
- Em uma panela frite o alho no azeite até que fique dourado. Junte o brócolis e refogue. Misture a arroz cozido em alho e misture até que fique uniforme.
- O arroz fica verde por causa do bicabornato.
EOF

# Alisses decide dar like na receita para desbloquear a mensagem
freechains --port="$N" --sign="$ALISSON_PVT" chain '#receitas' like $(freechains --port="$N" chain '#receitas' heads blocked)

# Update all servers time to 2021-03-01 18:00
update_all_servers_time 1614632400

# Charlotte descobre o grupo, decide juntar-se e compartilhar sua receita
freechains --port="$M" chains join '#receitas' "$ALISSES_PUB"
freechains --port="$M" peer "0.0.0.0:$N" recv '#receitas'

freechains --port="$M" --sign="$CHARLOTTE_PVT" chain '#receitas' post - <<EOF
# Panquecas doces

## Ingredientes

- 150 g de farinha
- 1 pitada de sal fino
- 2 colheres (sopa) de açúcar
- 1 colher (café) de fermento em pó
- 2 colheres (sopa) de manteiga derretida
- 1 ovo batido
- 2,5 dl de  leite
- Óleo para untar

## Instruções de preparação

- Para preparar esta receita de panquecas, numa tigela, misture a farinha com o sal, o açúcar e o fermento. Junte a manteiga derretida, o ovo batido e depois o leite, em fio e mexendo sempre até ficar uma massa lisa.
- Leve ao lume uma frigideira pequena, de preferência antiaderente, deixe-a aquecer e unte-a com um pouco de óleo. Deite uma colherada da mistura anterior e deixe-a cozinhar de ambos os lados, virando com uma espátula, até ficar douradinha. Retire e repita a operação com o resto da massa.
- Depois sirva as panquecas quentes ou mornas com mel, compota ou fruta fresca.
EOF
freechains --port="$M" peer "0.0.0.0:$N" send '#receitas'

# Alisses e Bianca curtem a postagem
freechains --port="$N" --sign="$ALISSON_PVT" chain '#receitas' like $(freechains --port="$N" chain '#receitas' heads blocked)
freechains --port="$N" --sign="$BIANCA_PVT" chain '#receitas' like $(freechains --port="$N" chain '#receitas' heads blocked)

# Charlotte agora tem reputação para postar e dar likes
freechains --port="$M" peer "0.0.0.0:$N" recv '#receitas'
