unit UnitCli;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, StdCtrls;

type
  TForm3 = class(TForm)
    ListBox1: TListBox;
    Edit1: TEdit;
    Connect: TButton;
    Send: TButton;
    BtnClose: TButton;
    procedure FormCreate(Sender: TObject);
    procedure SendClick(Sender: TObject);
    procedure ConnectClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
  private
    { Private declarations }
    procedure CliSockRead(Sender: TObject; Socket: TCustomWinSocket);
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}
  var
    ClientSocket1: TClientSocket;

procedure TForm3.CliSockRead(Sender: TObject; Socket: TCustomWinSocket);
begin
  ListBox1.Items.Add(Socket.ReceiveText);
end;

procedure TForm3.BtnCloseClick(Sender: TObject);
begin
  ClientSocket1.Active := false;
  ClientSocket1.Close;
  self.Close;
end;

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
  ClientSocket1.OnRead:= CliSockRead;
end;



procedure TForm3.SendClick(Sender: TObject);
begin
  ClientSocket1.Socket.SendText(Edit1.Text);
  ListBox1.Items.Add( Edit1.Text)
end;

end.
