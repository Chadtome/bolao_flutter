import 'package:bolao_/constants/app_icons.dart';
import 'package:bolao_/data/times_data.dart';
import 'package:bolao_/models/jogo.dart';
import 'package:bolao_/models/rodada.dart';
import 'package:bolao_/models/time.dart';

Time findTimebyName(String nome) {
  return timesData.firstWhere((t) => t.nome == nome);
}

List<Rodada> rodadasMock = [

  Rodada(
    numero: 1, 
    data: "2026-01-28",// 
    jogos: [
      Jogo(
        timeA: findTimebyName("Atlético Mineiro").abreviatura,
        timeB: findTimebyName("Palmeiras").abreviatura, 
        escudoA: AppIcons.atleticoMg,
        escudoB: AppIcons.verdao,
        ),
      Jogo(
        timeA: findTimebyName("Internacional").abreviatura, 
        timeB: findTimebyName("Athletico Paranaense").abreviatura,
        escudoA: AppIcons.inter, 
        escudoB: AppIcons.athleticoPar,
        ),
      Jogo(
          timeA: findTimebyName("Coritiba").abreviatura, 
          timeB: findTimebyName("Bragantino").abreviatura, 
          escudoA: AppIcons.coxa, 
          escudoB: AppIcons.bragantino
          ),
      Jogo(
            timeA: findTimebyName("Vitória").abreviatura, 
            timeB: findTimebyName("Remo").abreviatura, 
            escudoA: AppIcons.vitoria, 
            escudoB: AppIcons.remo,
            ),
      Jogo(
        timeA: findTimebyName("Fluminense").abreviatura, 
        timeB: findTimebyName("Grêmio").abreviatura, 
        escudoA: AppIcons.nense, 
        escudoB: AppIcons.gremio
        )  ,
        Jogo(
          timeA: findTimebyName("Corinthians").abreviatura, 
          timeB: findTimebyName("Bahia").abreviatura, 
          escudoA: AppIcons.timao, 
          escudoB: AppIcons.bahia,
          ),

        Jogo(
          timeA: findTimebyName("Chapecoense").abreviatura, 
          timeB: findTimebyName("Santos").abreviatura, 
          escudoA: AppIcons.chape, 
          escudoB: AppIcons.santos,
          ),


        Jogo(
          timeA: findTimebyName("São Paulo").abreviatura, 
          timeB: findTimebyName("Flamengo").abreviatura, 
          escudoA: AppIcons.saoPaulo, 
          escudoB: AppIcons.mengo,
          ),


        Jogo(
          timeA: findTimebyName("Mirassol").abreviatura, 
          timeB: findTimebyName("Vasco").abreviatura, 
          escudoA: AppIcons.mirassol, 
          escudoB: AppIcons.vasco,
          ),


        Jogo(
          timeA: findTimebyName("Botafogo").abreviatura, 
          timeB: findTimebyName("Cruzeiro").abreviatura, 
          escudoA: AppIcons.botafogo, 
          escudoB: AppIcons.zero,
          ),
    ],
    ),

    //-------------------------------------------------------
    Rodada(
      numero: 2, 
      data: "2026-02-04", 
      jogos: [
        Jogo(
          timeA:  findTimebyName("Flamengo").abreviatura,
          timeB: findTimebyName("Internacional").abreviatura, 
          escudoA: AppIcons.mengo, 
          escudoB: AppIcons.inter
          ),

        Jogo(
          timeA:  findTimebyName("Bragantino").abreviatura,
          timeB: findTimebyName("Atlético Mineiro").abreviatura, 
          escudoA: AppIcons.bragantino, 
          escudoB: AppIcons.atleticoMg,
          ),

        Jogo(
          timeA: findTimebyName("Santos").abreviatura, 
          timeB: findTimebyName("São Paulo").abreviatura, 
          escudoA: AppIcons.santos, 
          escudoB: AppIcons.saoPaulo,
          ),


        Jogo(
          timeA: findTimebyName("Remo").abreviatura, 
          timeB: findTimebyName("Mirassol").abreviatura, 
          escudoA: AppIcons.remo, 
          escudoB: AppIcons.mirassol
          ),


        Jogo(
          timeA: findTimebyName("Palmeiras").abreviatura, 
          timeB: findTimebyName("Vitória").abreviatura, 
          escudoA: AppIcons.verdao, 
          escudoB: AppIcons.vitoria
          )
          ,
        Jogo(
          timeA: findTimebyName("Grêmio").abreviatura, 
          timeB: findTimebyName("Botafogo").abreviatura, 
          escudoA: AppIcons.gremio, 
          escudoB: AppIcons.botafogo
          ),


        Jogo(
          timeA: findTimebyName("Bahia").abreviatura, 
          timeB: findTimebyName("Fluminense").abreviatura, 
          escudoA: AppIcons.bahia, 
          escudoB: AppIcons.nense
          ),

        Jogo(
          timeA: findTimebyName("Vasco").abreviatura, 
          timeB: findTimebyName("Chapecoense").abreviatura, 
          escudoA: AppIcons.vasco, 
          escudoB: AppIcons.chape,
          ),

        Jogo(
          timeA: findTimebyName("Cruzeiro").abreviatura, 
          timeB: findTimebyName("Coritiba").abreviatura, 
          escudoA: AppIcons.zero, 
          escudoB: AppIcons.coxa,
          ),

        Jogo(
          timeA: findTimebyName("Athletico Paranaense").abreviatura, 
          timeB: findTimebyName("Corinthians").abreviatura, 
          escudoA: AppIcons.athleticoPar, 
          escudoB: AppIcons.timao,
          
          ),
      ],
      ),
      Rodada(
  numero: 3,
  data: "2026-02-10",
  jogos: [
    Jogo(
      timeA: findTimebyName("Vitória").abreviatura,
      timeB: findTimebyName("Flamengo").abreviatura,
      escudoA: AppIcons.vitoria,
      escudoB: AppIcons.mengo,
    ),
    Jogo(
      timeA: findTimebyName("Mirassol").abreviatura,
      timeB: findTimebyName("Cruzeiro").abreviatura,
      escudoA: AppIcons.mirassol,
      escudoB: AppIcons.zero,
    ),
    Jogo(
      timeA: findTimebyName("Chapecoense").abreviatura,
      timeB: findTimebyName("Coritiba").abreviatura,
      escudoA: AppIcons.chape,
      escudoB: AppIcons.coxa,
    ),
    Jogo(
      timeA: findTimebyName("Atlético Mineiro").abreviatura,
      timeB: findTimebyName("Remo").abreviatura,
      escudoA: AppIcons.atleticoMg,
      escudoB: AppIcons.remo,
    ),
    Jogo(
      timeA: findTimebyName("Vasco").abreviatura,
      timeB: findTimebyName("Bahia").abreviatura,
      escudoA: AppIcons.vasco,
      escudoB: AppIcons.bahia,
    ),
    Jogo(
      timeA: findTimebyName("São Paulo").abreviatura,
      timeB: findTimebyName("Grêmio").abreviatura,
      escudoA: AppIcons.saoPaulo,
      escudoB: AppIcons.gremio,
    ),
    Jogo(
      timeA: findTimebyName("Athletico Paranaense").abreviatura,
      timeB: findTimebyName("Santos").abreviatura,
      escudoA: AppIcons.athleticoPar,
      escudoB: AppIcons.santos,
    ),
    Jogo(
      timeA: findTimebyName("Fluminense").abreviatura,
      timeB: findTimebyName("Botafogo").abreviatura,
      escudoA: AppIcons.nense,
      escudoB: AppIcons.botafogo,
    ),
    Jogo(
      timeA: findTimebyName("Corinthians").abreviatura,
      timeB: findTimebyName("Bragantino").abreviatura,
      escudoA: AppIcons.timao,
      escudoB: AppIcons.bragantino,
    ),
    Jogo(
      timeA: findTimebyName("Internacional").abreviatura,
      timeB: findTimebyName("Palmeiras").abreviatura,
      escudoA: AppIcons.inter,
      escudoB: AppIcons.verdao,
    ),
  ],
),
//-------------------------------------------------------
// 4ª RODADA
Rodada(
  numero: 4,
  data: "2026-02-25",
  jogos: [
    Jogo(
      timeA: findTimebyName("Bragantino").abreviatura,
      timeB: findTimebyName("Athletico Paranaense").abreviatura,
      escudoA: AppIcons.bragantino,
      escudoB: AppIcons.athleticoPar,
    ),
    Jogo(
      timeA: findTimebyName("Remo").abreviatura,
      timeB: findTimebyName("Internacional").abreviatura,
      escudoA: AppIcons.remo,
      escudoB: AppIcons.inter,
    ),
    Jogo(
      timeA: findTimebyName("Coritiba").abreviatura,
      timeB: findTimebyName("São Paulo").abreviatura,
      escudoA: AppIcons.coxa,
      escudoB: AppIcons.saoPaulo,
    ),
    Jogo(
      timeA: findTimebyName("Cruzeiro").abreviatura,
      timeB: findTimebyName("Corinthians").abreviatura,
      escudoA: AppIcons.zero,
      escudoB: AppIcons.timao,
    ),
    Jogo(
      timeA: findTimebyName("Palmeiras").abreviatura,
      timeB: findTimebyName("Fluminense").abreviatura,
      escudoA: AppIcons.verdao,
      escudoB: AppIcons.nense,
    ),
    Jogo(
      timeA: findTimebyName("Grêmio").abreviatura,
      timeB: findTimebyName("Atlético Mineiro").abreviatura,
      escudoA: AppIcons.gremio,
      escudoB: AppIcons.atleticoMg,
    ),
    Jogo(
      timeA: findTimebyName("Santos").abreviatura,
      timeB: findTimebyName("Vasco").abreviatura,
      escudoA: AppIcons.santos,
      escudoB: AppIcons.vasco,
    ),
    Jogo(
      timeA: findTimebyName("Flamengo").abreviatura,
      timeB: findTimebyName("Mirassol").abreviatura,
      escudoA: AppIcons.mengo,
      escudoB: AppIcons.mirassol,
    ),
    Jogo(
      timeA: findTimebyName("Botafogo").abreviatura,
      timeB: findTimebyName("Vitória").abreviatura,
      escudoA: AppIcons.botafogo,
      escudoB: AppIcons.vitoria,
    ),
    Jogo(
      timeA: findTimebyName("Bahia").abreviatura,
      timeB: findTimebyName("Chapecoense").abreviatura,
      escudoA: AppIcons.bahia,
      escudoB: AppIcons.chape,
    ),
  ],
),

//-------------------------------------------------------
// 5ª RODADA
Rodada(
  numero: 5,
  data: "2026-03-10",
  jogos: [
    Jogo(
      timeA: findTimebyName("Mirassol").abreviatura,
      timeB: findTimebyName("Santos").abreviatura,
      escudoA: AppIcons.mirassol,
      escudoB: AppIcons.santos,
    ),
    Jogo(
      timeA: findTimebyName("Atlético Mineiro").abreviatura,
      timeB: findTimebyName("Internacional").abreviatura,
      escudoA: AppIcons.atleticoMg,
      escudoB: AppIcons.inter,
    ),
    Jogo(
      timeA: findTimebyName("Bahia").abreviatura,
      timeB: findTimebyName("Vitória").abreviatura,
      escudoA: AppIcons.bahia,
      escudoB: AppIcons.vitoria,
    ),
    Jogo(
      timeA: findTimebyName("Flamengo").abreviatura,
      timeB: findTimebyName("Cruzeiro").abreviatura,
      escudoA: AppIcons.mengo,
      escudoB: AppIcons.zero,
    ),
    Jogo(
      timeA: findTimebyName("Corinthians").abreviatura,
      timeB: findTimebyName("Coritiba").abreviatura,
      escudoA: AppIcons.timao,
      escudoB: AppIcons.coxa,
    ),
    Jogo(
      timeA: findTimebyName("Remo").abreviatura,
      timeB: findTimebyName("Fluminense").abreviatura,
      escudoA: AppIcons.remo,
      escudoB: AppIcons.nense,
    ),
    Jogo(
      timeA: findTimebyName("Vasco").abreviatura,
      timeB: findTimebyName("Palmeiras").abreviatura,
      escudoA: AppIcons.vasco,
      escudoB: AppIcons.verdao,
    ),
    Jogo(
      timeA: findTimebyName("São Paulo").abreviatura,
      timeB: findTimebyName("Chapecoense").abreviatura,
      escudoA: AppIcons.saoPaulo,
      escudoB: AppIcons.chape,
    ),
    Jogo(
      timeA: findTimebyName("Grêmio").abreviatura,
      timeB: findTimebyName("Bragantino").abreviatura,
      escudoA: AppIcons.gremio,
      escudoB: AppIcons.bragantino,
    ),
    Jogo(
      timeA: findTimebyName("Athletico Paranaense").abreviatura,
      timeB: findTimebyName("Botafogo").abreviatura,
      escudoA: AppIcons.athleticoPar,
      escudoB: AppIcons.botafogo,
    ),
  ],
),

//-------------------------------------------------------
// 6ª RODADA
Rodada(
  numero: 6,
  data: "2026-03-14",
  jogos: [
    Jogo(
      timeA: findTimebyName("Vitória").abreviatura,
      timeB: findTimebyName("Atlético Mineiro").abreviatura,
      escudoA: AppIcons.vitoria,
      escudoB: AppIcons.atleticoMg,
    ),
    Jogo(
      timeA: findTimebyName("Botafogo").abreviatura,
      timeB: findTimebyName("Flamengo").abreviatura,
      escudoA: AppIcons.botafogo,
      escudoB: AppIcons.mengo,
    ),
    Jogo(
      timeA: findTimebyName("Fluminense").abreviatura,
      timeB: findTimebyName("Athletico Paranaense").abreviatura,
      escudoA: AppIcons.nense,
      escudoB: AppIcons.athleticoPar,
    ),
    Jogo(
      timeA: findTimebyName("Santos").abreviatura,
      timeB: findTimebyName("Corinthians").abreviatura,
      escudoA: AppIcons.santos,
      escudoB: AppIcons.timao,
    ),
    Jogo(
      timeA: findTimebyName("Internacional").abreviatura,
      timeB: findTimebyName("Bahia").abreviatura,
      escudoA: AppIcons.inter,
      escudoB: AppIcons.bahia,
    ),
    Jogo(
      timeA: findTimebyName("Palmeiras").abreviatura,
      timeB: findTimebyName("Mirassol").abreviatura,
      escudoA: AppIcons.verdao,
      escudoB: AppIcons.mirassol,
    ),
    Jogo(
      timeA: findTimebyName("Coritiba").abreviatura,
      timeB: findTimebyName("Remo").abreviatura,
      escudoA: AppIcons.coxa,
      escudoB: AppIcons.remo,
    ),
    Jogo(
      timeA: findTimebyName("Bragantino").abreviatura,
      timeB: findTimebyName("São Paulo").abreviatura,
      escudoA: AppIcons.bragantino,
      escudoB: AppIcons.saoPaulo,
    ),
    Jogo(
      timeA: findTimebyName("Cruzeiro").abreviatura,
      timeB: findTimebyName("Vasco").abreviatura,
      escudoA: AppIcons.zero,
      escudoB: AppIcons.vasco,
    ),
    Jogo(
      timeA: findTimebyName("Chapecoense").abreviatura,
      timeB: findTimebyName("Grêmio").abreviatura,
      escudoA: AppIcons.chape,
      escudoB: AppIcons.gremio,
    ),
  ],
),

//-------------------------------------------------------
// 7ª RODADA
Rodada(
  numero: 7,
  data: "2026-03-18",
  jogos: [
    Jogo(
      timeA: findTimebyName("Palmeiras").abreviatura,
      timeB: findTimebyName("Botafogo").abreviatura,
      escudoA: AppIcons.verdao,
      escudoB: AppIcons.botafogo,
    ),
    Jogo(
      timeA: findTimebyName("Bahia").abreviatura,
      timeB: findTimebyName("Bragantino").abreviatura,
      escudoA: AppIcons.bahia,
      escudoB: AppIcons.bragantino,
    ),
    Jogo(
      timeA: findTimebyName("Athletico Paranaense").abreviatura,
      timeB: findTimebyName("Cruzeiro").abreviatura,
      escudoA: AppIcons.athleticoPar,
      escudoB: AppIcons.zero,
    ),
    Jogo(
      timeA: findTimebyName("Mirassol").abreviatura,
      timeB: findTimebyName("Coritiba").abreviatura,
      escudoA: AppIcons.mirassol,
      escudoB: AppIcons.coxa,
    ),
    Jogo(
      timeA: findTimebyName("Atlético Mineiro").abreviatura,
      timeB: findTimebyName("São Paulo").abreviatura,
      escudoA: AppIcons.atleticoMg,
      escudoB: AppIcons.saoPaulo,
    ),
    Jogo(
      timeA: findTimebyName("Vasco").abreviatura,
      timeB: findTimebyName("Fluminense").abreviatura,
      escudoA: AppIcons.vasco,
      escudoB: AppIcons.nense,
    ),
    Jogo(
      timeA: findTimebyName("Santos").abreviatura,
      timeB: findTimebyName("Internacional").abreviatura,
      escudoA: AppIcons.santos,
      escudoB: AppIcons.inter,
    ),
    Jogo(
      timeA: findTimebyName("Grêmio").abreviatura,
      timeB: findTimebyName("Vitória").abreviatura,
      escudoA: AppIcons.gremio,
      escudoB: AppIcons.vitoria,
    ),
    Jogo(
      timeA: findTimebyName("Flamengo").abreviatura,
      timeB: findTimebyName("Remo").abreviatura,
      escudoA: AppIcons.mengo,
      escudoB: AppIcons.remo,
    ),
    Jogo(
      timeA: findTimebyName("Chapecoense").abreviatura,
      timeB: findTimebyName("Corinthians").abreviatura,
      escudoA: AppIcons.chape,
      escudoB: AppIcons.timao,
    ),
  ],
),

//-------------------------------------------------------
// 8ª RODADA
Rodada(
  numero: 8,
  data: "2026-03-21",
  jogos: [
    Jogo(
      timeA: findTimebyName("Bragantino").abreviatura,
      timeB: findTimebyName("Botafogo").abreviatura,
      escudoA: AppIcons.bragantino,
      escudoB: AppIcons.botafogo,
    ),
    Jogo(
      timeA: findTimebyName("Fluminense").abreviatura,
      timeB: findTimebyName("Atlético Mineiro").abreviatura,
      escudoA: AppIcons.nense,
      escudoB: AppIcons.atleticoMg,
    ),
    Jogo(
      timeA: findTimebyName("São Paulo").abreviatura,
      timeB: findTimebyName("Palmeiras").abreviatura,
      escudoA: AppIcons.saoPaulo,
      escudoB: AppIcons.verdao,
    ),
    Jogo(
      timeA: findTimebyName("Vasco").abreviatura,
      timeB: findTimebyName("Grêmio").abreviatura,
      escudoA: AppIcons.vasco,
      escudoB: AppIcons.gremio,
    ),
    Jogo(
      timeA: findTimebyName("Cruzeiro").abreviatura,
      timeB: findTimebyName("Santos").abreviatura,
      escudoA: AppIcons.zero,
      escudoB: AppIcons.santos,
    ),
    Jogo(
      timeA: findTimebyName("Athletico Paranaense").abreviatura,
      timeB: findTimebyName("Coritiba").abreviatura,
      escudoA: AppIcons.athleticoPar,
      escudoB: AppIcons.coxa,
    ),
    Jogo(
      timeA: findTimebyName("Remo").abreviatura,
      timeB: findTimebyName("Bahia").abreviatura,
      escudoA: AppIcons.remo,
      escudoB: AppIcons.bahia,
    ),
    Jogo(
      timeA: findTimebyName("Internacional").abreviatura,
      timeB: findTimebyName("Chapecoense").abreviatura,
      escudoA: AppIcons.inter,
      escudoB: AppIcons.chape,
    ),
    Jogo(
      timeA: findTimebyName("Vitória").abreviatura,
      timeB: findTimebyName("Mirassol").abreviatura,
      escudoA: AppIcons.vitoria,
      escudoB: AppIcons.mirassol,
    ),
    Jogo(
      timeA: findTimebyName("Corinthians").abreviatura,
      timeB: findTimebyName("Flamengo").abreviatura,
      escudoA: AppIcons.timao,
      escudoB: AppIcons.mengo,
    ),
  ],
),

//-------------------------------------------------------
// 9ª RODADA
Rodada(
  numero: 9,
  data: "2026-04-01",
  jogos: [
    Jogo(
      timeA: findTimebyName("Botafogo").abreviatura,
      timeB: findTimebyName("Mirassol").abreviatura,
      escudoA: AppIcons.botafogo,
      escudoB: AppIcons.mirassol,
    ),
    Jogo(
      timeA: findTimebyName("Internacional").abreviatura,
      timeB: findTimebyName("São Paulo").abreviatura,
      escudoA: AppIcons.inter,
      escudoB: AppIcons.saoPaulo,
    ),
    Jogo(
      timeA: findTimebyName("Cruzeiro").abreviatura,
      timeB: findTimebyName("Vitória").abreviatura,
      escudoA: AppIcons.zero,
      escudoB: AppIcons.vitoria,
    ),
    Jogo(
      timeA: findTimebyName("Bahia").abreviatura,
      timeB: findTimebyName("Athletico Paranaense").abreviatura,
      escudoA: AppIcons.bahia,
      escudoB: AppIcons.athleticoPar,
    ),
    Jogo(
      timeA: findTimebyName("Coritiba").abreviatura,
      timeB: findTimebyName("Vasco").abreviatura,
      escudoA: AppIcons.coxa,
      escudoB: AppIcons.vasco,
    ),
    Jogo(
      timeA: findTimebyName("Fluminense").abreviatura,
      timeB: findTimebyName("Corinthians").abreviatura,
      escudoA: AppIcons.nense,
      escudoB: AppIcons.timao,
    ),
    Jogo(
      timeA: findTimebyName("Santos").abreviatura,
      timeB: findTimebyName("Remo").abreviatura,
      escudoA: AppIcons.santos,
      escudoB: AppIcons.remo,
    ),
    Jogo(
      timeA: findTimebyName("Chapecoense").abreviatura,
      timeB: findTimebyName("Atlético Mineiro").abreviatura,
      escudoA: AppIcons.chape,
      escudoB: AppIcons.atleticoMg,
    ),
    Jogo(
      timeA: findTimebyName("Palmeiras").abreviatura,
      timeB: findTimebyName("Grêmio").abreviatura,
      escudoA: AppIcons.verdao,
      escudoB: AppIcons.gremio,
    ),
    Jogo(
      timeA: findTimebyName("Bragantino").abreviatura,
      timeB: findTimebyName("Flamengo").abreviatura,
      escudoA: AppIcons.bragantino,
      escudoB: AppIcons.mengo,
    ),
  ],
),

//-------------------------------------------------------
// 10ª RODADA
Rodada(
  numero: 10,
  data: "2026-04-04",
  jogos: [
    Jogo(
      timeA: findTimebyName("São Paulo").abreviatura,
      timeB: findTimebyName("Cruzeiro").abreviatura,
      escudoA: AppIcons.saoPaulo,
      escudoB: AppIcons.zero,
    ),
    Jogo(
      timeA: findTimebyName("Coritiba").abreviatura,
      timeB: findTimebyName("Fluminense").abreviatura,
      escudoA: AppIcons.coxa,
      escudoB: AppIcons.nense,
    ),
    Jogo(
      timeA: findTimebyName("Vasco").abreviatura,
      timeB: findTimebyName("Botafogo").abreviatura,
      escudoA: AppIcons.vasco,
      escudoB: AppIcons.botafogo,
    ),
    Jogo(
      timeA: findTimebyName("Chapecoense").abreviatura,
      timeB: findTimebyName("Vitória").abreviatura,
      escudoA: AppIcons.chape,
      escudoB: AppIcons.vitoria,
    ),
    Jogo(
      timeA: findTimebyName("Flamengo").abreviatura,
      timeB: findTimebyName("Santos").abreviatura,
      escudoA: AppIcons.mengo,
      escudoB: AppIcons.santos,
    ),
    Jogo(
      timeA: findTimebyName("Atlético Mineiro").abreviatura,
      timeB: findTimebyName("Athletico Paranaense").abreviatura,
      escudoA: AppIcons.atleticoMg,
      escudoB: AppIcons.athleticoPar,
    ),
    Jogo(
      timeA: findTimebyName("Corinthians").abreviatura,
      timeB: findTimebyName("Internacional").abreviatura,
      escudoA: AppIcons.timao,
      escudoB: AppIcons.inter,
    ),
    Jogo(
      timeA: findTimebyName("Bahia").abreviatura,
      timeB: findTimebyName("Palmeiras").abreviatura,
      escudoA: AppIcons.bahia,
      escudoB: AppIcons.verdao,
    ),
    Jogo(
      timeA: findTimebyName("Mirassol").abreviatura,
      timeB: findTimebyName("Bragantino").abreviatura,
      escudoA: AppIcons.mirassol,
      escudoB: AppIcons.bragantino,
    ),
    Jogo(
      timeA: findTimebyName("Grêmio").abreviatura,
      timeB: findTimebyName("Remo").abreviatura,
      escudoA: AppIcons.gremio,
      escudoB: AppIcons.remo,
    ),
  ],
),

Rodada(
  numero: 11,
  data: "2026-04-11",
  jogos: [
    Jogo(timeA: findTimebyName("Vitória").abreviatura, timeB: findTimebyName("São Paulo").abreviatura, escudoA: AppIcons.vitoria, escudoB: AppIcons.saoPaulo),
    Jogo(timeA: findTimebyName("Remo").abreviatura, timeB: findTimebyName("Vasco").abreviatura, escudoA: AppIcons.remo, escudoB: AppIcons.vasco),
    Jogo(timeA: findTimebyName("Fluminense").abreviatura, timeB: findTimebyName("Flamengo").abreviatura, escudoA: AppIcons.nense, escudoB: AppIcons.mengo),
    Jogo(timeA: findTimebyName("Mirassol").abreviatura, timeB: findTimebyName("Bahia").abreviatura, escudoA: AppIcons.mirassol, escudoB: AppIcons.bahia),
    Jogo(timeA: findTimebyName("Santos").abreviatura, timeB: findTimebyName("Atlético Mineiro").abreviatura, escudoA: AppIcons.santos, escudoB: AppIcons.atleticoMg),
    Jogo(timeA: findTimebyName("Internacional").abreviatura, timeB: findTimebyName("Grêmio").abreviatura, escudoA: AppIcons.inter, escudoB: AppIcons.gremio),
    Jogo(timeA: findTimebyName("Athletico Paranaense").abreviatura, timeB: findTimebyName("Chapecoense").abreviatura, escudoA: AppIcons.athleticoPar, escudoB: AppIcons.chape),
    Jogo(timeA: findTimebyName("Botafogo").abreviatura, timeB: findTimebyName("Coritiba").abreviatura, escudoA: AppIcons.botafogo, escudoB: AppIcons.coxa),
    Jogo(timeA: findTimebyName("Corinthians").abreviatura, timeB: findTimebyName("Palmeiras").abreviatura, escudoA: AppIcons.timao, escudoB: AppIcons.verdao),
    Jogo(timeA: findTimebyName("Cruzeiro").abreviatura, timeB: findTimebyName("Bragantino").abreviatura, escudoA: AppIcons.zero, escudoB: AppIcons.bragantino),
  ],
),

Rodada(
  numero: 12,
  data: "2026-04-18",
  jogos: [
    Jogo(timeA: findTimebyName("Vasco").abreviatura, timeB: findTimebyName("São Paulo").abreviatura, escudoA: AppIcons.vasco, escudoB: AppIcons.saoPaulo),
    Jogo(timeA: findTimebyName("Chapecoense").abreviatura, timeB: findTimebyName("Botafogo").abreviatura, escudoA: AppIcons.chape, escudoB: AppIcons.botafogo),
    Jogo(timeA: findTimebyName("Vitória").abreviatura, timeB: findTimebyName("Corinthians").abreviatura, escudoA: AppIcons.vitoria, escudoB: AppIcons.timao),
    Jogo(timeA: findTimebyName("Cruzeiro").abreviatura, timeB: findTimebyName("Grêmio").abreviatura, escudoA: AppIcons.zero, escudoB: AppIcons.gremio),
    Jogo(timeA: findTimebyName("Internacional").abreviatura, timeB: findTimebyName("Mirassol").abreviatura, escudoA: AppIcons.inter, escudoB: AppIcons.mirassol),
    Jogo(timeA: findTimebyName("Santos").abreviatura, timeB: findTimebyName("Fluminense").abreviatura, escudoA: AppIcons.santos, escudoB: AppIcons.nense),
    Jogo(timeA: findTimebyName("Coritiba").abreviatura, timeB: findTimebyName("Atlético Mineiro").abreviatura, escudoA: AppIcons.coxa, escudoB: AppIcons.atleticoMg),
    Jogo(timeA: findTimebyName("Palmeiras").abreviatura, timeB: findTimebyName("Athletico Paranaense").abreviatura, escudoA: AppIcons.verdao, escudoB: AppIcons.athleticoPar),
    Jogo(timeA: findTimebyName("Bragantino").abreviatura, timeB: findTimebyName("Remo").abreviatura, escudoA: AppIcons.bragantino, escudoB: AppIcons.remo),
    Jogo(timeA: findTimebyName("Flamengo").abreviatura, timeB: findTimebyName("Bahia").abreviatura, escudoA: AppIcons.mengo, escudoB: AppIcons.bahia),
  ],
),

  Rodada(
  numero: 13,
  data: "2026-04-25",
  jogos: [
    Jogo(
      timeA: findTimebyName("Botafogo").abreviatura,
      timeB: findTimebyName("Internacional").abreviatura,
      escudoA: AppIcons.botafogo,
      escudoB: AppIcons.inter,
    ),
    Jogo(
      timeA: findTimebyName("Bahia").abreviatura,
      timeB: findTimebyName("Santos").abreviatura,
      escudoA: AppIcons.bahia,
      escudoB: AppIcons.santos,
    ),
    Jogo(
      timeA: findTimebyName("Remo").abreviatura,
      timeB: findTimebyName("Cruzeiro").abreviatura,
      escudoA: AppIcons.remo,
      escudoB: AppIcons.zero,
    ),
    Jogo(
      timeA: findTimebyName("São Paulo").abreviatura,
      timeB: findTimebyName("Mirassol").abreviatura,
      escudoA: AppIcons.saoPaulo,
      escudoB: AppIcons.mirassol,
    ),
    Jogo(
      timeA: findTimebyName("Corinthians").abreviatura,
      timeB: findTimebyName("Vasco").abreviatura,
      escudoA: AppIcons.timao,
      escudoB: AppIcons.vasco,
    ),
    Jogo(
      timeA: findTimebyName("Grêmio").abreviatura,
      timeB: findTimebyName("Coritiba").abreviatura,
      escudoA: AppIcons.gremio,
      escudoB: AppIcons.coxa,
    ),
    Jogo(
      timeA: findTimebyName("Bragantino").abreviatura,
      timeB: findTimebyName("Palmeiras").abreviatura,
      escudoA: AppIcons.bragantino,
      escudoB: AppIcons.verdao,
    ),
    Jogo(
      timeA: findTimebyName("Athletico Paranaense").abreviatura,
      timeB: findTimebyName("Vitória").abreviatura,
      escudoA: AppIcons.athleticoPar,
      escudoB: AppIcons.vitoria,
    ),
    Jogo(
      timeA: findTimebyName("Fluminense").abreviatura,
      timeB: findTimebyName("Chapecoense").abreviatura,
      escudoA: AppIcons.nense,
      escudoB: AppIcons.chape,
    ),
    Jogo(
      timeA: findTimebyName("Atlético Mineiro").abreviatura,
      timeB: findTimebyName("Flamengo").abreviatura,
      escudoA: AppIcons.atleticoMg,
      escudoB: AppIcons.mengo,
    ),
  ],
),

// 14ª RODADA
Rodada(
  numero: 14,
  data: "2026-05-02",
  jogos: [
    Jogo(timeA: findTimebyName("Botafogo").abreviatura, timeB: findTimebyName("Remo").abreviatura, escudoA: AppIcons.botafogo, escudoB: AppIcons.remo),
    Jogo(timeA: findTimebyName("Vitória").abreviatura, timeB: findTimebyName("Coritiba").abreviatura, escudoA: AppIcons.vitoria, escudoB: AppIcons.coxa),
    Jogo(timeA: findTimebyName("Palmeiras").abreviatura, timeB: findTimebyName("Santos").abreviatura, escudoA: AppIcons.verdao, escudoB: AppIcons.santos),
    Jogo(timeA: findTimebyName("Athletico Paranaense").abreviatura, timeB: findTimebyName("Grêmio").abreviatura, escudoA: AppIcons.athleticoPar, escudoB: AppIcons.gremio),
    Jogo(timeA: findTimebyName("Cruzeiro").abreviatura, timeB: findTimebyName("Atlético Mineiro").abreviatura, escudoA: AppIcons.zero, escudoB: AppIcons.atleticoMg),
    Jogo(timeA: findTimebyName("Flamengo").abreviatura, timeB: findTimebyName("Vasco").abreviatura, escudoA: AppIcons.mengo, escudoB: AppIcons.vasco),
    Jogo(timeA: findTimebyName("São Paulo").abreviatura, timeB: findTimebyName("Bahia").abreviatura, escudoA: AppIcons.saoPaulo, escudoB: AppIcons.bahia),
    Jogo(timeA: findTimebyName("Internacional").abreviatura, timeB: findTimebyName("Fluminense").abreviatura, escudoA: AppIcons.inter, escudoB: AppIcons.nense),
    Jogo(timeA: findTimebyName("Chapecoense").abreviatura, timeB: findTimebyName("Bragantino").abreviatura, escudoA: AppIcons.chape, escudoB: AppIcons.bragantino),
    Jogo(timeA: findTimebyName("Mirassol").abreviatura, timeB: findTimebyName("Corinthians").abreviatura, escudoA: AppIcons.mirassol, escudoB: AppIcons.timao),
  ],
),

// 15ª RODADA
Rodada(
  numero: 15,
  data: "2026-05-09",
  jogos: [
    Jogo(timeA: findTimebyName("Coritiba").abreviatura, timeB: findTimebyName("Internacional").abreviatura, escudoA: AppIcons.coxa, escudoB: AppIcons.inter),
    Jogo(timeA: findTimebyName("Fluminense").abreviatura, timeB: findTimebyName("Vitória").abreviatura, escudoA: AppIcons.nense, escudoB: AppIcons.vitoria),
    Jogo(timeA: findTimebyName("Bahia").abreviatura, timeB: findTimebyName("Cruzeiro").abreviatura, escudoA: AppIcons.bahia, escudoB: AppIcons.zero),
    Jogo(timeA: findTimebyName("Atlético Mineiro").abreviatura, timeB: findTimebyName("Botafogo").abreviatura, escudoA: AppIcons.atleticoMg, escudoB: AppIcons.botafogo),
    Jogo(timeA: findTimebyName("Remo").abreviatura, timeB: findTimebyName("Palmeiras").abreviatura, escudoA: AppIcons.remo, escudoB: AppIcons.verdao),
    Jogo(timeA: findTimebyName("Santos").abreviatura, timeB: findTimebyName("Bragantino").abreviatura, escudoA: AppIcons.santos, escudoB: AppIcons.bragantino),
    Jogo(timeA: findTimebyName("Corinthians").abreviatura, timeB: findTimebyName("São Paulo").abreviatura, escudoA: AppIcons.timao, escudoB: AppIcons.saoPaulo),
    Jogo(timeA: findTimebyName("Mirassol").abreviatura, timeB: findTimebyName("Chapecoense").abreviatura, escudoA: AppIcons.mirassol, escudoB: AppIcons.chape),
    Jogo(timeA: findTimebyName("Grêmio").abreviatura, timeB: findTimebyName("Flamengo").abreviatura, escudoA: AppIcons.gremio, escudoB: AppIcons.mengo),
    Jogo(timeA: findTimebyName("Vasco").abreviatura, timeB: findTimebyName("Athletico Paranaense").abreviatura, escudoA: AppIcons.vasco, escudoB: AppIcons.athleticoPar),
  ],
),

// 16ª RODADA
Rodada(
  numero: 16,
  data: "2026-05-16",
  jogos: [
    Jogo(timeA: findTimebyName("Atlético Mineiro").abreviatura, timeB: findTimebyName("Mirassol").abreviatura, escudoA: AppIcons.atleticoMg, escudoB: AppIcons.mirassol),
    Jogo(timeA: findTimebyName("Internacional").abreviatura, timeB: findTimebyName("Vasco").abreviatura, escudoA: AppIcons.inter, escudoB: AppIcons.vasco),
    Jogo(timeA: findTimebyName("Fluminense").abreviatura, timeB: findTimebyName("São Paulo").abreviatura, escudoA: AppIcons.nense, escudoB: AppIcons.saoPaulo),
    Jogo(timeA: findTimebyName("Palmeiras").abreviatura, timeB: findTimebyName("Cruzeiro").abreviatura, escudoA: AppIcons.verdao, escudoB: AppIcons.zero),
    Jogo(timeA: findTimebyName("Santos").abreviatura, timeB: findTimebyName("Coritiba").abreviatura, escudoA: AppIcons.santos, escudoB: AppIcons.coxa),
    Jogo(timeA: findTimebyName("Botafogo").abreviatura, timeB: findTimebyName("Corinthians").abreviatura, escudoA: AppIcons.botafogo, escudoB: AppIcons.timao),
    Jogo(timeA: findTimebyName("Bahia").abreviatura, timeB: findTimebyName("Grêmio").abreviatura, escudoA: AppIcons.bahia, escudoB: AppIcons.gremio),
    Jogo(timeA: findTimebyName("Bragantino").abreviatura, timeB: findTimebyName("Vitória").abreviatura, escudoA: AppIcons.bragantino, escudoB: AppIcons.vitoria),
    Jogo(timeA: findTimebyName("Chapecoense").abreviatura, timeB: findTimebyName("Remo").abreviatura, escudoA: AppIcons.chape, escudoB: AppIcons.remo),
    Jogo(timeA: findTimebyName("Athletico Paranaense").abreviatura, timeB: findTimebyName("Flamengo").abreviatura, escudoA: AppIcons.athleticoPar, escudoB: AppIcons.mengo),
  ],
),

// 17ª RODADA
Rodada(
  numero: 17,
  data: "2026-05-23",
  jogos: [
    Jogo(timeA: findTimebyName("São Paulo").abreviatura, timeB: findTimebyName("Botafogo").abreviatura, escudoA: AppIcons.saoPaulo, escudoB: AppIcons.botafogo),
    Jogo(timeA: findTimebyName("Vitória").abreviatura, timeB: findTimebyName("Internacional").abreviatura, escudoA: AppIcons.vitoria, escudoB: AppIcons.inter),
    Jogo(timeA: findTimebyName("Mirassol").abreviatura, timeB: findTimebyName("Fluminense").abreviatura, escudoA: AppIcons.mirassol, escudoB: AppIcons.nense),
    Jogo(timeA: findTimebyName("Grêmio").abreviatura, timeB: findTimebyName("Santos").abreviatura, escudoA: AppIcons.gremio, escudoB: AppIcons.santos),
    Jogo(timeA: findTimebyName("Flamengo").abreviatura, timeB: findTimebyName("Palmeiras").abreviatura, escudoA: AppIcons.mengo, escudoB: AppIcons.verdao),
    Jogo(timeA: findTimebyName("Cruzeiro").abreviatura, timeB: findTimebyName("Chapecoense").abreviatura, escudoA: AppIcons.zero, escudoB: AppIcons.chape),
    Jogo(timeA: findTimebyName("Remo").abreviatura, timeB: findTimebyName("Athletico Paranaense").abreviatura, escudoA: AppIcons.remo, escudoB: AppIcons.athleticoPar),
    Jogo(timeA: findTimebyName("Corinthians").abreviatura, timeB: findTimebyName("Atlético Mineiro").abreviatura, escudoA: AppIcons.timao, escudoB: AppIcons.atleticoMg),
    Jogo(timeA: findTimebyName("Vasco").abreviatura, timeB: findTimebyName("Bragantino").abreviatura, escudoA: AppIcons.vasco, escudoB: AppIcons.bragantino),
    Jogo(timeA: findTimebyName("Coritiba").abreviatura, timeB: findTimebyName("Bahia").abreviatura, escudoA: AppIcons.coxa, escudoB: AppIcons.bahia),
  ],
),

// 18ª RODADA
Rodada(
  numero: 18,
  data: "2026-05-31",
  jogos: [
    Jogo(timeA: findTimebyName("Flamengo").abreviatura, timeB: findTimebyName("Coritiba").abreviatura, escudoA: AppIcons.mengo, escudoB: AppIcons.coxa),
    Jogo(timeA: findTimebyName("Vasco").abreviatura, timeB: findTimebyName("Atlético Mineiro").abreviatura, escudoA: AppIcons.vasco, escudoB: AppIcons.atleticoMg),
    Jogo(timeA: findTimebyName("Santos").abreviatura, timeB: findTimebyName("Vitória").abreviatura, escudoA: AppIcons.santos, escudoB: AppIcons.vitoria),
    Jogo(timeA: findTimebyName("Palmeiras").abreviatura, timeB: findTimebyName("Chapecoense").abreviatura, escudoA: AppIcons.verdao, escudoB: AppIcons.chape),
    Jogo(timeA: findTimebyName("Bragantino").abreviatura, timeB: findTimebyName("Internacional").abreviatura, escudoA: AppIcons.bragantino, escudoB: AppIcons.inter),
    Jogo(timeA: findTimebyName("Cruzeiro").abreviatura, timeB: findTimebyName("Fluminense").abreviatura, escudoA: AppIcons.zero, escudoB: AppIcons.nense),
    Jogo(timeA: findTimebyName("Grêmio").abreviatura, timeB: findTimebyName("Corinthians").abreviatura, escudoA: AppIcons.gremio, escudoB: AppIcons.timao),
    Jogo(timeA: findTimebyName("Athletico Paranaense").abreviatura, timeB: findTimebyName("Mirassol").abreviatura, escudoA: AppIcons.athleticoPar, escudoB: AppIcons.mirassol),
    Jogo(timeA: findTimebyName("Bahia").abreviatura, timeB: findTimebyName("Botafogo").abreviatura, escudoA: AppIcons.bahia, escudoB: AppIcons.botafogo),
    Jogo(timeA: findTimebyName("Remo").abreviatura, timeB: findTimebyName("São Paulo").abreviatura, escudoA: AppIcons.remo, escudoB: AppIcons.saoPaulo),
  ],
),

// 19ª RODADA
Rodada(
  numero: 19,
  data: "2026-07-22",
  jogos: [
    Jogo(timeA: findTimebyName("Fluminense").abreviatura, timeB: findTimebyName("Bragantino").abreviatura, escudoA: AppIcons.nense, escudoB: AppIcons.bragantino),
    Jogo(timeA: findTimebyName("Botafogo").abreviatura, timeB: findTimebyName("Santos").abreviatura, escudoA: AppIcons.botafogo, escudoB: AppIcons.santos),
    Jogo(timeA: findTimebyName("São Paulo").abreviatura, timeB: findTimebyName("Athletico Paranaense").abreviatura, escudoA: AppIcons.saoPaulo, escudoB: AppIcons.athleticoPar),
    Jogo(timeA: findTimebyName("Corinthians").abreviatura, timeB: findTimebyName("Remo").abreviatura, escudoA: AppIcons.timao, escudoB: AppIcons.remo),
    Jogo(timeA: findTimebyName("Mirassol").abreviatura, timeB: findTimebyName("Grêmio").abreviatura, escudoA: AppIcons.mirassol, escudoB: AppIcons.gremio),
    Jogo(timeA: findTimebyName("Atlético Mineiro").abreviatura, timeB: findTimebyName("Bahia").abreviatura, escudoA: AppIcons.atleticoMg, escudoB: AppIcons.bahia),
    Jogo(timeA: findTimebyName("Internacional").abreviatura, timeB: findTimebyName("Cruzeiro").abreviatura, escudoA: AppIcons.inter, escudoB: AppIcons.zero),
    Jogo(timeA: findTimebyName("Coritiba").abreviatura, timeB: findTimebyName("Palmeiras").abreviatura, escudoA: AppIcons.coxa, escudoB: AppIcons.verdao),
    Jogo(timeA: findTimebyName("Vitória").abreviatura, timeB: findTimebyName("Vasco").abreviatura, escudoA: AppIcons.vitoria, escudoB: AppIcons.vasco),
    Jogo(timeA: findTimebyName("Chapecoense").abreviatura, timeB: findTimebyName("Flamengo").abreviatura, escudoA: AppIcons.chape, escudoB: AppIcons.mengo),
  ],
),

// 20ª RODADA
Rodada(
  numero: 20,
  data: "2026-07-26",
  jogos: [
    Jogo(timeA: findTimebyName("Bragantino").abreviatura, timeB: findTimebyName("Coritiba").abreviatura, escudoA: AppIcons.bragantino, escudoB: AppIcons.coxa),
    Jogo(timeA: findTimebyName("Cruzeiro").abreviatura, timeB: findTimebyName("Botafogo").abreviatura, escudoA: AppIcons.zero, escudoB: AppIcons.botafogo),
    Jogo(timeA: findTimebyName("Grêmio").abreviatura, timeB: findTimebyName("Fluminense").abreviatura, escudoA: AppIcons.gremio, escudoB: AppIcons.nense),
    Jogo(timeA: findTimebyName("Athletico Paranaense").abreviatura, timeB: findTimebyName("Internacional").abreviatura, escudoA: AppIcons.athleticoPar, escudoB: AppIcons.inter),
    Jogo(timeA: findTimebyName("Bahia").abreviatura, timeB: findTimebyName("Corinthians").abreviatura, escudoA: AppIcons.bahia, escudoB: AppIcons.timao),
    Jogo(timeA: findTimebyName("Remo").abreviatura, timeB: findTimebyName("Vitória").abreviatura, escudoA: AppIcons.remo, escudoB: AppIcons.vitoria),
    Jogo(timeA: findTimebyName("Flamengo").abreviatura, timeB: findTimebyName("São Paulo").abreviatura, escudoA: AppIcons.mengo, escudoB: AppIcons.saoPaulo),
    Jogo(timeA: findTimebyName("Vasco").abreviatura, timeB: findTimebyName("Mirassol").abreviatura, escudoA: AppIcons.vasco, escudoB: AppIcons.mirassol),
    Jogo(timeA: findTimebyName("Santos").abreviatura, timeB: findTimebyName("Chapecoense").abreviatura, escudoA: AppIcons.santos, escudoB: AppIcons.chape),
    Jogo(timeA: findTimebyName("Palmeiras").abreviatura, timeB: findTimebyName("Atlético Mineiro").abreviatura, escudoA: AppIcons.verdao, escudoB: AppIcons.atleticoMg),
  ],
),

// 21ª RODADA
Rodada(
  numero: 21,
  data: "2026-07-29",
  jogos: [
    Jogo(timeA: findTimebyName("Fluminense").abreviatura, timeB: findTimebyName("Bahia").abreviatura, escudoA: AppIcons.nense, escudoB: AppIcons.bahia),
    Jogo(timeA: findTimebyName("Botafogo").abreviatura, timeB: findTimebyName("Grêmio").abreviatura, escudoA: AppIcons.botafogo, escudoB: AppIcons.gremio),
    Jogo(timeA: findTimebyName("São Paulo").abreviatura, timeB: findTimebyName("Santos").abreviatura, escudoA: AppIcons.saoPaulo, escudoB: AppIcons.santos),
    Jogo(timeA: findTimebyName("Corinthians").abreviatura, timeB: findTimebyName("Athletico Paranaense").abreviatura, escudoA: AppIcons.timao, escudoB: AppIcons.athleticoPar),
    Jogo(timeA: findTimebyName("Mirassol").abreviatura, timeB: findTimebyName("Remo").abreviatura, escudoA: AppIcons.mirassol, escudoB: AppIcons.remo),
    Jogo(timeA: findTimebyName("Atlético Mineiro").abreviatura, timeB: findTimebyName("Bragantino").abreviatura, escudoA: AppIcons.atleticoMg, escudoB: AppIcons.bragantino),
    Jogo(timeA: findTimebyName("Internacional").abreviatura, timeB: findTimebyName("Flamengo").abreviatura, escudoA: AppIcons.inter, escudoB: AppIcons.mengo),
    Jogo(timeA: findTimebyName("Coritiba").abreviatura, timeB: findTimebyName("Cruzeiro").abreviatura, escudoA: AppIcons.coxa, escudoB: AppIcons.zero),
    Jogo(timeA: findTimebyName("Vitória").abreviatura, timeB: findTimebyName("Palmeiras").abreviatura, escudoA: AppIcons.vitoria, escudoB: AppIcons.verdao),
    Jogo(timeA: findTimebyName("Chapecoense").abreviatura, timeB: findTimebyName("Vasco").abreviatura, escudoA: AppIcons.chape, escudoB: AppIcons.vasco),
  ],
),

// 22ª RODADA
Rodada(
  numero: 22,
  data: "2026-08-09",
  jogos: [
    Jogo(timeA: findTimebyName("Flamengo").abreviatura, timeB: findTimebyName("Vitória").abreviatura, escudoA: AppIcons.mengo, escudoB: AppIcons.vitoria),
    Jogo(timeA: findTimebyName("Botafogo").abreviatura, timeB: findTimebyName("Fluminense").abreviatura, escudoA: AppIcons.botafogo, escudoB: AppIcons.nense),
    Jogo(timeA: findTimebyName("Santos").abreviatura, timeB: findTimebyName("Athletico Paranaense").abreviatura, escudoA: AppIcons.santos, escudoB: AppIcons.athleticoPar),
    Jogo(timeA: findTimebyName("Palmeiras").abreviatura, timeB: findTimebyName("Internacional").abreviatura, escudoA: AppIcons.verdao, escudoB: AppIcons.inter),
    Jogo(timeA: findTimebyName("Bragantino").abreviatura, timeB: findTimebyName("Corinthians").abreviatura, escudoA: AppIcons.bragantino, escudoB: AppIcons.timao),
    Jogo(timeA: findTimebyName("Cruzeiro").abreviatura, timeB: findTimebyName("Mirassol").abreviatura, escudoA: AppIcons.zero, escudoB: AppIcons.mirassol),
    Jogo(timeA: findTimebyName("Grêmio").abreviatura, timeB: findTimebyName("São Paulo").abreviatura, escudoA: AppIcons.gremio, escudoB: AppIcons.saoPaulo),
    Jogo(timeA: findTimebyName("Coritiba").abreviatura, timeB: findTimebyName("Chapecoense").abreviatura, escudoA: AppIcons.coxa, escudoB: AppIcons.chape),
    Jogo(timeA: findTimebyName("Bahia").abreviatura, timeB: findTimebyName("Vasco").abreviatura, escudoA: AppIcons.bahia, escudoB: AppIcons.vasco),
    Jogo(timeA: findTimebyName("Remo").abreviatura, timeB: findTimebyName("Atlético Mineiro").abreviatura, escudoA: AppIcons.remo, escudoB: AppIcons.atleticoMg),
  ],
),

// 23ª RODADA
Rodada(
  numero: 23,
  data: "2026-08-16",
  jogos: [
    Jogo(timeA: findTimebyName("Fluminense").abreviatura, timeB: findTimebyName("Palmeiras").abreviatura, escudoA: AppIcons.nense, escudoB: AppIcons.verdao),
    Jogo(timeA: findTimebyName("Vasco").abreviatura, timeB: findTimebyName("Santos").abreviatura, escudoA: AppIcons.vasco, escudoB: AppIcons.santos),
    Jogo(timeA: findTimebyName("São Paulo").abreviatura, timeB: findTimebyName("Coritiba").abreviatura, escudoA: AppIcons.saoPaulo, escudoB: AppIcons.coxa),
    Jogo(timeA: findTimebyName("Corinthians").abreviatura, timeB: findTimebyName("Cruzeiro").abreviatura, escudoA: AppIcons.timao, escudoB: AppIcons.zero),
    Jogo(timeA: findTimebyName("Mirassol").abreviatura, timeB: findTimebyName("Flamengo").abreviatura, escudoA: AppIcons.mirassol, escudoB: AppIcons.mengo),
    Jogo(timeA: findTimebyName("Atlético Mineiro").abreviatura, timeB: findTimebyName("Grêmio").abreviatura, escudoA: AppIcons.atleticoMg, escudoB: AppIcons.gremio),
    Jogo(timeA: findTimebyName("Internacional").abreviatura, timeB: findTimebyName("Remo").abreviatura, escudoA: AppIcons.inter, escudoB: AppIcons.remo),
    Jogo(timeA: findTimebyName("Athletico Paranaense").abreviatura, timeB: findTimebyName("Bragantino").abreviatura, escudoA: AppIcons.athleticoPar, escudoB: AppIcons.bragantino),
    Jogo(timeA: findTimebyName("Vitória").abreviatura, timeB: findTimebyName("Botafogo").abreviatura, escudoA: AppIcons.vitoria, escudoB: AppIcons.botafogo),
    Jogo(timeA: findTimebyName("Chapecoense").abreviatura, timeB: findTimebyName("Bahia").abreviatura, escudoA: AppIcons.chape, escudoB: AppIcons.bahia),
  ],
),
// 24ª RODADA
Rodada(
  numero: 24,
  data: "2026-08-23",
  jogos: [
    Jogo(timeA: findTimebyName("Fluminense").abreviatura, timeB: findTimebyName("Remo").abreviatura, escudoA: AppIcons.nense, escudoB: AppIcons.remo),
    Jogo(timeA: findTimebyName("Botafogo").abreviatura, timeB: findTimebyName("Athletico Paranaense").abreviatura, escudoA: AppIcons.botafogo, escudoB: AppIcons.athleticoPar),
    Jogo(timeA: findTimebyName("Santos").abreviatura, timeB: findTimebyName("Mirassol").abreviatura, escudoA: AppIcons.santos, escudoB: AppIcons.mirassol),
    Jogo(timeA: findTimebyName("Palmeiras").abreviatura, timeB: findTimebyName("Vasco").abreviatura, escudoA: AppIcons.verdao, escudoB: AppIcons.vasco),
    Jogo(timeA: findTimebyName("Bragantino").abreviatura, timeB: findTimebyName("Grêmio").abreviatura, escudoA: AppIcons.bragantino, escudoB: AppIcons.gremio),
    Jogo(timeA: findTimebyName("Cruzeiro").abreviatura, timeB: findTimebyName("Flamengo").abreviatura, escudoA: AppIcons.zero, escudoB: AppIcons.mengo),
    Jogo(timeA: findTimebyName("Internacional").abreviatura, timeB: findTimebyName("Atlético Mineiro").abreviatura, escudoA: AppIcons.inter, escudoB: AppIcons.atleticoMg),
    Jogo(timeA: findTimebyName("Coritiba").abreviatura, timeB: findTimebyName("Corinthians").abreviatura, escudoA: AppIcons.coxa, escudoB: AppIcons.timao),
    Jogo(timeA: findTimebyName("Vitória").abreviatura, timeB: findTimebyName("Bahia").abreviatura, escudoA: AppIcons.vitoria, escudoB: AppIcons.bahia),
    Jogo(timeA: findTimebyName("Chapecoense").abreviatura, timeB: findTimebyName("São Paulo").abreviatura, escudoA: AppIcons.chape, escudoB: AppIcons.saoPaulo),
  ],
),

// 25ª RODADA
Rodada(
  numero: 25,
  data: "2026-08-30",
  jogos: [
    Jogo(timeA: findTimebyName("Flamengo").abreviatura, timeB: findTimebyName("Botafogo").abreviatura, escudoA: AppIcons.mengo, escudoB: AppIcons.botafogo),
    Jogo(timeA: findTimebyName("Vasco").abreviatura, timeB: findTimebyName("Cruzeiro").abreviatura, escudoA: AppIcons.vasco, escudoB: AppIcons.zero),
    Jogo(timeA: findTimebyName("São Paulo").abreviatura, timeB: findTimebyName("Bragantino").abreviatura, escudoA: AppIcons.saoPaulo, escudoB: AppIcons.bragantino),
    Jogo(timeA: findTimebyName("Corinthians").abreviatura, timeB: findTimebyName("Santos").abreviatura, escudoA: AppIcons.timao, escudoB: AppIcons.santos),
    Jogo(timeA: findTimebyName("Mirassol").abreviatura, timeB: findTimebyName("Palmeiras").abreviatura, escudoA: AppIcons.mirassol, escudoB: AppIcons.verdao),
    Jogo(timeA: findTimebyName("Atlético Mineiro").abreviatura, timeB: findTimebyName("Vitória").abreviatura, escudoA: AppIcons.atleticoMg, escudoB: AppIcons.vitoria),
    Jogo(timeA: findTimebyName("Grêmio").abreviatura, timeB: findTimebyName("Chapecoense").abreviatura, escudoA: AppIcons.gremio, escudoB: AppIcons.chape),
    Jogo(timeA: findTimebyName("Athletico Paranaense").abreviatura, timeB: findTimebyName("Fluminense").abreviatura, escudoA: AppIcons.athleticoPar, escudoB: AppIcons.nense),
    Jogo(timeA: findTimebyName("Bahia").abreviatura, timeB: findTimebyName("Internacional").abreviatura, escudoA: AppIcons.bahia, escudoB: AppIcons.inter),
    Jogo(timeA: findTimebyName("Remo").abreviatura, timeB: findTimebyName("Coritiba").abreviatura, escudoA: AppIcons.remo, escudoB: AppIcons.coxa),
  ],
),

// 26ª RODADA
Rodada(
  numero: 26,
  data: "2026-09-06",
  jogos: [
    Jogo(timeA: findTimebyName("Fluminense").abreviatura, timeB: findTimebyName("Vasco").abreviatura, escudoA: AppIcons.nense, escudoB: AppIcons.vasco),
    Jogo(timeA: findTimebyName("Botafogo").abreviatura, timeB: findTimebyName("Palmeiras").abreviatura, escudoA: AppIcons.botafogo, escudoB: AppIcons.verdao),
    Jogo(timeA: findTimebyName("São Paulo").abreviatura, timeB: findTimebyName("Atlético Mineiro").abreviatura, escudoA: AppIcons.saoPaulo, escudoB: AppIcons.atleticoMg),
    Jogo(timeA: findTimebyName("Corinthians").abreviatura, timeB: findTimebyName("Chapecoense").abreviatura, escudoA: AppIcons.timao, escudoB: AppIcons.chape),
    Jogo(timeA: findTimebyName("Bragantino").abreviatura, timeB: findTimebyName("Bahia").abreviatura, escudoA: AppIcons.bragantino, escudoB: AppIcons.bahia),
    Jogo(timeA: findTimebyName("Cruzeiro").abreviatura, timeB: findTimebyName("Athletico Paranaense").abreviatura, escudoA: AppIcons.zero, escudoB: AppIcons.athleticoPar),
    Jogo(timeA: findTimebyName("Internacional").abreviatura, timeB: findTimebyName("Santos").abreviatura, escudoA: AppIcons.inter, escudoB: AppIcons.santos),
    Jogo(timeA: findTimebyName("Coritiba").abreviatura, timeB: findTimebyName("Mirassol").abreviatura, escudoA: AppIcons.coxa, escudoB: AppIcons.mirassol),
    Jogo(timeA: findTimebyName("Vitória").abreviatura, timeB: findTimebyName("Grêmio").abreviatura, escudoA: AppIcons.vitoria, escudoB: AppIcons.gremio),
    Jogo(timeA: findTimebyName("Remo").abreviatura, timeB: findTimebyName("Flamengo").abreviatura, escudoA: AppIcons.remo, escudoB: AppIcons.mengo),
  ],
),

// 27ª RODADA
Rodada(
  numero: 27,
  data: "2026-09-13",
  jogos: [
    Jogo(timeA: findTimebyName("Flamengo").abreviatura, timeB: findTimebyName("Corinthians").abreviatura, escudoA: AppIcons.mengo, escudoB: AppIcons.timao),
    Jogo(timeA: findTimebyName("Botafogo").abreviatura, timeB: findTimebyName("Bragantino").abreviatura, escudoA: AppIcons.botafogo, escudoB: AppIcons.bragantino),
    Jogo(timeA: findTimebyName("Santos").abreviatura, timeB: findTimebyName("Cruzeiro").abreviatura, escudoA: AppIcons.santos, escudoB: AppIcons.zero),
    Jogo(timeA: findTimebyName("Palmeiras").abreviatura, timeB: findTimebyName("São Paulo").abreviatura, escudoA: AppIcons.verdao, escudoB: AppIcons.saoPaulo),
    Jogo(timeA: findTimebyName("Mirassol").abreviatura, timeB: findTimebyName("Vitória").abreviatura, escudoA: AppIcons.mirassol, escudoB: AppIcons.vitoria),
    Jogo(timeA: findTimebyName("Atlético Mineiro").abreviatura, timeB: findTimebyName("Fluminense").abreviatura, escudoA: AppIcons.atleticoMg, escudoB: AppIcons.nense),
    Jogo(timeA: findTimebyName("Grêmio").abreviatura, timeB: findTimebyName("Vasco").abreviatura, escudoA: AppIcons.gremio, escudoB: AppIcons.vasco),
    Jogo(timeA: findTimebyName("Coritiba").abreviatura, timeB: findTimebyName("Athletico Paranaense").abreviatura, escudoA: AppIcons.coxa, escudoB: AppIcons.athleticoPar),
    Jogo(timeA: findTimebyName("Bahia").abreviatura, timeB: findTimebyName("Remo").abreviatura, escudoA: AppIcons.bahia, escudoB: AppIcons.remo),
    Jogo(timeA: findTimebyName("Chapecoense").abreviatura, timeB: findTimebyName("Internacional").abreviatura, escudoA: AppIcons.chape, escudoB: AppIcons.inter),
  ],
),

// 28ª RODADA
Rodada(
  numero: 28,
  data: "2026-09-20",
  jogos: [
    Jogo(timeA: findTimebyName("Flamengo").abreviatura, timeB: findTimebyName("Bragantino").abreviatura, escudoA: AppIcons.mengo, escudoB: AppIcons.bragantino),
    Jogo(timeA: findTimebyName("Vasco").abreviatura, timeB: findTimebyName("Coritiba").abreviatura, escudoA: AppIcons.vasco, escudoB: AppIcons.coxa),
    Jogo(timeA: findTimebyName("São Paulo").abreviatura, timeB: findTimebyName("Internacional").abreviatura, escudoA: AppIcons.saoPaulo, escudoB: AppIcons.inter),
    Jogo(timeA: findTimebyName("Corinthians").abreviatura, timeB: findTimebyName("Fluminense").abreviatura, escudoA: AppIcons.timao, escudoB: AppIcons.nense),
    Jogo(timeA: findTimebyName("Mirassol").abreviatura, timeB: findTimebyName("Botafogo").abreviatura, escudoA: AppIcons.mirassol, escudoB: AppIcons.botafogo),
    Jogo(timeA: findTimebyName("Atlético Mineiro").abreviatura, timeB: findTimebyName("Chapecoense").abreviatura, escudoA: AppIcons.atleticoMg, escudoB: AppIcons.chape),
    Jogo(timeA: findTimebyName("Grêmio").abreviatura, timeB: findTimebyName("Palmeiras").abreviatura, escudoA: AppIcons.gremio, escudoB: AppIcons.verdao),
    Jogo(timeA: findTimebyName("Athletico Paranaense").abreviatura, timeB: findTimebyName("Bahia").abreviatura, escudoA: AppIcons.athleticoPar, escudoB: AppIcons.bahia),
    Jogo(timeA: findTimebyName("Vitória").abreviatura, timeB: findTimebyName("Cruzeiro").abreviatura, escudoA: AppIcons.vitoria, escudoB: AppIcons.zero),
    Jogo(timeA: findTimebyName("Remo").abreviatura, timeB: findTimebyName("Santos").abreviatura, escudoA: AppIcons.remo, escudoB: AppIcons.santos),
  ],
),

// 29ª RODADA
Rodada(
  numero: 29,
  data: "2026-10-07",
  jogos: [
    Jogo(timeA: findTimebyName("Fluminense").abreviatura, timeB: findTimebyName("Coritiba").abreviatura, escudoA: AppIcons.nense, escudoB: AppIcons.coxa),
    Jogo(timeA: findTimebyName("Botafogo").abreviatura, timeB: findTimebyName("Vasco").abreviatura, escudoA: AppIcons.botafogo, escudoB: AppIcons.vasco),
    Jogo(timeA: findTimebyName("Santos").abreviatura, timeB: findTimebyName("Flamengo").abreviatura, escudoA: AppIcons.santos, escudoB: AppIcons.mengo),
    Jogo(timeA: findTimebyName("Palmeiras").abreviatura, timeB: findTimebyName("Bahia").abreviatura, escudoA: AppIcons.verdao, escudoB: AppIcons.bahia),
    Jogo(timeA: findTimebyName("Bragantino").abreviatura, timeB: findTimebyName("Mirassol").abreviatura, escudoA: AppIcons.bragantino, escudoB: AppIcons.mirassol),
    Jogo(timeA: findTimebyName("Cruzeiro").abreviatura, timeB: findTimebyName("São Paulo").abreviatura, escudoA: AppIcons.zero, escudoB: AppIcons.saoPaulo),
    Jogo(timeA: findTimebyName("Internacional").abreviatura, timeB: findTimebyName("Corinthians").abreviatura, escudoA: AppIcons.inter, escudoB: AppIcons.timao),
    Jogo(timeA: findTimebyName("Athletico Paranaense").abreviatura, timeB: findTimebyName("Atlético Mineiro").abreviatura, escudoA: AppIcons.athleticoPar, escudoB: AppIcons.atleticoMg),
    Jogo(timeA: findTimebyName("Vitória").abreviatura, timeB: findTimebyName("Chapecoense").abreviatura, escudoA: AppIcons.vitoria, escudoB: AppIcons.chape),
    Jogo(timeA: findTimebyName("Remo").abreviatura, timeB: findTimebyName("Grêmio").abreviatura, escudoA: AppIcons.remo, escudoB: AppIcons.gremio),
  ],
),

// 30ª RODADA
// 30ª RODADA
Rodada(
  numero: 30,
  data: "2026-10-11",
  jogos: [
    Jogo(timeA: findTimebyName("Flamengo").abreviatura, timeB: findTimebyName("Fluminense").abreviatura, escudoA: AppIcons.mengo, escudoB: AppIcons.nense),
    Jogo(timeA: findTimebyName("Vasco").abreviatura, timeB: findTimebyName("Remo").abreviatura, escudoA: AppIcons.vasco, escudoB: AppIcons.remo),
    Jogo(timeA: findTimebyName("São Paulo").abreviatura, timeB: findTimebyName("Vitória").abreviatura, escudoA: AppIcons.saoPaulo, escudoB: AppIcons.vitoria),
    Jogo(timeA: findTimebyName("Palmeiras").abreviatura, timeB: findTimebyName("Corinthians").abreviatura, escudoA: AppIcons.verdao, escudoB: AppIcons.timao),
    Jogo(timeA: findTimebyName("Bragantino").abreviatura, timeB: findTimebyName("Cruzeiro").abreviatura, escudoA: AppIcons.bragantino, escudoB: AppIcons.zero),
    Jogo(timeA: findTimebyName("Atlético Mineiro").abreviatura, timeB: findTimebyName("Santos").abreviatura, escudoA: AppIcons.atleticoMg, escudoB: AppIcons.santos),
    Jogo(timeA: findTimebyName("Grêmio").abreviatura, timeB: findTimebyName("Internacional").abreviatura, escudoA: AppIcons.gremio, escudoB: AppIcons.inter),
    Jogo(timeA: findTimebyName("Coritiba").abreviatura, timeB: findTimebyName("Botafogo").abreviatura, escudoA: AppIcons.coxa, escudoB: AppIcons.botafogo),
    Jogo(timeA: findTimebyName("Bahia").abreviatura, timeB: findTimebyName("Mirassol").abreviatura, escudoA: AppIcons.bahia, escudoB: AppIcons.mirassol),
    Jogo(timeA: findTimebyName("Chapecoense").abreviatura, timeB: findTimebyName("Athletico Paranaense").abreviatura, escudoA: AppIcons.chape, escudoB: AppIcons.athleticoPar),
  ],
),

// 31ª RODADA
Rodada(
  numero: 31,
  data: "2026-10-18",
  jogos: [
    Jogo(timeA: findTimebyName("Fluminense").abreviatura, timeB: findTimebyName("Santos").abreviatura, escudoA: AppIcons.nense, escudoB: AppIcons.santos),
    Jogo(timeA: findTimebyName("Botafogo").abreviatura, timeB: findTimebyName("Chapecoense").abreviatura, escudoA: AppIcons.botafogo, escudoB: AppIcons.chape),
    Jogo(timeA: findTimebyName("São Paulo").abreviatura, timeB: findTimebyName("Vasco").abreviatura, escudoA: AppIcons.saoPaulo, escudoB: AppIcons.vasco),
    Jogo(timeA: findTimebyName("Corinthians").abreviatura, timeB: findTimebyName("Vitória").abreviatura, escudoA: AppIcons.timao, escudoB: AppIcons.vitoria),
    Jogo(timeA: findTimebyName("Mirassol").abreviatura, timeB: findTimebyName("Internacional").abreviatura, escudoA: AppIcons.mirassol, escudoB: AppIcons.inter),
    Jogo(timeA: findTimebyName("Atlético Mineiro").abreviatura, timeB: findTimebyName("Coritiba").abreviatura, escudoA: AppIcons.atleticoMg, escudoB: AppIcons.coxa),
    Jogo(timeA: findTimebyName("Grêmio").abreviatura, timeB: findTimebyName("Cruzeiro").abreviatura, escudoA: AppIcons.gremio, escudoB: AppIcons.zero),
    Jogo(timeA: findTimebyName("Athletico Paranaense").abreviatura, timeB: findTimebyName("Palmeiras").abreviatura, escudoA: AppIcons.athleticoPar, escudoB: AppIcons.verdao),
    Jogo(timeA: findTimebyName("Bahia").abreviatura, timeB: findTimebyName("Flamengo").abreviatura, escudoA: AppIcons.bahia, escudoB: AppIcons.mengo),
    Jogo(timeA: findTimebyName("Remo").abreviatura, timeB: findTimebyName("Bragantino").abreviatura, escudoA: AppIcons.remo, escudoB: AppIcons.bragantino),
  ],
),

// 32ª RODADA
Rodada(
  numero: 32,
  data: "2026-10-25",
  jogos: [
    Jogo(timeA: findTimebyName("Flamengo").abreviatura, timeB: findTimebyName("Atlético Mineiro").abreviatura, escudoA: AppIcons.mengo, escudoB: AppIcons.atleticoMg),
    Jogo(timeA: findTimebyName("Vasco").abreviatura, timeB: findTimebyName("Corinthians").abreviatura, escudoA: AppIcons.vasco, escudoB: AppIcons.timao),
    Jogo(timeA: findTimebyName("Santos").abreviatura, timeB: findTimebyName("Bahia").abreviatura, escudoA: AppIcons.santos, escudoB: AppIcons.bahia),
    Jogo(timeA: findTimebyName("Palmeiras").abreviatura, timeB: findTimebyName("Bragantino").abreviatura, escudoA: AppIcons.verdao, escudoB: AppIcons.bragantino),
    Jogo(timeA: findTimebyName("Mirassol").abreviatura, timeB: findTimebyName("São Paulo").abreviatura, escudoA: AppIcons.mirassol, escudoB: AppIcons.saoPaulo),
    Jogo(timeA: findTimebyName("Cruzeiro").abreviatura, timeB: findTimebyName("Remo").abreviatura, escudoA: AppIcons.zero, escudoB: AppIcons.remo),
    Jogo(timeA: findTimebyName("Internacional").abreviatura, timeB: findTimebyName("Botafogo").abreviatura, escudoA: AppIcons.inter, escudoB: AppIcons.botafogo),
    Jogo(timeA: findTimebyName("Coritiba").abreviatura, timeB: findTimebyName("Grêmio").abreviatura, escudoA: AppIcons.coxa, escudoB: AppIcons.gremio),
    Jogo(timeA: findTimebyName("Vitória").abreviatura, timeB: findTimebyName("Athletico Paranaense").abreviatura, escudoA: AppIcons.vitoria, escudoB: AppIcons.athleticoPar),
    Jogo(timeA: findTimebyName("Chapecoense").abreviatura, timeB: findTimebyName("Fluminense").abreviatura, escudoA: AppIcons.chape, escudoB: AppIcons.nense),
  ],
),

// 33ª RODADA
Rodada(
  numero: 33,
  data: "2026-10-28",
  jogos: [
    Jogo(timeA: findTimebyName("Fluminense").abreviatura, timeB: findTimebyName("Internacional").abreviatura, escudoA: AppIcons.nense, escudoB: AppIcons.inter),
    Jogo(timeA: findTimebyName("Vasco").abreviatura, timeB: findTimebyName("Flamengo").abreviatura, escudoA: AppIcons.vasco, escudoB: AppIcons.mengo),
    Jogo(timeA: findTimebyName("Santos").abreviatura, timeB: findTimebyName("Palmeiras").abreviatura, escudoA: AppIcons.santos, escudoB: AppIcons.verdao),
    Jogo(timeA: findTimebyName("Corinthians").abreviatura, timeB: findTimebyName("Mirassol").abreviatura, escudoA: AppIcons.timao, escudoB: AppIcons.mirassol),
    Jogo(timeA: findTimebyName("Bragantino").abreviatura, timeB: findTimebyName("Chapecoense").abreviatura, escudoA: AppIcons.bragantino, escudoB: AppIcons.chape),
    Jogo(timeA: findTimebyName("Atlético Mineiro").abreviatura, timeB: findTimebyName("Cruzeiro").abreviatura, escudoA: AppIcons.atleticoMg, escudoB: AppIcons.zero),
    Jogo(timeA: findTimebyName("Grêmio").abreviatura, timeB: findTimebyName("Athletico Paranaense").abreviatura, escudoA: AppIcons.gremio, escudoB: AppIcons.athleticoPar),
    Jogo(timeA: findTimebyName("Coritiba").abreviatura, timeB: findTimebyName("Vitória").abreviatura, escudoA: AppIcons.coxa, escudoB: AppIcons.vitoria),
    Jogo(timeA: findTimebyName("Bahia").abreviatura, timeB: findTimebyName("São Paulo").abreviatura, escudoA: AppIcons.bahia, escudoB: AppIcons.saoPaulo),
    Jogo(timeA: findTimebyName("Remo").abreviatura, timeB: findTimebyName("Botafogo").abreviatura, escudoA: AppIcons.remo, escudoB: AppIcons.botafogo),
  ],
),

// 34ª RODADA
Rodada(
  numero: 34,
  data: "2026-11-04",
  jogos: [
    Jogo(timeA: findTimebyName("Flamengo").abreviatura, timeB: findTimebyName("Grêmio").abreviatura, escudoA: AppIcons.mengo, escudoB: AppIcons.gremio),
    Jogo(timeA: findTimebyName("Botafogo").abreviatura, timeB: findTimebyName("Atlético Mineiro").abreviatura, escudoA: AppIcons.botafogo, escudoB: AppIcons.atleticoMg),
    Jogo(timeA: findTimebyName("São Paulo").abreviatura, timeB: findTimebyName("Corinthians").abreviatura, escudoA: AppIcons.saoPaulo, escudoB: AppIcons.timao),
    Jogo(timeA: findTimebyName("Palmeiras").abreviatura, timeB: findTimebyName("Remo").abreviatura, escudoA: AppIcons.verdao, escudoB: AppIcons.remo),
    Jogo(timeA: findTimebyName("Bragantino").abreviatura, timeB: findTimebyName("Santos").abreviatura, escudoA: AppIcons.bragantino, escudoB: AppIcons.santos),
    Jogo(timeA: findTimebyName("Cruzeiro").abreviatura, timeB: findTimebyName("Bahia").abreviatura, escudoA: AppIcons.zero, escudoB: AppIcons.bahia),
    Jogo(timeA: findTimebyName("Internacional").abreviatura, timeB: findTimebyName("Coritiba").abreviatura, escudoA: AppIcons.inter, escudoB: AppIcons.coxa),
    Jogo(timeA: findTimebyName("Athletico Paranaense").abreviatura, timeB: findTimebyName("Vasco").abreviatura, escudoA: AppIcons.athleticoPar, escudoB: AppIcons.vasco),
    Jogo(timeA: findTimebyName("Vitória").abreviatura, timeB: findTimebyName("Fluminense").abreviatura, escudoA: AppIcons.vitoria, escudoB: AppIcons.nense),
    Jogo(timeA: findTimebyName("Chapecoense").abreviatura, timeB: findTimebyName("Mirassol").abreviatura, escudoA: AppIcons.chape, escudoB: AppIcons.mirassol),
  ],
),

// 35ª RODADA
Rodada(
  numero: 35,
  data: "2026-11-18",
  jogos: [
    Jogo(timeA: findTimebyName("Flamengo").abreviatura, timeB: findTimebyName("Athletico Paranaense").abreviatura, escudoA: AppIcons.mengo, escudoB: AppIcons.athleticoPar),
    Jogo(timeA: findTimebyName("Vasco").abreviatura, timeB: findTimebyName("Internacional").abreviatura, escudoA: AppIcons.vasco, escudoB: AppIcons.inter),
    Jogo(timeA: findTimebyName("São Paulo").abreviatura, timeB: findTimebyName("Fluminense").abreviatura, escudoA: AppIcons.saoPaulo, escudoB: AppIcons.nense),
    Jogo(timeA: findTimebyName("Corinthians").abreviatura, timeB: findTimebyName("Botafogo").abreviatura, escudoA: AppIcons.timao, escudoB: AppIcons.botafogo),
    Jogo(timeA: findTimebyName("Mirassol").abreviatura, timeB: findTimebyName("Atlético Mineiro").abreviatura, escudoA: AppIcons.mirassol, escudoB: AppIcons.atleticoMg),
    Jogo(timeA: findTimebyName("Cruzeiro").abreviatura, timeB: findTimebyName("Palmeiras").abreviatura, escudoA: AppIcons.zero, escudoB: AppIcons.verdao),
    Jogo(timeA: findTimebyName("Grêmio").abreviatura, timeB: findTimebyName("Bahia").abreviatura, escudoA: AppIcons.gremio, escudoB: AppIcons.bahia),
    Jogo(timeA: findTimebyName("Coritiba").abreviatura, timeB: findTimebyName("Santos").abreviatura, escudoA: AppIcons.coxa, escudoB: AppIcons.santos),
    Jogo(timeA: findTimebyName("Vitória").abreviatura, timeB: findTimebyName("Bragantino").abreviatura, escudoA: AppIcons.vitoria, escudoB: AppIcons.bragantino),
    Jogo(timeA: findTimebyName("Remo").abreviatura, timeB: findTimebyName("Chapecoense").abreviatura, escudoA: AppIcons.remo, escudoB: AppIcons.chape),
  ],
),

// 36ª RODADA
Rodada(
  numero: 36,
  data: "2026-11-22",
  jogos: [
    Jogo(timeA: findTimebyName("Fluminense").abreviatura, timeB: findTimebyName("Mirassol").abreviatura, escudoA: AppIcons.nense, escudoB: AppIcons.mirassol),
    Jogo(timeA: findTimebyName("Botafogo").abreviatura, timeB: findTimebyName("São Paulo").abreviatura, escudoA: AppIcons.botafogo, escudoB: AppIcons.saoPaulo),
    Jogo(timeA: findTimebyName("Santos").abreviatura, timeB: findTimebyName("Grêmio").abreviatura, escudoA: AppIcons.santos, escudoB: AppIcons.gremio),
    Jogo(timeA: findTimebyName("Palmeiras").abreviatura, timeB: findTimebyName("Flamengo").abreviatura, escudoA: AppIcons.verdao, escudoB: AppIcons.mengo),
    Jogo(timeA: findTimebyName("Bragantino").abreviatura, timeB: findTimebyName("Vasco").abreviatura, escudoA: AppIcons.bragantino, escudoB: AppIcons.vasco),
    Jogo(timeA: findTimebyName("Atlético Mineiro").abreviatura, timeB: findTimebyName("Corinthians").abreviatura, escudoA: AppIcons.atleticoMg, escudoB: AppIcons.timao),
    Jogo(timeA: findTimebyName("Internacional").abreviatura, timeB: findTimebyName("Vitória").abreviatura, escudoA: AppIcons.inter, escudoB: AppIcons.vitoria),
    Jogo(timeA: findTimebyName("Athletico Paranaense").abreviatura, timeB: findTimebyName("Remo").abreviatura, escudoA: AppIcons.athleticoPar, escudoB: AppIcons.remo),
    Jogo(timeA: findTimebyName("Bahia").abreviatura, timeB: findTimebyName("Coritiba").abreviatura, escudoA: AppIcons.bahia, escudoB: AppIcons.coxa),
    Jogo(timeA: findTimebyName("Chapecoense").abreviatura, timeB: findTimebyName("Cruzeiro").abreviatura, escudoA: AppIcons.chape, escudoB: AppIcons.zero),
  ],
),

// 37ª RODADA
Rodada(
  numero: 37,
  data: "2026-11-29",
  jogos: [
    Jogo(timeA: findTimebyName("Fluminense").abreviatura, timeB: findTimebyName("Cruzeiro").abreviatura, escudoA: AppIcons.nense, escudoB: AppIcons.zero),
    Jogo(timeA: findTimebyName("Botafogo").abreviatura, timeB: findTimebyName("Bahia").abreviatura, escudoA: AppIcons.botafogo, escudoB: AppIcons.bahia),
    Jogo(timeA: findTimebyName("São Paulo").abreviatura, timeB: findTimebyName("Remo").abreviatura, escudoA: AppIcons.saoPaulo, escudoB: AppIcons.remo),
    Jogo(timeA: findTimebyName("Corinthians").abreviatura, timeB: findTimebyName("Grêmio").abreviatura, escudoA: AppIcons.timao, escudoB: AppIcons.gremio),
    Jogo(timeA: findTimebyName("Mirassol").abreviatura, timeB: findTimebyName("Athletico Paranaense").abreviatura, escudoA: AppIcons.mirassol, escudoB: AppIcons.athleticoPar),
    Jogo(timeA: findTimebyName("Atlético Mineiro").abreviatura, timeB: findTimebyName("Vasco").abreviatura, escudoA: AppIcons.atleticoMg, escudoB: AppIcons.vasco),
    Jogo(timeA: findTimebyName("Internacional").abreviatura, timeB: findTimebyName("Bragantino").abreviatura, escudoA: AppIcons.inter, escudoB: AppIcons.bragantino),
    Jogo(timeA: findTimebyName("Coritiba").abreviatura, timeB: findTimebyName("Flamengo").abreviatura, escudoA: AppIcons.coxa, escudoB: AppIcons.mengo),
    Jogo(timeA: findTimebyName("Vitória").abreviatura, timeB: findTimebyName("Santos").abreviatura, escudoA: AppIcons.vitoria, escudoB: AppIcons.santos),
    Jogo(timeA: findTimebyName("Chapecoense").abreviatura, timeB: findTimebyName("Palmeiras").abreviatura, escudoA: AppIcons.chape, escudoB: AppIcons.verdao),
  ],
),

// 38ª RODADA
Rodada(
  numero: 38,
  data: "2026-12-02",
  jogos: [
    Jogo(timeA: findTimebyName("Flamengo").abreviatura, timeB: findTimebyName("Chapecoense").abreviatura, escudoA: AppIcons.mengo, escudoB: AppIcons.chape),
    Jogo(timeA: findTimebyName("Vasco").abreviatura, timeB: findTimebyName("Vitória").abreviatura, escudoA: AppIcons.vasco, escudoB: AppIcons.vitoria),
    Jogo(timeA: findTimebyName("Santos").abreviatura, timeB: findTimebyName("Botafogo").abreviatura, escudoA: AppIcons.santos, escudoB: AppIcons.botafogo),
    Jogo(timeA: findTimebyName("Palmeiras").abreviatura, timeB: findTimebyName("Coritiba").abreviatura, escudoA: AppIcons.verdao, escudoB: AppIcons.coxa),
    Jogo(timeA: findTimebyName("Bragantino").abreviatura, timeB: findTimebyName("Fluminense").abreviatura, escudoA: AppIcons.bragantino, escudoB: AppIcons.nense),
    Jogo(timeA: findTimebyName("Cruzeiro").abreviatura, timeB: findTimebyName("Internacional").abreviatura, escudoA: AppIcons.zero, escudoB: AppIcons.inter),
    Jogo(timeA: findTimebyName("Grêmio").abreviatura, timeB: findTimebyName("Mirassol").abreviatura, escudoA: AppIcons.gremio, escudoB: AppIcons.mirassol),
    Jogo(timeA: findTimebyName("Athletico Paranaense").abreviatura, timeB: findTimebyName("São Paulo").abreviatura, escudoA: AppIcons.athleticoPar, escudoB: AppIcons.saoPaulo),
    Jogo(timeA: findTimebyName("Bahia").abreviatura, timeB: findTimebyName("Atlético Mineiro").abreviatura, escudoA: AppIcons.bahia, escudoB: AppIcons.atleticoMg),
    Jogo(timeA: findTimebyName("Remo").abreviatura, timeB: findTimebyName("Corinthians").abreviatura, escudoA: AppIcons.remo, escudoB: AppIcons.timao),
  ],
),


];



