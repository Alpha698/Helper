unit Userver;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ScktComp,ShellApi;

type
  TForm3 = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MyClientRead(Sender:TObject; Socket:TCustomWinSocket);
    procedure MyClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure MyClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
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
 ServerSocket1.OnClientConnect:= MyClientConnect;
  ServerSocket1.OnClientDisconnect:= MyClientDisconnect;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
ServerSocket1.Active := false;
ServerSocket1.Close;
Close;
end;

procedure TForm3.MyClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
ListBox1.Items.Add ('Клиент отключен: ' + Socket.RemoteHost + ' (' + Socket.RemoteAddress + ')' );
end;


procedure TForm3.MyClientConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
ListBox1.Items.Add ('Подключен клиент: ' + Socket.RemoteHost + ' (' + Socket.RemoteAddress + ')' );
end;


procedure TForm3.MyClientRead(Sender:TObject; Socket:TCustomWinSocket);
var
strCommand, strFile, strFeedback: string;
begin
  strCommand := Socket.ReceiveText; // Читаем данные от клиента
  ListBox1.Items.Add ('Клиент: ' + Socket.RemoteAddress + ': ' + strCommand);
  // Извлекаем имя файла (Первые 5 символов содержат - тип передаваемой информации)
  strFile := Copy (strCommand, 6, Length (strCommand) - 5);
  if Pos ('EXEC!', strCommand) = 1 then begin // Исполняемый файл
    if FileExists(strFile) and ( ShellExecute (0,'Open', pChar (strFile), '', '',sw_ShowNormal) > 32) then
      strFeedback := 'Программа ' + strFile + ' Запущена'
    else
      strFeedback := 'Ошибка: файл ' + strFile +  ' не найден';
    Socket.SendText (strFeedback);
  end
  else //begin
    if Pos ('TEXT!', strCommand) = 1 then
    begin // Текстовый файл
      if FileExists (strFile) then begin
        strFeedback := 'TEXT!';
        Socket.SendText (strFeedback);
        Socket.SendStream (TFileStream.Create ( strFile, fmOpenRead or fmShareDenyWrite));
      end
      else begin
        strFeedback := 'Ошибка: файл ' + strFile + ' файл не найден';
        Socket.SendText (strFeedback);
      end;
    end
  else
    if Pos ('BITM!', strCommand) = 1 then
    begin // картинка
      if FileExists (strFile) then begin
          strFeedback := 'BITM!';
          Socket.SendText (strFeedback);
          Socket.SendStream (TFileStream.Create ( strFile, fmOpenRead or fmShareDenyWrite));
      end
  else
  begin
      strFeedback := 'Ошибка файл  ' + strFile + ' не найден';
      Socket.SendText (strFeedback);
  end;
end;
end;

end.
