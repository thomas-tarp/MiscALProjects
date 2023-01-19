codeunit 50102 "ErrorSort" implements ISort
{
    procedure Sort(IntegerList: List of [Integer])
    var
        UnknownAlgorithmErr: Label 'An unknown or no sorting algorithm was chosen.';
    begin
        Error(UnknownAlgorithmErr);
    end;
}