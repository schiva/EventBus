unit fmChild1_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  EventPacket, EventBus, Vcl.StdCtrls
  ;

type
  TfmChild1 = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure log(s:String);
  public
    { Public declarations }
    [Subscribe(TThreadMode.Main)]
    procedure OnRxClear(AEvent:TClearPacket);

    [Subscribe(TThreadMode.Main)]
    procedure OnRxEventPacket(AEvent:TEventPacket);

    [Subscribe(TThreadMode.Main, 'TestContext')]
    procedure OnRxEventPacketCotext(AEvent:TEventPacket);

  end;

var
  fmChild1: TfmChild1;

implementation


uses
  RttiUtilsU, System.Rtti;

{$R *.dfm}

procedure TfmChild1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GlobalEventBus.Unregister(self);
  Action := caFree;
  Fmchild1 := nil;
end;

procedure TfmChild1.FormCreate(Sender: TObject);
begin
  GLobalEventBus.RegisterSubscriber(self);
end;

procedure TfmChild1.log(s: String);
begin
  if Memo1.Lines.Count > 20 then Memo1.Lines.Delete( Memo1.Lines.Count - 1 );
  Memo1.Lines.Insert(0, s);
end;


procedure TfmChild1.OnRxClear(AEvent: TClearPacket);
begin
  Memo1.Lines.Clear;
  AEvent.Free;
end;

procedure TfmChild1.OnRxEventPacket(AEvent: TEventPacket);
var
  LObject:String;
begin
  if AEvent.Data = nil then
  begin
    LObject := 'nil';
  end
  else begin
    LObject := format('%-30s %s.%s ThreadID:%d',[ 'Thread.Main',TCustomForm(TButton(AEvent.Data).Owner).Name, TButton(AEvent.Data).Name, TThread.Current.ThreadID]);
  end;

  log( AEvent.Msg + ' : ' + LObject);
  AEvent.Free;
end;

procedure TfmChild1.OnRxEventPacketCotext(AEvent: TEventPacket);
var
  LObject:String;
begin
  if AEvent.Data = nil then
  begin
    LObject := 'nil';
  end
  else begin
    LObject := format('%-30s %s.%s ThreadID:%d',[ 'Thread.Main.Context',TCustomForm(TButton(AEvent.Data).Owner).Name, TButton(AEvent.Data).Name, TThread.Current.ThreadID]);
  end;

  log( AEvent.Msg + ' : ' + LObject);
  AEvent.Free;
end;

end.
