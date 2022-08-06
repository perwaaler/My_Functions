function [tg_new,badQ] = importAndProcessTextGrids_ex(tg_id, annotator, folderInd, varargin)


%% optional name-value-pair arguments:
p = inputParser;
addOptional(p, 'ShowStates', false, @(x) islogical(x));
parse(p,varargin{:});
% Get the number of name-value-pair arguments:
NnumvalPairArgs = numel(p.Parameters) - numel(p.UsingDefaults);

%% optional positional arguments
% get number of positional arguments:
NposNargin = nargin - 2*NnumvalPairArgs;
if NposNargin==1
    annotator = "_anno";
    folderInd = folderIndex(tg_id);
elseif NposNargin==2
    folderInd = folderIndex(tg_id);
end

%% code:
% read in the tex grid file:
tg_new = readTextGrid(tg_id, annotator, folderInd);

% check for bad quality:
if tg_new.tier{5}.Label{:}=="bq" || numel(tg_new.tier{1}.Label)==1
    badQ = true;
    
else
    
    badQ = false;
    
    % Relabel annotations and check for manual corrections:
    if annotator=="_anno"
        % show states before:
        if p.Results.ShowStates
            string(tg_new.tier{1}.Label)
        end
        % manual corrections:
        tg_new = manualCorrections(tg_id,tg_new);
        % relabel:
        [tg_new,suspSymbols] = relabelAnnotations(tg_new);
        % display suspicious symbols in labels if they are found:
        if ~isempty(suspSymbols)
            warning("Labels contains the following unusual symbols: %s",suspSymbols)
        end
        % show states after alterations:
        if p.Results.ShowStates
            string(tg_new.tier{1}.Label) 
        end
    end

    % Fill in the empty labels:
    tg_new = fillInSystoleAndDiastole(tg_new);
end

Ntiers = numel(tg_new.tier{1}.Label);
Nintervals = numel(tg_new.tier{1}.T1);
if Ntiers ~= Nintervals
    warning('There are %g intervals and %g labels',Nintervals,Ntiers)
    myunique(string(tg_new.tier{1}.Label))
end
%#ok<*NOPRT>
end