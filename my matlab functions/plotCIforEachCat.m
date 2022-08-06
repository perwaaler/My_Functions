function plotCIforEachCat(x,y,color)
% plots confidence interval stored as column vectors in y for each
% category in x, where cat is an integer vector in which each integer
% represents a category, such as murmur-grade.
%% example: 
% cat = [1,2];
% CI  = [[1;2],[3.5;4]];
%% preliminary
if isvector(y)
    [meanVals,Icat,yCat,y,x] = findMeanForEachCat(x,y);
end
    
n = length(x);
if nargin==2
    color = strings([1,n]);
    color(:) = "k";
end
if height(y)==3
    y = [y(1,:);y(3,:)];
end
%% 
m = mean(y);
for j=1:length(x)
    col = color2triplet(color(j));
    line([x(j),x(j)],[y(1,j),y(2,j)],'LineWidth',2,'Color','k')
    hold on
    plot(x(j),mean(m(j)),'o','MarkerFaceColor',col,'MarkerEdgeColor','k')
end

end