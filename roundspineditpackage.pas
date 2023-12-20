{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit RoundSpinEditPackage;

{$warn 5023 off : no warning about unused units}
interface

uses
  RoundSpinEdit, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('RoundSpinEdit', @RoundSpinEdit.Register);
end;

initialization
  RegisterPackage('RoundSpinEditPackage', @Register);
end.
