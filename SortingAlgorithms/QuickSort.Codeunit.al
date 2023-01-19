codeunit 50103 "QuickSort" implements ISort
{
    procedure Sort(IntegerList: List of [Integer])
    var
        Length: Integer;
    begin
        Length := IntegerList.Count;
        SortPivotToMedianOfThree(IntegerList, Length);
        QuickSort(IntegerList, 1, Length);
    end;

    local procedure SortPivotToMedianOfThree(IntegerList: List of [Integer]; Length: Integer)
    var
        PivotIndex, PivotValue : Integer;
    begin
        PivotIndex := Round(((Length) / 2), 1, '>');
        PivotValue := IntegerList.Get(PivotIndex);

        if IntegerList.Get(1) > PivotValue then
            Swap(IntegerList, 1, PivotIndex);
        if PivotValue > IntegerList.Get(Length) then
            Swap(IntegerList, PivotIndex, Length);
    end;

    local procedure QuickSort(IntegerList: List of [Integer]; Left: Integer; Right: Integer)
    var
        PivotValue, Index : Integer;
    begin
        if Left >= Right then
            exit;

        PivotValue := IntegerList.Get(Round(((Left + Right - 1) / 2), 1, '>'));

        Index := Partition(IntegerList, Left, Right, PivotValue);
        QuickSort(IntegerList, Left, Index);
        QuickSort(IntegerList, Index + 1, Right);
    end;

    local procedure Partition(IntegerList: List of [Integer]; Left: Integer; Right: Integer; Pivot: Integer): Integer
    begin
        while Left <= Right do begin
            while IntegerList.Get(Left) < Pivot do
                Left += 1;

            while IntegerList.Get(Right) > Pivot do
                Right -= 1;

            if Left <= Right then begin
                Swap(IntegerList, Left, Right);
                Left += 1;
                Right -= 1;
            end;
        end;
        exit(Left - 1);
    end;

    local procedure Swap(IntegerList: List of [Integer]; Left: Integer; Right: Integer)
    var
        LeftValue: Integer;
    begin
        LeftValue := IntegerList.Get(Left);
        IntegerList.Set(Left, IntegerList.Get(Right));
        IntegerList.Set(Right, LeftValue);
    end;
}
