codeunit 50253 "Format 4" implements Formatter
{
    procedure FormatDate(Date: Date): Text
    begin
        exit(Format(Date, 0, 4));
    end;
}