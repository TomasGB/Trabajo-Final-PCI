unit UNodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
     TPnodo = ^Tnodo;

     Tnodo = record
                dato: string;
                FinPalabra:boolean;
                hijos: TPnodo;
            end;

implementation

procedure crearNodo( var hijo:TPnodo);
{
Crea un nodo vac�o que es fin de palabra y no posee hijos.

     |                  |
     | letra: '';       |
---> | finPalabra:True  |--�
     |                  |  X
}
begin
    new(hijo);
    hijo^.hijos:=nil;
end;

procedure destruirNodo( var hijo:TPnodo);
{
Hace vac�a letra, deja finDePalabra como False,
hace dispose para liberar la memoria y lo deja
apuntando a nil para evitar fugas de memoria.

     |                    |
     | letra: '';         |
     | finPalabra:False   |--�
     |                    |  X
}
begin
    hijo^.hijos:=nil;
    dispose(hijo);
    hijo:= nil;
end;

procedure inicializarNodo(palabra:string;var nodo:Tnodo);
var letra:char;
begin
      letra:= palabra[length(palabra)]; // [length(palabra)] para ir tomando la ultima letra
      nodo.dato:=letra;
      nodo.FinPalabra:=False;
      nodo.hijos:=nil;
end;

procedure insertarNodo(hijoAInsertar:TPnodo; palabra:string; var padre:Tpnodo);
{
Crea el
}
var i:integer;
    l:char;
begin

    {i:=1;
    while (padre^.hijos <> nil) do
    begin
        l:= palabra[i];
        if padre^.dato = l then
            begin
                padre^.hijos:=padre^.hijos;
                i:=i+1;
            end
        else padre^.hijos:=hijoAInsertar;
    end;}
    

end;

end.
 