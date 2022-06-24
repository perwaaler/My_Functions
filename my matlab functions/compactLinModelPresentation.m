function T = compactLinModelPresentation(lm,vars)
% takes a linear mode lm and returns a more print friendly table, showing
% only the parameter names, estimates, and the p-value levels as indicated
% by star notation. If a second argument "vars" is provided, then the
% returned table T contains the variables in vars.

% vars can contain (in any desired order) the following:
% vars = {'Name','Estimate','sigLvl','pValue','Lower','Upper','SE','tStat'};

%% example code:
% vars = {'Name','Estimate','sigLvl'};
if nargin==1
    vars = {'Name','Estimate','sigLvl'};
else
    vars = ['Name','Estimate',vars];
end
%%

sigLvl = getPvalStars(lm.Coefficients.pValue);
T = [dataset2table(lm.Coefficients),table(sigLvl)];
T = subtable(T,vars);


end