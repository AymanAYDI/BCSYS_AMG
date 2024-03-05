namespace BCSYS.AMGALLOIS.Basic;
tableextension 50031 ItemCrossReference extends "Item Cross Reference" //5717
{
    fields
    {

        //Unsupported feature: Code Insertion on ""Item No."(Field 1)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        //DEB DELPHI MHR 18/01/2019
        FRempliDescriptionArt(Rec);
        //FIN DELPHI MHR 18/01/2019
        */
        //end;


        //Unsupported feature: Code Modification on ""Cross-Reference Type"(Field 4).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ("Cross-Reference Type" <> xRec."Cross-Reference Type") AND
           (xRec."Cross-Reference Type" <> xRec."Cross-Reference Type"::" ") OR
           ("Cross-Reference Type" = "Cross-Reference Type"::"Bar Code")
        Then
          "Cross-Reference Type No." := '';
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
        //DEB DELPHI MHR 18/01/2019
        FRempliDescriptionArt(Rec);
        //FIN DELPHI MHR 18/01/2019
        */
        //end;


        //Unsupported feature: Code Insertion on ""Cross-Reference Type No."(Field 5)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        //DEB DELPHI MHR 18/01/2019
        FRempliDescriptionArt(Rec);
        //FIN DELPHI MHR 18/01/2019
        */
        //end;


        //Unsupported feature: Code Insertion on ""Cross-Reference No."(Field 6)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        //DEB DELPHI MHR 18/01/2019
        FRempliDescriptionArt(Rec);
        //FIN DELPHI MHR 18/01/2019
        */
        //end;
    }

    local procedure FRempliDescriptionArt(var Rec: Record "5717")
    var
        LRecItem: Record "27";
    begin
        //DEB DELPHI MHR 18/01/2019
        if LRecItem.Get(Rec."Item No.") then begin
            Rec.Description := LRecItem.Description;
            Rec."Description 2" := LRecItem."Description 2";
        end;
        //FIN DELPHI MHR 18/01/2019
    end;
}

