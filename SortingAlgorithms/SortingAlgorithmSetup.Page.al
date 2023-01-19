page 50100 "Sorting Algorithm Setup"
{
    ApplicationArea = All;
    Caption = 'Sorting Algorithm Setup';
    PageType = Card;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(SortingAlgorithm; SortingAlgorithm)
                {
                    ApplicationArea = All;
                    Caption = 'Sorting Algorithm';
                    ToolTip = 'Choose a sorting algorithm';
                }
                field(ListSize; ListSize)
                {
                    ApplicationArea = All;
                    Caption = 'List Size';
                    ToolTip = 'Specifies the size of the list of random numbers';
                }
                field(MaxNo; MaxNo)
                {
                    ApplicationArea = All;
                    Caption = 'Maximum Random Number';
                    ToolTip = 'Specifies the maximum number used in the list of random numbers';
                }
            }
            group(Results)
            {
                field(ListValues; ListValueAsText)
                {
                    ApplicationArea = All;
                    Caption = 'List';
                    ToolTip = 'Lists the numbers from the list of random numbers';
                    Editable = false;
                    MultiLine = true;
                }
                field(SortingTime; format(SortingTime))
                {
                    ApplicationArea = All;
                    Caption = 'Sorting Time';
                    ToolTip = 'Specifies the sorting time for the algorithm. Note this is not a reliable performance measure';
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            actionref(PopulateList; PopulateListOfRandomNos) { }
            actionref(SortList; SortListOfRandomNos) { }
            actionref(Clear; ClearListAction) { }
            actionref(UpdateListView; UpdateList) { }
        }
        area(Creation)
        {
            action(PopulateListOfRandomNos)
            {
                ApplicationArea = All;
                Image = CodesList;
                Caption = 'Populate List of Random Nos.';
                ToolTip = 'Populates the list with random numbers according to the settings';

                trigger OnAction()
                var
                    Index: Integer;
                begin
                    Clear(TestList);
                    if ListSize < 0 then
                        exit;
                    for Index := 0 to ListSize - 1 do
                        TestList.Add(Random(MaxNo));

                    UpdateListField();
                end;
            }
        }
        area(Processing)
        {
            action(SortListOfRandomNos)
            {
                ApplicationArea = All;
                Image = SortAscending;
                Caption = 'Sort List';
                ToolTip = 'Sorts the list of random numbers in ascending order';

                trigger OnAction()
                var
                    Sort: Interface ISort;
                    StartDateTime: DateTime;
                begin
                    Sort := SortingAlgorithm;

                    StartDateTime := CurrentDateTime;
                    Sort.Sort(TestList);
                    SortingTime := CurrentDateTime - StartDateTime;

                    UpdateListField();
                end;
            }
            action(ClearListAction)
            {
                ApplicationArea = All;
                Image = ClearLog;
                Caption = 'Clear List';
                ToolTip = 'Clears the list of numbers';

                trigger OnAction()
                begin
                    ClearList();
                end;
            }
            action(UpdateList)
            {
                ApplicationArea = All;
                Image = UpdateDescription;
                Caption = 'Update List';
                ToolTip = 'Updates the view of the list on the page';

                trigger OnAction()
                begin
                    UpdateListField();
                end;
            }
        }
    }

    local procedure UpdateListField()
    var
        TxtBldr: TextBuilder;
        Index, MaxIterations : Integer;
        ExceededCapacity: Boolean;
        ExceededCapacityMsg: Label 'Additional values are not shown...';
    begin
        MaxIterations := TestList.Count;

        if MaxIterations = 0 then begin
            ListValueAsText := '';
            exit;
        end;

        ExceededCapacity := not (MaxIterations <= 100000);
        if ExceededCapacity then
            MaxIterations := 100000;

        TxtBldr.Clear();
        for Index := 1 to MaxIterations do
            TxtBldr.AppendLine(format(TestList.Get(Index)));

        if ExceededCapacity then
            TxtBldr.AppendLine(ExceededCapacityMsg);

        ListValueAsText := TxtBldr.ToText();
    end;

    local procedure ClearList()
    begin
        ListValueAsText := '';
        Clear(TestList);
    end;

    var
        SortingAlgorithm: enum SortingAlgorithm;
        TestList: List of [Integer];
        ListSize, MaxNo : Integer;
        ListValueAsText: Text;
        SortingTime: Duration;
}