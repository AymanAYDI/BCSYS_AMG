namespace BCSYS.AMGALLOIS.Basic;

using Microsoft.Sales.Customer;
tableextension 50000 Customer extends Customer //18
{
    fields
    {
        field(50000; TEST; Integer)
        {
            Caption = 'TEST', Comment = 'FRA="TEST FRA"';
        }
    }
}
