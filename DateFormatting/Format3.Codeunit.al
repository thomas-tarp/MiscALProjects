codeunit 50252 "Format 3" implements Formatter
{
    procedure FormatDate(Date: Date): Text
    begin
        exit(Format(Date, 0, 3));
    end;
}