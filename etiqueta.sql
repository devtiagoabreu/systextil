if tipo_tecido = 2
then begin 
    print 'A550,220,1,1,1,1,N,"Cor"'
    print 'A535,220,1,3,1,1,N,"' /+ prodcai_subgrupo /+ '"'

    print 'A550,230,1,1,1,1,N,"Cor\Estampa:"'
    print 'A550,230,1,2,2,1,N,"' /+ prodcai_item /+ '"'
end 
else begin 
    print 'A550,220,1,1,1,1,N,"Cor"'
    print 'A535,220,1,3,1,1,N,"' /+ prodcai_item /+ '"'
end
   


if (tamanho_ref = 'CRU') OR (tamanho_ref = 'TIN')
 then begin
    print 'A550,220,1,1,1,1,N,"Sit:"'
    print 'A535,220,1,3,1,1,N,"' /+ prodcai_subgrupo /+ '"'

    print 'A550,230,1,1,1,1,N,"Cor:"'
    print 'A550,230,1,2,2,1,N,"' /+ prodcai_item /+ '"'
end 
else begin 
    print 'A550,220,1,1,1,1,N,"Cor"'
    print 'A535,220,1,3,1,1,N,"' /+ prodcai_subgrupo /+ '"'

    print 'A550,230,1,1,1,1,N,"Estampa:"'
    print 'A550,230,1,2,2,1,N,"' /+ prodcai_item /+ '"'
end
   