codeunit 50251 "Format 2" implements Formatter
{
    procedure FormatDate(Date: Date): Text
    begin
        exit(Format(Date, 0, 2));
    end;
}