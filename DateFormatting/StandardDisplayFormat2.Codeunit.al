codeunit 50260 "Standard Display Format 2" implements Formatter
{
    procedure FormatDate(Date: Date): Text
    begin
        exit(Format(Date, 0, '<Standard Format,1>'));
    end;
}