codeunit 50255 "Format 6" implements Formatter
{
    procedure FormatDate(Date: Date): Text
    begin
        exit(Format(Date, 0, 6));
    end;
}