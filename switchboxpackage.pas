{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit SwitchBoxPackage;

{$warn 5023 off : no warning about unused units}
interface

uses
  SwitchBox, SwitchBoxTheme, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('SwitchBox', @SwitchBox.Register);
end;

initialization
  RegisterPackage('SwitchBoxPackage', @Register);
end.
