unit PacketListen;

interface

uses
  system.Classes, System.Threading,
  EventBus, EventPacket;

Type
  TOnEventPacket = procedure(AEvent:TEventPacket) of Object;
  TPacketListen = Class
    private
      FOnPacket: TOnEventPacket;
    public
      constructor Create;
      Destructor  Destory;
      [Subscribe(TThreadMode.Background)]
      procedure OnRxThread(AEvent: TEventPacket);

      property OnPacket:TOnEventPacket read FOnPacket Write FOnPacket;
  End;

implementation

{ TPacketListen }

constructor TPacketListen.Create;
begin
  GlobalEventBus.RegisterSubscriber(self);
end;

destructor TPacketListen.Destory;
begin
  GlobalEventBus.Unregister(self);
end;


procedure TPacketListen.OnRxThread(AEvent: TEventPacket);
begin
  if Assigned(FOnPacket) then
  begin
    FOnPacket(AEvent);
  end;
end;

end.
