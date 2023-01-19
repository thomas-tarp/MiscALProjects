codeunit 50101 "MergeSort" implements ISort
{
    procedure Sort(IntegerList: List of [Integer])
    var
        ListLength: Integer;
    begin
        ListLength := IntegerList.Count;
        if ListLength <= 1 then
            exit;

        MergeSort(IntegerList, 1, ListLength);
    end;

    local procedure MergeSort(IntegerList: List of [Integer]; LeftStartIndex: integer; RightEndIndex: Integer);
    var
        MiddleIndex: integer;
    begin
        if LeftStartIndex >= RightEndIndex then
            exit;

        MiddleIndex := Round(((LeftStartIndex - 1 + RightEndIndex) / 2), 1, '>');
        MergeSort(IntegerList, LeftStartIndex, MiddleIndex);
        MergeSort(IntegerList, MiddleIndex + 1, RightEndIndex);
        MergeHalves(IntegerList, LeftStartIndex, RightEndIndex);
    end;

    local procedure MergeHalves(IntegerList: List of [Integer]; LeftStartIndex: integer; RightEndIndex: Integer);
    var
        TempList: List of [Integer];
        LeftEndIndex, i, j : integer;
    begin
        LeftEndIndex := Round(((RightEndIndex + LeftStartIndex - 1) / 2), 1, '>');
        i := LeftStartIndex;
        j := LeftEndIndex + 1;

        while (i <= LeftEndIndex) and (j <= RightEndIndex) do
            if IntegerList.Get(i) < IntegerList.Get(j) then begin
                TempList.Add(IntegerList.Get(i));
                i += 1;
            end else begin
                TempList.Add(IntegerList.Get(j));
                j += 1;
            end;

        while i < LeftEndIndex + 1 do begin
            TempList.Add(IntegerList.Get(i));
            i += 1;
        end;

        while j < RightEndIndex + 1 do begin
            TempList.Add(IntegerList.Get(j));
            j += 1;
        end;

        j := LeftStartIndex;
        for i := 1 to TempList.Count do begin
            IntegerList.Set(j, TempList.Get(i));
            j += 1;
        end;
    end;
}