pageextension 50200 "Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addafter("Post Code")
        {
            part("CustomerMap"; "Customer Map")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
    }
}