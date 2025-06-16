program breath;

{$mode objfpc}{$H+}
{$DEFINE DYNAMIC_LINK_ALL}

uses
  Interfaces, // this includes the LCL widgetset
  Forms,
  unit1,
  unit2 { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
