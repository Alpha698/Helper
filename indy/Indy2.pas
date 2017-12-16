unit Indy2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer;

type
  TForm1 = class(TForm)
    IdTCPServer1: TIdTCPServer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IdTCPServer1Connect(AThread: TIdPeerThread);
    procedure IdTCPServer1Execute(AThread: TIdPeerThread);
  private
    PostIndexList: TStrings;

  public
    { Public declarations }
  end;

var
  form1: TForm1;

implementation
  procedure TForm1.IdTCPServer1Connect(AThread: TIdPeerThread);
begin
  AThread.Connection.WriteLn('Indy Post Index Server Ready.');
end;

procedure TForm1.IdTCPServer1Execute(AThread: TIdPeerThread);
var
  sCommand,indx: string;
begin
  with AThread.Connection do begin
    sCommand := ReadLn;
    if SameText(sCommand, 'QUIT') then begin
      Disconnect;
    end else if SameText(Copy(sCommand, 1, 10), 'PostIndex ') then begin
      indx := Copy(sCommand, 11, MaxInt);
      WriteLn(PostIndexList.Values[Copy(sCommand, 11, MaxInt)]);
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 PostIndexList := TStringList.Create;
 PostIndexList.LoadFromFile(ExtractFilePath(Application.EXEName) + 'PostIndex.dat');
end;
 
procedure TForm1.FormDestroy(Sender: TObject);
begin
 PostIndexList.Free;
end;

{$R *.dfm}

end.
