unit fmChild2_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  EventBus, EventPacket, PacketListen
  ;

type
  TfmChild2 = class(TForm)
    Memo1: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FPacketListen: TPacketListen;
    procedure log(s:String);
    procedure OnPacket(AEvent: TEventPacket);
  public
    { Public declarations }
    [Subscribe(TThreadMode.Main)]
    procedure OnRxClear(AEvent:TClearPacket);


    [Subscribe(TThreadMode.Main)]
    procedure OnRxEventPacket(AEvent:TEventPacket);

    [Subscribe(TThreadMode.Posting)]
    procedure OnRxEventPacketPosting(AEvent:TEventPacket);

    [Subscribe(TThreadMode.Async)]
    procedure OnRxEventPacketAsync(AEvent:TEventPacket);

  end;

var
  fmChild2: TfmChild2;

implementation

{$R *.dfm}


procedure TfmChild2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FPacketListen.Free;
  FPacketListen := nil;

  GlobalEventBus.Unregister(self);
  Action := caFree;
  Fmchild2 := nil;

end;

procedure TfmChild2.FormCreate(Sender: TObject);
begin
  GlobalEventBus.RegisterSubscriber(self);

  FPacketListen := TPacketListen.Create;
  FPacketListen.OnPacket := OnPacket;
end;

procedure TfmChild2.log(s: String);
begin
  if Memo1.Lines.Count > 20 then Memo1.Lines.Delete( Memo1.Lines.Count - 1 );
  Memo1.Lines.Insert(0, s);
end;


procedure TfmChild2.OnPacket(AEvent: TEventPacket);
var
  LObject:String;
begin
  if AEvent.Data = nil then
  begin
    LObject := 'nil';
  end
  else begin
    LObject := format('%-30s %s.%s ThreadID:%d',[ 'Thread.Background',TCustomForm(TButton(AEvent.Data).Owner).Name, TButton(AEvent.Data).Name, TThread.Current.ThreadID]);
  end;

  TThread.Queue(nil, procedure
  begin
    log( AEvent.Msg + ' : ' + LObject);
    AEvent.Free;
  end);
end;

procedure TfmChild2.OnRxClear(AEvent: TClearPacket);
begin
  Memo1.Lines.Clear;
  AEvent.Free;
end;

procedure TfmChild2.OnRxEventPacket(AEvent: TEventPacket);
var
  LObject:String;
begin
  if AEvent.Data = nil then
  begin
    LObject := 'nil';
  end
  else begin
    LObject := format('%-30s %s.%s ThreadID:%d',[ 'Thread.Main', TCustomForm(TButton(AEvent.Data).Owner).Name, TButton(AEvent.Data).Name, TThread.Current.ThreadID]);
  end;

  log( AEvent.Msg + ' : ' + LObject);
  AEvent.Free;
end;

procedure TfmChild2.OnRxEventPacketAsync(AEvent: TEventPacket);
var
  LObject:String;
begin
  if AEvent.Data = nil then
  begin
    LObject := 'nil';
  end
  else begin
    LObject := format('%-30s %s.%s ThreadID:%d',[ 'Thread.Main.Async', TCustomForm(TButton(AEvent.Data).Owner).Name, TButton(AEvent.Data).Name, TThread.Current.ThreadID]);
  end;

  TThread.Queue(nil, procedure
  begin
    log( AEvent.Msg + ' : ' + LObject);
    AEvent.Free;
  end);

end;

procedure TfmChild2.OnRxEventPacketPosting(AEvent: TEventPacket);
var
  LObject:String;
begin
  if AEvent.Data = nil then
  begin
    LObject := 'nil';
  end
  else begin
    LObject := format('%-30s %s.%s ThreadID:%d',[ 'Thread.Main.Posting', TCustomForm(TButton(AEvent.Data).Owner).Name, TButton(AEvent.Data).Name, TThread.Current.ThreadID]);
  end;

  TThread.Queue(nil, procedure
  begin
    log( AEvent.Msg + ' : ' + LObject);
    AEvent.Free;
  end);

end;

end.
