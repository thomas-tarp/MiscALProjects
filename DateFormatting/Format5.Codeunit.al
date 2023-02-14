codeunit 50254 "Format 5" implements Formatter
{
    procedure FormatDate(Date: Date): Text
    begin
        exit(Format(Date, 0, 5));
    end;
}