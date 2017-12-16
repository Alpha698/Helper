unit Userver;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ScktComp;

type
  TForm3 = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MyClientRead(Sender:TObject; Socket:TCustomWinSocket);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  ServerSocket1: TServerSocket;


implementation

{$R *.dfm}



procedure TForm3.Button2Click(Sender: TObject);
begin
 ServerSocket1.Active:=True;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
 ServerSocket1:= TServerSocket.Create(self);
 ServerSocket1.Port:=777;
 ServerSocket1.OnClientRead:= MyClientRead;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
ServerSocket1.Active := false;
ServerSocket1.Close;
Close;
end;

procedure TForm3.MyClientRead(Sender:TObject; Socket:TCustomWinSocket);
var
s: string;
i: integer; 
begin
{формирование строки в формате номер>сообщение }
    s:= IntToStr(Socket.SocketHandle) + '> ' + Socket.ReceiveText;
{добавить  сообщение в текущий список:}
   ListBox1.Items.Add (s) ;
{перебор установленных соединений:}
for i := 0 to ServerSocket1.Socket.ActiveConnections-1  do
{проверка на совпадение идентификатора очередного сокета с идентификатором сокета, приславшего сообщение}
if ServerSocket1.Socket.Connections[i].SocketHandle  <> Socket.SocketHandle  then
{если совпадения  нет, то послать очередной клиентской программе новое сообщение}
ServerSocket1.Socket.Connections[i].SendText(s);
//ServerSocket1.Socket.ActiveConnections[i].SendText(s);
end;


end.
