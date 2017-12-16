unit UnitCli;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, StdCtrls, Unit1, Unit2;

type
    TCliStatus = (csIdle, csBitmap, csText, csError);
  TForm3 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    CheckBox1: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
//    procedure SendClick(Sender: TObject);
    procedure ConnectClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  //  procedure BtnCloseClick(Sender: TObject);
  private
    { Private declarations }
     CliStatus: TCliStatus;
     Buffer: array[0..9999] of ANSIChar;
procedure Conn(Sender: TObject; Socket: TCustomWinSocket);
procedure DisConn(Sender: TObject; Socket: TCustomWinSocket);
procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}
  var
    ClientSocket1: TClientSocket;




procedure TForm3.ConnectClick(Sender: TObject);
begin
  if not ClientSocket1.Active then
  ClientSocket1.Active := true;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  ClientSocket1:= TClientSocket.Create(self);
  ClientSocket1.Address:='127.0.0.1';
  ClientSocket1.Port:= 777;
  ClientSocket1.OnRead:= ClientSocket1Read;
  ClientSocket1.OnConnect:= conn;
  ClientSocket1.OnDisconnect:= disconn;
  CliStatus := csIdle;

end;


procedure TForm3.Conn(Sender: TObject; Socket: TCustomWinSocket);
begin
Caption:= 'Связь установлена';
end;

procedure TForm3.DisConn(Sender: TObject; Socket: TCustomWinSocket);
begin
Caption:= 'Связь разорван';
end;

procedure TForm3.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
var
strIn: string;
Stream: TMemoryStream;
nReceived: Integer;
//Buffer: string;
begin
case CliStatus of
csIdle: // Проверка, что передал сервер
begin
Socket.ReceiveBuf(Buffer, 5);
strIn := Copy(Buffer, 1, 5);
if strIn = 'TEXT!' then
CliStatus := csText
else if strIn = 'BITM!' then
CliStatus := csBitmap
else if strIn = 'ERROR' then
CliStatus := csError;
End;
csError: //Показать сообщение (обычно об ошибке)
begin
ShowMessage (Socket.ReceiveText);
cliStatus := csIdle;
end;
csText:  //Показать текстовый файл
begin
with TForm1.Create (Application) do begin
Memo1.Text := Socket.ReceiveText;
Show;
end;
cliStatus := csIdle;
end;
csBitmap: //Чтение растровой картинки
with TForm2.Create (Application) do begin
Stream := TMemoryStream.Create;
Screen.Cursor := crHourglass;
try
while True do begin
nReceived := Socket.ReceiveBuf (Buffer, sizeof (Buffer));
if nReceived <= 0 then
Break
else
Stream.Write (Buffer, nReceived);
Sleep (200);// задержка на 200 миллисекунд
end;
Stream.Position := 0;
Image1.Picture.Bitmap.LoadFromStream (Stream);
finally
Stream.Free;
 Screen.Cursor := crDefault;
end;
Show;
cliStatus := csIdle;
end;
end; // Конец оператора case
end;


procedure TForm3.Button1Click(Sender: TObject);
begin
  ClientSocket1.Socket.SendText ('TEXT!' + Edit2.Text);
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
 ClientSocket1.Socket.SendText ('BITM!' + Edit2.Text);
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
   ClientSocket1.Socket.SendText ('EXEC!' + Edit2.Text);
end;

procedure TForm3.CheckBox1Click(Sender: TObject);
begin
   ClientSocket1.Active := CheckBox1.Checked;
end;

end.
