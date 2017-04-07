function [] = visualize_atom_distribution(H,namestr)

%Make picture of the atom distribution
%Make image of the original V
%find row and column indices of the nonzeros of H
%Bar-plot of atom distribution
DISTR=figure

%find row and column indices of the nonzeros of H
Hones=H;
Hones(Hones~=0.0)=1.0;
na=sum(Hones')';
sumna=sum(na);
na=100*(na/sumna);
bar(na);

%change suitable xtick density
tickdensity=10;
for i=1:length(na)

        if(i==1)
                str=num2str(i)
                %vec2={str};
                vec2=[{str}];
                continue;
        end

        if(~rem(i,tickdensity))
                str=num2str(i);
                %vec2={vec2,str};
                vec2=[vec2 {str}];
        else
                %vec2={vec2, ''};
                vec2=[vec2 ''];
        end
end

vec2;
set(gca,'xtickLabel',vec2);
axis([0 length(na)+10]);
%grid on;
xlabel('Atom index');
ylabel('Frequency %');
%tightPos=get(gca,'TightInset');
%noDeadSpacePos = [0 0 1 1] + [tightPos(1:2) -(tightPos(1:2) + ...
%  tightPos(3:4))];
%set(gca,'Position',noDeadSpacePos);
%str=sprintf('atom_distribution_rec_%.2f.jpg',noiselevel);
%saveas(DISTR,str,'jpg');
print('-depsc',namestr);

end
