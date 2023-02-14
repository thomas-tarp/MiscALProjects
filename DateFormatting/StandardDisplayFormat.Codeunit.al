codeunit 50259 "Standard Display Format" implements Formatter
{
    procedure FormatDate(Date: Date): Text
    begin
        exit(Format(Date, 0, '<Standard Format,0>'));
    end;
}