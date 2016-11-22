load irisdataset.txt;
dataset=irisdataset;

%random number generation
a=[1 51 103];
b=[50 98 150];
r1 = round((b(1)-a(1))*rand(1)+a(1));
r2 = round((b(2)-a(2))*rand(1)+a(2));
r3 = round((b(3)-a(3))*rand(1)+a(3));
disp(r1);
disp(r2);
disp(r3);
centroid1 = dataset(r1,:);
centroid2 = dataset(r2,:);
centroid3 = dataset(r3,:);

%distance matrix calculation
for m=1:3
    for n=1:150
        if(m==1)
            v=(dataset(n,:)-centroid1).^2;
            d(m,n)=sqrt(v(1)+v(2)+v(3)+v(4));
        elseif(m==2)
            v=(dataset(n,:)-centroid2).^2;
            d(m,n)=sqrt(v(1)+v(2)+v(3)+v(4));
        elseif(m==3)
            v=(dataset(n,:)-centroid3).^2;
            d(m,n)=sqrt(v(1)+v(2)+v(3)+v(4));
        end
    end
end

%group matrix calculation
for m=1:3
    for n=1:150
        if(d(m,n)==min(d(:,n)))
            g(m,n)=1;
        else g(m,n)=0;
        end 
    end
end



a=[0 0 0 0];
newcentroid=[0 0 0 0;0 0 0 0;0 0 0 0];
counter=0;
previous=[0 0 0];
flag=true;
boundarycounter=0;



while flag

%centroid calculation    
for m=1:3
   for n=1:150
       if(g(m,n)==1)
           counter=counter+1;
           a=a+dataset(n,:);
       end  
   end
   
   if(counter ~= 0)
       a=a/counter;
   else newcentroid(m,:)=a;
   end
   %check for loop termination
   groupcounter(m)=counter;
   %new centroid
   newcentroid(m,:)=a;
   
   %re initilize for the next row calculation
   counter=0;
   a=[0 0 0 0];
end

%check for loop termination
if(groupcounter==previous)
    boundarycounter=boundarycounter+1;
    if(boundarycounter==20)
        flag=false;
    end
end
previous=groupcounter;

%distance calculation
for m=1:3
    for n=1:150
            v=(dataset(n,:)-newcentroid(m,:)).^2;
            d(m,n)=sqrt(v(1)+v(2)+v(3)+v(4));
    end
end
%group matrix calculation
for m=1:3
    for n=1:150
        if(d(m,n)==min(d(:,n)))
            g(m,n)=1;
        else g(m,n)=0;
        end 
    end
end


end

disp(groupcounter);











