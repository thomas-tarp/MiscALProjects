pageextension 50201 "Vendor Card Ext" extends "Vendor Card"
{
    layout
    {
        addafter("Post Code")
        {
            part("VendorMap"; "Vendor Map")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
    }
}