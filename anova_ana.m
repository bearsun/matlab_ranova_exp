% replicate Russell's SPSS result in Matlab
%% repeated measure 2x2x2 (sess x room x side)
load('cor.mat');
within = table([1,1,1,1,2,2,2,2]',[1,1,2,2,1,1,2,2]',[1,2,1,2,1,2,1,2]', ...
    'VariableNames', {'sess', 'room', 'side'});
within.sess = categorical(within.sess);
within.room = categorical(within.room);
within.side = categorical(within.side);

rnovatbls = cell(5,1);
for i = 1:5
    tbl = table(srss1(:,i), srds1(:,i), drss1(:,i) ,drds1(:,i), ...
        srss2(:,i), srds2(:,i), drss2(:,i) ,drds2(:,i), ...
    'VariableNames', {'srss1', 'srds1', 'drss1', 'drds1', ...
                    'srss2', 'srds2', 'drss2', 'drds2'});
    rm = fitrm(tbl, 'srss1-drds2 ~ 1', ...
        'WithinDesign', within);
    rnovatbls{i} = ranova(rm, 'WithinModel', ...
        'sess*room*side');
end

%% repeated measure 2x2 (sess x room)

within = table(categorical([1,1,2,2])', categorical([1,2,1,2])', ...
    'VariableNames', {'sess', 'room'});

rnovatbls = cell(5,1);
for i = 1:5
    tbl = table(srds1(:,i), drds1(:,i), srds2(:,i), drds2(:,i), ...
    'VariableNames', {'srds1', 'drds1', 'srds2', 'drds2'});
    rm = fitrm(tbl, 'srds1-drds2 ~ 1', ...
        'WithinDesign', within);
    rnovatbls{i} = ranova(rm, 'WithinModel', ...
        'sess*room');
end