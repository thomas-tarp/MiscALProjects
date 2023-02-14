codeunit 50256 "Format 7" implements Formatter
{
    procedure FormatDate(Date: Date): Text
    begin
        exit(Format(Date, 0, 7));
    end;
}