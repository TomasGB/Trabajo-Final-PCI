unit UTrie;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

const LETRAS =27;

type
    TPnodo = ^Tnodo;
    TLetras = array [1..LETRAS] of TPnodo;
    Tnodo = record
                FDP:boolean;
                hijos:TLetras;
                end;
    TTrie = TPnodo;

    procedure crearNodo(FDPaux:boolean;var nodo:TPnodo);
    procedure destruirNodo(FDPaux:boolean;var nodo:TPnodo);
    procedure inicializarTrie(var raiz:TTrie);
    function calcularIndice(letra:char):integer;
    procedure InsertarPalabra(palabra:String;raiz:TTrie);
    function BuscarPalabra(palabra:String;raiz:TTrie):Boolean;
    procedure eliminarPalabra(palabra:string;raiz:TTrie);

implementation

procedure crearNodo(FDPaux:boolean;var nodo:TPnodo);
var i:integer;
begin
    new(nodo);
    nodo^.FDP:=FDPaux;
    for i:=1 to LETRAS do
      nodo^.hijos[i]:=nil;
end;

procedure destruirNodo(FDPaux:boolean;var nodo:TPnodo);
var i:integer;
begin
    nodo.FDP:=False;
    for i:=1 to letras do
    begin
         dispose(nodo.hijos[i]);
         nodo.hijos[i]:=nil;
    end;
end;

procedure inicializarTrie(var raiz:TTrie);
var i:Integer;
begin
    new(raiz);
    for i:=1 to LETRAS do
      begin
            raiz^.FDP:=False;
            raiz^.hijos[i]:=Nil;
      end;
end;

function calcularIndice(letra:char):integer;
//calcula la posicion de la letra en el arreglo TLetras
begin

    if letra = '�' then calcularIndice:=15
    else
    begin
        if (Ord(letra)-96) < 15 then calcularIndice:=Ord(letra)-96
        else calcularIndice:=(Ord(letra)-96)+1;
    end;

end;

procedure InsertarPalabra(palabra:String;raiz:TTrie);
var i,long,pos:Integer;
    FDPaux:Boolean;
    nuevoNodo:TPnodo;
begin
    long:=Length(palabra);

    for i:=1 to long do
        begin

            pos:=calcularIndice(palabra[i]);

            if i = long then FDPaux:=True
            else FDPaux:=False;

            if (raiz^.hijos[pos] = Nil) then
            begin
                crearNodo(FDPaux,nuevoNodo);
                raiz^.hijos[pos]:=nuevoNodo;
                raiz:=raiz^.hijos[pos];
            end
            else
                begin
                    if (i=long) then
                        begin
                            raiz:=raiz^.hijos[pos];
                            raiz^.FDP := FDPaux;
                        end
                    else raiz:=raiz^.hijos[pos];
                end;
        end;
end;


function BuscarPalabra(palabra:String;raiz:TTrie):Boolean;
var i,long,indice:integer;
    bool:boolean;

begin
    long:=Length(palabra);
    bool:=True;

    for i:=1 to long do
    begin
         indice:=calcularIndice(palabra[i]);

          if(raiz^.hijos[indice] = nil)  then bool:=False
          else
              begin
              raiz:=raiz^.hijos[indice];
                    if (i=long) and (raiz.FDP = False) then bool:=False
                    else bool:=True;

              end;


    end;
    BuscarPalabra:=bool;
end;

procedure eliminarPalabra(palabra:string;raiz:TTrie);
var i,j,k,long,indice:Integer;
    masPalabras:Boolean;

begin
    long:=Length(palabra);
    masPalabras:=False;
    j:=1;
    k:=long;

    // Este bucle lleva la raiz a la ultima letra
    for i:=1 to long do
    begin
        indice:=calcularIndice(palabra[i]);
        raiz:=raiz^.hijos[indice];
    end;

    while (k>=1) do
    begin

        // controla si el nodo de la ultima letra tiene hijos
        while masPalabras = False do
        begin
            if raiz^.hijos[j] <> Nil  then masPalabras:=True
            else
                begin
                    raiz.FDP:=False;
                end;
            j:=j+1;
        end;

        if masPalabras = False then destruirNodo(False,raiz);

       k:=k-1;
    end;

    end;

end.
