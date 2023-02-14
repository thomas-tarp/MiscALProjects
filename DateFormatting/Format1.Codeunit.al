codeunit 50250 "Format 1" implements Formatter
{
    procedure FormatDate(Date: Date): Text
    begin
        exit(Format(Date, 0, 1));
    end;
}