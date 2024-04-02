unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Forms, Dialogs, ExtCtrls, StdCtrls, Classes;

type

  { TAboutForm }

  TAboutForm = class(TForm)
    CloseButton: TButton;
    DescrText: TStaticText;
    AuthorLabel: TLabel;
    TittleLable: TLabel;
    VersionLabel: TLabel;
    LogoImage: TImage;
    procedure CloseOnClick(Sender: TObject);
  private

  public

  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.lfm}

{ TAboutForm }

procedure TAboutForm.CloseOnClick(Sender: TObject);
begin
  Self.Close;
end;

end.

